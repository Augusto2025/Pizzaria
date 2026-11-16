using System;
using System.Globalization;
using System.IO;
using System.Windows;
using System.Windows.Data;
using System.Windows.Media;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using PizzariaDesktop.Data;
using PizzariaDesktop.Models;
using PizzariaDesktop.Services;
using PizzariaDesktop.Data.Repositories;
using DotNetEnv;

namespace PizzariaDesktop
{
    public partial class App : Application
    {
        public static IServiceProvider Services { get; private set; } = null!;
        public static IConfiguration Configuration { get; private set; } = null!;

        protected override async void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);

            // Configuração
            Configuration = BuildConfiguration();

            // Configura serviços
            var serviceCollection = new ServiceCollection();
            serviceCollection.AddPizzariaServices(Configuration);
            Services = serviceCollection.BuildServiceProvider();

            // Inicializa ServiceLocator
            ServiceLocator.Initialize(Services);

            // Inicializa banco de dados
            await InitializeDatabaseAsync();

            // Carrega recursos e conversores
            InitializeComponent();

            // Global exception handlers
            this.DispatcherUnhandledException += App_DispatcherUnhandledException;
            AppDomain.CurrentDomain.UnhandledException += CurrentDomain_UnhandledException;
            TaskScheduler.UnobservedTaskException += TaskScheduler_UnobservedTaskException;
        }

        private void App_DispatcherUnhandledException(object sender, System.Windows.Threading.DispatcherUnhandledExceptionEventArgs e)
        {
            var ex = e.Exception;
            System.Diagnostics.Debug.WriteLine($"=== UNHANDLED UI EXCEPTION ===");
            System.Diagnostics.Debug.WriteLine($"Message: {ex.Message}");
            System.Diagnostics.Debug.WriteLine($"StackTrace: {ex.StackTrace}");
            if (ex.InnerException != null)
            {
                System.Diagnostics.Debug.WriteLine($"Inner: {ex.InnerException.Message}");
                System.Diagnostics.Debug.WriteLine($"Inner StackTrace: {ex.InnerException.StackTrace}");
            }

            MessageBox.Show($"Erro inesperado: {ex.Message}\n\nVerifique o Output/Debug para detalhes.", "Erro Crítico",
                MessageBoxButton.OK, MessageBoxImage.Error);

            e.Handled = true; // Prevent app crash
        }

        private void CurrentDomain_UnhandledException(object sender, UnhandledExceptionEventArgs e)
        {
            var ex = e.ExceptionObject as Exception;
            System.Diagnostics.Debug.WriteLine($"=== UNHANDLED DOMAIN EXCEPTION ===");
            System.Diagnostics.Debug.WriteLine($"Message: {ex?.Message}");
            System.Diagnostics.Debug.WriteLine($"StackTrace: {ex?.StackTrace}");
            if (ex?.InnerException != null)
            {
                System.Diagnostics.Debug.WriteLine($"Inner: {ex.InnerException.Message}");
                System.Diagnostics.Debug.WriteLine($"Inner StackTrace: {ex.InnerException.StackTrace}");
            }
        }

        private void TaskScheduler_UnobservedTaskException(object? sender, UnobservedTaskExceptionEventArgs e)
        {
            var ex = e.Exception;
            System.Diagnostics.Debug.WriteLine($"=== UNOBSERVED TASK EXCEPTION ===");
            System.Diagnostics.Debug.WriteLine($"Message: {ex.Message}");
            System.Diagnostics.Debug.WriteLine($"StackTrace: {ex.StackTrace}");
            if (ex.InnerException != null)
            {
                System.Diagnostics.Debug.WriteLine($"Inner: {ex.InnerException.Message}");
                System.Diagnostics.Debug.WriteLine($"Inner StackTrace: {ex.InnerException.StackTrace}");
            }
            e.SetObserved(); // Prevent crash
        }

        private IConfiguration BuildConfiguration()
        {
            var basePath = AppDomain.CurrentDomain.BaseDirectory;

            // Carrega .env se existir ANTES de adicionar environment variables
            var envPath = Path.Combine(basePath, ".env");
            if (File.Exists(envPath))
            {
                DotNetEnv.Env.Load(envPath);
            }

            var builder = new ConfigurationBuilder()
                .SetBasePath(basePath)
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                .AddJsonFile("appsettings.Development.json", optional: true, reloadOnChange: true)
                .AddEnvironmentVariables();

            return builder.Build();
        }

        private async Task InitializeDatabaseAsync()
        {
            using var scope = Services.CreateScope();
            var dbContext = scope.ServiceProvider.GetRequiredService<PizzariaDbContext>();

            // Verifica se há migrações pendentes
            try
            {
                var pendingMigrations = await dbContext.Database.GetPendingMigrationsAsync();
                if (pendingMigrations.Any())
                {
                    // Aplica migrações pendentes
                    await dbContext.Database.MigrateAsync();
                }
                else
                {
                    // Sem migrações pendentes - verifica se o banco existe, se não, cria
                    await dbContext.Database.EnsureCreatedAsync();
                }
            }
            catch (Exception ex) when (ex.Message.Contains("already exists") || ex.Message.Contains("42P07"))
            {
                // Tabelas já existem - ignora e continua
                Console.WriteLine($"Migração pulada (tabelas já existem): {ex.Message}");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Erro ao inicializar banco de dados: {ex.Message}", "Erro",
                    MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Fix column names to snake_case if needed - SEMPRE roda
            await FixColumnNamesAsync(dbContext);
        }

        private async Task FixColumnNamesAsync(PizzariaDbContext dbContext)
        {
            Console.WriteLine("=== Running database schema fix ===");
            try
            {
                // Cria tabelas faltantes (sem ALTER TABLE que falham)
                var sql = @"
                    -- Cria tabelas faltantes
                    CREATE TABLE IF NOT EXISTS users (
                        id VARCHAR(50) PRIMARY KEY,
                        name VARCHAR(100) NOT NULL,
                        email VARCHAR(150) NOT NULL UNIQUE,
                        password_hash VARCHAR(255) NOT NULL,
                        phone VARCHAR(20) NOT NULL DEFAULT '',
                        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
                    );

                    CREATE TABLE IF NOT EXISTS addresses (
                        id VARCHAR(50) PRIMARY KEY,
                        user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                        label VARCHAR(50) NOT NULL,
                        street VARCHAR(100) NOT NULL,
                        number VARCHAR(20) NOT NULL,
                        complement VARCHAR(50) NOT NULL DEFAULT '',
                        neighborhood VARCHAR(50) NOT NULL,
                        city VARCHAR(50) NOT NULL,
                        state VARCHAR(2) NOT NULL,
                        zip_code VARCHAR(10) NOT NULL,
                        latitude DOUBLE PRECISION NOT NULL DEFAULT 0,
                        longitude DOUBLE PRECISION NOT NULL DEFAULT 0,
                        is_default BOOLEAN NOT NULL DEFAULT FALSE
                    );

                    CREATE TABLE IF NOT EXISTS categories (
                        id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                        name VARCHAR(20) NOT NULL UNIQUE,
                        display_name VARCHAR(50) NOT NULL,
                        sort_order INTEGER NOT NULL DEFAULT 0
                    );

                    CREATE TABLE IF NOT EXISTS products (
                        id VARCHAR(50) PRIMARY KEY,
                        name VARCHAR(100) NOT NULL,
                        description VARCHAR(500) NOT NULL DEFAULT '',
                        image_url VARCHAR(255) NOT NULL DEFAULT '',
                        price DOUBLE PRECISION NOT NULL,
                        category_id INTEGER NOT NULL REFERENCES categories(id),
                        prep_time_minutes INTEGER NOT NULL DEFAULT 20,
                        is_available BOOLEAN NOT NULL DEFAULT TRUE
                    );

                    CREATE TABLE IF NOT EXISTS customization_options (
                        id VARCHAR(50) PRIMARY KEY,
                        product_id VARCHAR(50) NOT NULL REFERENCES products(id) ON DELETE CASCADE,
                        name VARCHAR(50) NOT NULL,
                        is_required BOOLEAN NOT NULL,
                        allow_multiple BOOLEAN NOT NULL,
                        sort_order INTEGER NOT NULL
                    );

                    CREATE TABLE IF NOT EXISTS customization_choices (
                        id VARCHAR(50) PRIMARY KEY,
                        option_id VARCHAR(50) NOT NULL REFERENCES customization_options(id) ON DELETE CASCADE,
                        name VARCHAR(50) NOT NULL,
                        additional_price DOUBLE PRECISION NOT NULL,
                        sort_order INTEGER NOT NULL
                    );

                    CREATE TABLE IF NOT EXISTS cart_items (
                        id VARCHAR(50) PRIMARY KEY,
                        user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                        product_id VARCHAR(50) NOT NULL REFERENCES products(id) ON DELETE CASCADE,
                        quantity INTEGER NOT NULL,
                        selected_customizations_json VARCHAR(2000) NOT NULL DEFAULT '{{}}',
                        notes VARCHAR(500) NOT NULL DEFAULT '',
                        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
                    );

                    CREATE TABLE IF NOT EXISTS orders (
                        id VARCHAR(50) PRIMARY KEY,
                        user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                        delivery_address_id VARCHAR(50) NOT NULL REFERENCES addresses(id),
                        payment_method INTEGER NOT NULL,
                        status INTEGER NOT NULL,
                        subtotal DOUBLE PRECISION NOT NULL,
                        delivery_fee DOUBLE PRECISION NOT NULL,
                        notes VARCHAR(500) NOT NULL DEFAULT '',
                        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
                        estimated_delivery_time TIMESTAMP WITH TIME ZONE
                    );

                    CREATE TABLE IF NOT EXISTS order_items (
                        id VARCHAR(50) PRIMARY KEY,
                        order_id VARCHAR(50) NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
                        product_id VARCHAR(50) NOT NULL REFERENCES products(id) ON DELETE CASCADE,
                        quantity INTEGER NOT NULL,
                        unit_price DOUBLE PRECISION NOT NULL,
                        customizations_json VARCHAR(2000) NOT NULL DEFAULT '{{}}',
                        notes VARCHAR(500) NOT NULL DEFAULT ''
                    );

                    CREATE TABLE IF NOT EXISTS order_status_timeline (
                        id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                        order_id VARCHAR(50) NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
                        status INTEGER NOT NULL,
                        timestamp TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
                        note VARCHAR(500) NOT NULL
                    );

                    -- Insert default categories if not exist
                    INSERT INTO categories (name, display_name, sort_order) VALUES
                        ('Pizza', 'Pizzas', 1),
                        ('Drink', 'Bebidas', 2),
                        ('Dessert', 'Sobremesas', 3),
                        ('Side', 'Acompanhamentos', 4)
                    ON CONFLICT (name) DO NOTHING;
                ";

                Console.WriteLine("Executing SQL...");
                await dbContext.Database.ExecuteSqlRawAsync(sql);
                Console.WriteLine("Database schema fixed successfully!");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Database fix ERROR: {ex.Message}");
                Console.WriteLine($"StackTrace: {ex.StackTrace}");
            }
            Console.WriteLine("=== Database schema fix complete ===");
        }
    }

    public class BoolToVisibilityConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return value is true ? Visibility.Visible : Visibility.Collapsed;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return value is Visibility.Visible;
        }
    }

    public class InverseBoolToVisibilityConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return value is true ? Visibility.Collapsed : Visibility.Visible;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return value is Visibility.Collapsed;
        }
    }

    public class OrderStatusToColorConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is OrderStatus status)
            {
                return status switch
                {
                    OrderStatus.Pending => "#FFC107",
                    OrderStatus.Confirmed => "#17A2B8",
                    OrderStatus.Preparing => "#17A2B8",
                    OrderStatus.Baking => "#FF6B35",
                    OrderStatus.Ready => "#28A745",
                    OrderStatus.OutForDelivery => "#6F42C1",
                    OrderStatus.Delivered => "#28A745",
                    OrderStatus.Cancelled => "#DC3545",
                    _ => "#666666"
                };
            }
            return "#666666";
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }

    public class CategoryToIconConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is Category category)
            {
                return category switch
                {
                    Category.Pizza => "🍕",
                    Category.Drink => "🥤",
                    Category.Dessert => "🍰",
                    Category.Side => "🍟",
                    _ => "🍽️"
                };
            }
            if (value is Product product)
            {
                return product.Category switch
                {
                    Category.Pizza => "🍕",
                    Category.Drink => "🥤",
                    Category.Dessert => "🍰",
                    Category.Side => "🍟",
                    _ => "🍽️"
                };
            }
            return "🍽️";
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }

    public class CategoryDisplayNameConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is Category category)
            {
                return category switch
                {
                    Category.Pizza => "Pizzas",
                    Category.Drink => "Bebidas",
                    Category.Dessert => "Sobremesas",
                    Category.Side => "Acompanhamentos",
                    _ => category.ToString()
                };
            }
            if (value is Product product)
            {
                return product.Category switch
                {
                    Category.Pizza => "Pizzas",
                    Category.Drink => "Bebidas",
                    Category.Dessert => "Sobremesas",
                    Category.Side => "Acompanhamentos",
                    _ => product.Category.ToString()
                };
            }
            return "";
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }

    public class CategoryBackgroundConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            var current = value as Category?;
            var selected = parameter as Category?;

            if (current == selected)
                return (Color)ColorConverter.ConvertFromString("#FFFFF0EB");
            return (Color)ColorConverter.ConvertFromString("#FFFFFFFF");
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }

    public class CategoryBorderConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            var current = value as Category?;
            var selected = parameter as Category?;

            if (current == selected)
                return (Color)ColorConverter.ConvertFromString("#FFFF6B35");
            return (Color)ColorConverter.ConvertFromString("#FFE0E0E0");
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }

    public class CategoryForegroundConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            var current = value as Category?;
            var selected = parameter as Category?;

            if (current == selected)
                return (Color)ColorConverter.ConvertFromString("#FFFF6B35");
            return (Color)ColorConverter.ConvertFromString("#FF666666");
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }

    public class EmptyToVisibilityConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is int count)
                return count == 0 ? Visibility.Visible : Visibility.Collapsed;
            return Visibility.Collapsed;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }

    public class BoolToBackgroundConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            var isSelected = value is true;
            var param = parameter as string;

            if (isSelected && param == "selected")
                return (Color)ColorConverter.ConvertFromString("#FFFFF0EB");
            return (Color)ColorConverter.ConvertFromString("#FFFFFFFF");
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}