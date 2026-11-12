namespace PizzariaDesktop.Services;

using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Microsoft.EntityFrameworkCore;
using PizzariaDesktop.Data;
using PizzariaDesktop.Data.Repositories;
using System.IO;
using System.Web;
using Npgsql;
using DotNetEnv;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddPizzariaServices(this IServiceCollection services, IConfiguration? configuration = null)
    {
        // Configuração
        var config = configuration ?? BuildConfiguration();
        services.AddSingleton(config);

        // DbContext
        services.AddDbContext<PizzariaDbContext>((sp, options) =>
        {
            var cfg = sp.GetRequiredService<IConfiguration>();
            var connectionString = GetConnectionString(cfg);

            // Detecta o provider baseado na connection string
            if (IsPostgreSqlConnectionString(connectionString))
            {
                options.UseNpgsql(connectionString);
            }
            else
            {
                options.UseSqlite(connectionString);
            }

            // Suprime warning de mudanças pendentes
            options.ConfigureWarnings(w => w.Ignore(Microsoft.EntityFrameworkCore.Diagnostics.RelationalEventId.PendingModelChangesWarning));
        });

        // Repositórios
        services.AddScoped<IUserRepository, UserRepository>();
        services.AddScoped<IAddressRepository, AddressRepository>();
        services.AddScoped<IProductRepository, ProductRepository>();
        services.AddScoped<ICartRepository, CartRepository>();
        services.AddScoped<IOrderRepository, OrderRepository>();
        services.AddScoped<ICategoryRepository, CategoryRepository>();

        // Serviços
        services.AddScoped<IAuthService, AuthService>();

        return services;
    }

    private static IConfiguration BuildConfiguration()
    {
        var basePath = AppDomain.CurrentDomain.BaseDirectory;

        // Carrega .env se existir ANTES de adicionar environment variables
        var envPath = Path.Combine(basePath, ".env");
        if (File.Exists(envPath))
        {
            Env.Load(envPath);
        }

        var builder = new ConfigurationBuilder()
            .SetBasePath(basePath)
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .AddJsonFile("appsettings.Development.json", optional: true, reloadOnChange: true)
            .AddEnvironmentVariables();

        return builder.Build();
    }

    private static string GetConnectionString(IConfiguration config)
    {
        // Prioriza DATABASE_CONNECTION_STRING do .env / variáveis de ambiente
        var connStr = config["DATABASE_CONNECTION_STRING"];

        if (!string.IsNullOrEmpty(connStr))
        {
            // Se for PostgreSQL em formato URL (postgresql://...), converte para formato padrão
            if (IsPostgreSqlUrl(connStr))
            {
                return ParsePostgreSqlUrl(connStr);
            }

            // Se for SQLite com caminho relativo, resolve para caminho absoluto
            if (IsSqliteConnectionString(connStr) && connStr.Contains("Data Source=") && !connStr.Contains(":"))
            {
                var fileName = connStr.Replace("Data Source=", "").Split(';')[0].Trim();
                var fullPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, fileName);
                return $"Data Source={fullPath};Cache=Shared";
            }
            return connStr;
        }

        // Fallback para SQLite local
        return "Data Source=pizzaria.db;Cache=Shared";
    }

    private static bool IsPostgreSqlUrl(string connectionString)
    {
        if (string.IsNullOrEmpty(connectionString)) return false;
        var lower = connectionString.ToLowerInvariant();
        return lower.StartsWith("postgresql://") || lower.StartsWith("postgres://");
    }

    private static string ParsePostgreSqlUrl(string url)
    {
        try
        {
            // Parse postgresql://user:password@host:port/database?params
            var uri = new Uri(url);

            var host = uri.Host;
            var port = uri.Port > 0 ? uri.Port : 5432;
            var database = uri.AbsolutePath.TrimStart('/');
            var userInfo = uri.UserInfo.Split(':');
            var username = userInfo.Length > 0 ? userInfo[0] : "";
            var password = userInfo.Length > 1 ? userInfo[1] : "";

            // Parse query parameters
            var query = System.Web.HttpUtility.ParseQueryString(uri.Query);
            var sslMode = query["sslmode"] ?? "Require";
            var channelBinding = query["channel_binding"] ?? "";

            var builder = new Npgsql.NpgsqlConnectionStringBuilder
            {
                Host = host,
                Port = port,
                Database = database,
                Username = username,
                Password = password,
                SslMode = Enum.TryParse<Npgsql.SslMode>(sslMode, true, out var parsedSsl) ? parsedSsl : Npgsql.SslMode.Require,
                TrustServerCertificate = true
            };

            return builder.ToString();
        }
        catch
        {
            // Se falhar ao parsear, retorna a string original
            return url;
        }
    }

    private static bool IsPostgreSqlConnectionString(string connectionString)
    {
        if (string.IsNullOrEmpty(connectionString)) return false;

        var lower = connectionString.ToLowerInvariant();
        return lower.StartsWith("postgresql://") || lower.StartsWith("postgres://")
            || lower.Contains("host=") || lower.Contains("server=") || lower.Contains("database=")
            || lower.Contains("username=") || lower.Contains("password=") || lower.Contains("port=");
    }

    private static bool IsSqliteConnectionString(string connectionString)
    {
        if (string.IsNullOrEmpty(connectionString)) return false;
        return connectionString.ToLowerInvariant().Contains("data source=");
    }
}

// Service Locator simples para acesso global (opcional, para ViewModels que não usam DI)
public static class ServiceLocator
{
    private static IServiceProvider? _provider;

    public static void Initialize(IServiceProvider provider)
    {
        _provider = provider;
    }

    public static T GetService<T>() where T : notnull
    {
        if (_provider == null)
            throw new InvalidOperationException("ServiceLocator não inicializado. Chame Initialize() no App.xaml.cs");

        return _provider.GetRequiredService<T>();
    }

    public static T? GetServiceOrDefault<T>() where T : class
    {
        return _provider?.GetService<T>();
    }
}