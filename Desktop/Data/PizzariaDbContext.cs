namespace PizzariaDesktop.Data;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using PizzariaDesktop.Data.Entities;
using System.IO;
using System.Collections.Generic;
using Npgsql;
using DotNetEnv;

public class PizzariaDbContext : DbContext
{
    public DbSet<UserEntity> Users => Set<UserEntity>();
    public DbSet<AddressEntity> Addresses => Set<AddressEntity>();
    public DbSet<CategoryEntity> Categories => Set<CategoryEntity>();
    public DbSet<ProductEntity> Products => Set<ProductEntity>();
    public DbSet<CustomizationOptionEntity> CustomizationOptions => Set<CustomizationOptionEntity>();
    public DbSet<CustomizationChoiceEntity> CustomizationChoices => Set<CustomizationChoiceEntity>();
    public DbSet<CartItemEntity> CartItems => Set<CartItemEntity>();
    public DbSet<OrderEntity> Orders => Set<OrderEntity>();
    public DbSet<OrderItemEntity> OrderItems => Set<OrderItemEntity>();
    public DbSet<OrderStatusTimelineEntity> OrderStatusTimeline => Set<OrderStatusTimelineEntity>();

    private readonly IConfiguration? _configuration;

    public PizzariaDbContext() : base() { }

    public PizzariaDbContext(DbContextOptions<PizzariaDbContext> options, IConfiguration? configuration = null)
        : base(options)
    {
        _configuration = configuration;
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            var connectionString = GetConnectionString();

            // Detecta o provider baseado na connection string
            if (IsPostgreSqlConnectionString(connectionString))
            {
                optionsBuilder.UseNpgsql(connectionString);
            }
            else
            {
                optionsBuilder.UseSqlite(connectionString);
            }
        }

        // Suprime warning de mudanças pendentes (a migration de renomeação já existe)
        optionsBuilder.ConfigureWarnings(w => w.Ignore(Microsoft.EntityFrameworkCore.Diagnostics.RelationalEventId.PendingModelChangesWarning));
    }

    private string GetConnectionString()
    {
        // Tenta ler do appsettings.json ou variável de ambiente
        var config = _configuration ?? BuildConfiguration();

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

    private static bool IsPostgreSqlConnectionString(string connectionString)
    {
        if (string.IsNullOrEmpty(connectionString)) return false;

        var lower = connectionString.ToLowerInvariant();
        return lower.StartsWith("postgresql://") || lower.StartsWith("postgres://")
            || lower.Contains("host=") || lower.Contains("server=") || lower.Contains("database=")
            || lower.Contains("username=") || lower.Contains("password=") || lower.Contains("port=");
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

            // Parse query parameters (custom implementation to avoid System.Web dependency)
            var query = ParseQueryString(uri.Query);
            var sslMode = query.TryGetValue("sslmode", out var sslVal) ? sslVal : "Require";

            var builder = new NpgsqlConnectionStringBuilder
            {
                Host = host,
                Port = port,
                Database = database,
                Username = username,
                Password = password,
                SslMode = Enum.TryParse<SslMode>(sslMode, true, out var parsedSsl) ? parsedSsl : SslMode.Require,
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

    private static Dictionary<string, string> ParseQueryString(string query)
    {
        var result = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        if (string.IsNullOrEmpty(query))
            return result;

        // Remove leading '?' if present
        if (query.StartsWith("?"))
            query = query.Substring(1);

        var pairs = query.Split('&');
        foreach (var pair in pairs)
        {
            if (string.IsNullOrEmpty(pair))
                continue;

            var kv = pair.Split('=', 2);
            var key = Uri.UnescapeDataString(kv[0]);
            var value = kv.Length > 1 ? Uri.UnescapeDataString(kv[1]) : "";
            result[key] = value;
        }

        return result;
    }

    private static bool IsSqliteConnectionString(string connectionString)
    {
        if (string.IsNullOrEmpty(connectionString)) return false;
        return connectionString.ToLowerInvariant().Contains("data source=");
    }

    private IConfiguration BuildConfiguration()
    {
        // Carrega .env se existir ANTES de adicionar environment variables
        var envPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, ".env");
        if (File.Exists(envPath))
        {
            DotNetEnv.Env.Load(envPath);
        }

        var builder = new ConfigurationBuilder()
            .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .AddJsonFile("appsettings.Development.json", optional: true, reloadOnChange: true)
            .AddEnvironmentVariables();

        return builder.Build();
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Configurações de entidade
        ConfigureUser(modelBuilder);
        ConfigureAddress(modelBuilder);
        ConfigureCategory(modelBuilder);
        ConfigureProduct(modelBuilder);
        ConfigureCustomizationOption(modelBuilder);
        ConfigureCustomizationChoice(modelBuilder);
        ConfigureCartItem(modelBuilder);
        ConfigureOrder(modelBuilder);
        ConfigureOrderItem(modelBuilder);
        ConfigureOrderStatusTimeline(modelBuilder);

        // Seed data
        SeedData(modelBuilder);
    }

    private void ConfigureUser(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<UserEntity>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.Email).IsUnique();
            entity.Property(e => e.Id).HasMaxLength(50).HasColumnName("id");
            entity.Property(e => e.Name).HasMaxLength(100).IsRequired().HasColumnName("name");
            entity.Property(e => e.Email).HasMaxLength(150).IsRequired().HasColumnName("email");
            entity.Property(e => e.PasswordHash).HasMaxLength(255).IsRequired().HasColumnName("passwordhash");
            entity.Property(e => e.Phone).HasMaxLength(20).HasColumnName("phone");
        });
    }

    private void ConfigureAddress(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AddressEntity>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.UserId);
            entity.Property(e => e.Id).HasMaxLength(50).HasColumnName("id");
            entity.Property(e => e.UserId).HasMaxLength(50).IsRequired().HasColumnName("userid");
            entity.Property(e => e.Label).HasMaxLength(50).IsRequired().HasColumnName("label");
            entity.Property(e => e.Street).HasMaxLength(100).IsRequired().HasColumnName("street");
            entity.Property(e => e.Number).HasMaxLength(20).IsRequired().HasColumnName("number");
            entity.Property(e => e.Complement).HasMaxLength(50).HasColumnName("complement");
            entity.Property(e => e.Neighborhood).HasMaxLength(50).IsRequired().HasColumnName("neighborhood");
            entity.Property(e => e.City).HasMaxLength(50).IsRequired().HasColumnName("city");
            entity.Property(e => e.State).HasMaxLength(2).IsRequired().HasColumnName("state");
            entity.Property(e => e.ZipCode).HasMaxLength(10).IsRequired().HasColumnName("zipcode");
            entity.Property(e => e.Latitude).HasColumnName("latitude");
            entity.Property(e => e.Longitude).HasColumnName("longitude");
            entity.Property(e => e.IsDefault).HasColumnName("isdefault");

            entity.HasOne(e => e.User)
                .WithMany(u => u.Addresses)
                .HasForeignKey(e => e.UserId)
                .OnDelete(DeleteBehavior.Cascade);
        });
    }

    private void ConfigureCategory(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<CategoryEntity>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name).HasMaxLength(20).IsRequired().HasColumnName("name");
            entity.Property(e => e.DisplayName).HasMaxLength(50).IsRequired().HasColumnName("display_name");
            entity.Property(e => e.SortOrder).HasColumnName("sort_order");
        });
    }

    private void ConfigureProduct(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ProductEntity>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.CategoryId);
            entity.Property(e => e.Id).HasMaxLength(50).HasColumnName("id");
            entity.Property(e => e.Name).HasMaxLength(100).IsRequired().HasColumnName("name");
            entity.Property(e => e.Description).HasMaxLength(500).HasColumnName("description");
            entity.Property(e => e.ImageUrl).HasMaxLength(255).HasColumnName("image_url");
            entity.Property(e => e.Price).HasColumnType("REAL").IsRequired().HasColumnName("price");
            entity.Property(e => e.CategoryId).IsRequired().HasColumnName("category_id");
            entity.Property(e => e.PrepTimeMinutes).IsRequired().HasColumnName("prep_time_minutes");
            entity.Property(e => e.IsAvailable).HasColumnName("is_available");

            entity.HasOne(e => e.Category)
                .WithMany(c => c.Products)
                .HasForeignKey(e => e.CategoryId)
                .OnDelete(DeleteBehavior.Restrict);
        });
    }

    private void ConfigureCustomizationOption(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<CustomizationOptionEntity>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.ProductId);
            entity.Property(e => e.Id).HasMaxLength(50).HasColumnName("id");
            entity.Property(e => e.ProductId).HasMaxLength(50).IsRequired().HasColumnName("product_id");
            entity.Property(e => e.Name).HasMaxLength(50).IsRequired().HasColumnName("name");
            entity.Property(e => e.IsRequired).HasColumnName("is_required");
            entity.Property(e => e.AllowMultiple).HasColumnName("allow_multiple");
            entity.Property(e => e.SortOrder).HasColumnName("sort_order");

            entity.HasOne(e => e.Product)
                .WithMany(p => p.Customizations)
                .HasForeignKey(e => e.ProductId)
                .OnDelete(DeleteBehavior.Cascade);
        });
    }

    private void ConfigureCustomizationChoice(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<CustomizationChoiceEntity>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.OptionId);
            entity.Property(e => e.Id).HasMaxLength(50).HasColumnName("id");
            entity.Property(e => e.OptionId).HasMaxLength(50).IsRequired().HasColumnName("option_id");
            entity.Property(e => e.Name).HasMaxLength(50).IsRequired().HasColumnName("name");
            entity.Property(e => e.AdditionalPrice).HasColumnName("additional_price");
            entity.Property(e => e.SortOrder).HasColumnName("sort_order");

            entity.HasOne(e => e.Option)
                .WithMany(o => o.Choices)
                .HasForeignKey(e => e.OptionId)
                .OnDelete(DeleteBehavior.Cascade);
        });
    }

    private void ConfigureCartItem(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<CartItemEntity>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.UserId);
            entity.Property(e => e.Id).HasMaxLength(50).HasColumnName("id");
            entity.Property(e => e.UserId).HasMaxLength(50).IsRequired().HasColumnName("user_id");
            entity.Property(e => e.ProductId).HasMaxLength(50).IsRequired().HasColumnName("product_id");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.SelectedCustomizationsJson).HasMaxLength(2000).HasDefaultValue("{}").HasColumnName("selected_customizations_json");
            entity.Property(e => e.Notes).HasMaxLength(500).HasColumnName("notes");
            entity.Property(e => e.CreatedAt).HasColumnName("created_at");

            entity.HasOne(e => e.User)
                .WithMany(u => u.CartItems)
                .HasForeignKey(e => e.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            entity.HasOne(e => e.Product)
                .WithMany()
                .HasForeignKey(e => e.ProductId)
                .OnDelete(DeleteBehavior.Restrict);
        });
    }

    private void ConfigureOrder(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<OrderEntity>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.UserId);
            entity.HasIndex(e => e.Status);
            entity.Property(e => e.Id).HasMaxLength(50).HasColumnName("id");
            entity.Property(e => e.UserId).HasMaxLength(50).IsRequired().HasColumnName("user_id");
            entity.Property(e => e.DeliveryAddressId).HasMaxLength(50).IsRequired().HasColumnName("delivery_address_id");
            entity.Property(e => e.PaymentMethod).HasColumnName("payment_method");
            entity.Property(e => e.Status).HasColumnName("status");
            entity.Property(e => e.Subtotal).HasColumnType("REAL").IsRequired().HasColumnName("subtotal");
            entity.Property(e => e.DeliveryFee).HasColumnType("REAL").IsRequired().HasColumnName("delivery_fee");
            entity.Property(e => e.Notes).HasMaxLength(500).HasColumnName("notes");
            entity.Property(e => e.CreatedAt).HasColumnName("created_at");
            entity.Property(e => e.EstimatedDeliveryTime).HasColumnName("estimated_delivery_time");

            entity.HasOne(e => e.User)
                .WithMany(u => u.Orders)
                .HasForeignKey(e => e.UserId)
                .OnDelete(DeleteBehavior.Restrict);

            entity.HasOne(e => e.DeliveryAddress)
                .WithMany()
                .HasForeignKey(e => e.DeliveryAddressId)
                .OnDelete(DeleteBehavior.Restrict);
        });
    }

    private void ConfigureOrderItem(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<OrderItemEntity>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.OrderId);
            entity.Property(e => e.Id).HasMaxLength(50).HasColumnName("id");
            entity.Property(e => e.OrderId).HasMaxLength(50).IsRequired().HasColumnName("order_id");
            entity.Property(e => e.ProductId).HasMaxLength(50).IsRequired().HasColumnName("product_id");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.UnitPrice).HasColumnType("REAL").IsRequired().HasColumnName("unit_price");
            entity.Property(e => e.CustomizationsJson).HasMaxLength(2000).HasDefaultValue("{}").HasColumnName("customizations_json");
            entity.Property(e => e.Notes).HasMaxLength(500).HasColumnName("notes");

            entity.HasOne(e => e.Order)
                .WithMany(o => o.Items)
                .HasForeignKey(e => e.OrderId)
                .OnDelete(DeleteBehavior.Cascade);

            entity.HasOne(e => e.Product)
                .WithMany()
                .HasForeignKey(e => e.ProductId)
                .OnDelete(DeleteBehavior.Restrict);
        });
    }

    private void ConfigureOrderStatusTimeline(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<OrderStatusTimelineEntity>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.OrderId);
            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.OrderId).HasMaxLength(50).IsRequired().HasColumnName("order_id");
            entity.Property(e => e.Status).HasColumnName("status");
            entity.Property(e => e.Timestamp).HasColumnName("timestamp");
            entity.Property(e => e.Note).HasMaxLength(500).HasColumnName("note");

            entity.HasOne(e => e.Order)
                .WithMany(o => o.Timeline)
                .HasForeignKey(e => e.OrderId)
                .OnDelete(DeleteBehavior.Cascade);
        });
    }

    private void SeedData(ModelBuilder modelBuilder)
    {
        // Categorias
        modelBuilder.Entity<CategoryEntity>().HasData(
            new CategoryEntity { Id = 1, Name = "Pizza", DisplayName = "Pizzas", SortOrder = 1 },
            new CategoryEntity { Id = 2, Name = "Drink", DisplayName = "Bebidas", SortOrder = 2 },
            new CategoryEntity { Id = 3, Name = "Dessert", DisplayName = "Sobremesas", SortOrder = 3 },
            new CategoryEntity { Id = 4, Name = "Side", DisplayName = "Acompanhamentos", SortOrder = 4 }
        );

        // Usuário demo (senha: "123456")
        var passwordHash = BCrypt.Net.BCrypt.HashPassword("123456", workFactor: 12);

        modelBuilder.Entity<UserEntity>().HasData(
            new UserEntity
            {
                Id = "user-001",
                Name = "Gabriel Silva",
                Email = "gabriel@email.com",
                PasswordHash = passwordHash,
                Phone = "(11) 99999-9999",
                CreatedAt = new DateTime(2024, 1, 15, 0, 0, 0, DateTimeKind.Utc)
            },
            new UserEntity
            {
                Id = "user-002",
                Name = "Maria Santos",
                Email = "maria@email.com",
                PasswordHash = passwordHash,
                Phone = "(11) 88888-8888",
                CreatedAt = new DateTime(2024, 2, 20, 0, 0, 0, DateTimeKind.Utc)
            }
        );

        // Endereços
        modelBuilder.Entity<AddressEntity>().HasData(
            new AddressEntity
            {
                Id = "addr-001",
                UserId = "user-001",
                Label = "Casa",
                Street = "Rua das Flores",
                Number = "123",
                Complement = "Apto 45",
                Neighborhood = "Jardim Primavera",
                City = "São Paulo",
                State = "SP",
                ZipCode = "01234-567",
                Latitude = -23.5505,
                Longitude = -46.6333,
                IsDefault = true
            },
            new AddressEntity
            {
                Id = "addr-002",
                UserId = "user-001",
                Label = "Trabalho",
                Street = "Av. Paulista",
                Number = "1000",
                Complement = "Sala 1200",
                Neighborhood = "Bela Vista",
                City = "São Paulo",
                State = "SP",
                ZipCode = "01310-100",
                Latitude = -23.5613,
                Longitude = -46.6564,
                IsDefault = false
            },
            new AddressEntity
            {
                Id = "addr-003",
                UserId = "user-002",
                Label = "Casa",
                Street = "Rua Augusta",
                Number = "500",
                Complement = "",
                Neighborhood = "Consolação",
                City = "São Paulo",
                State = "SP",
                ZipCode = "01305-000",
                Latitude = -23.5558,
                Longitude = -46.6608,
                IsDefault = true
            }
        );

        // Produtos - seed básico (os demais podem ser adicionados via migration ou script)
        SeedProducts(modelBuilder);
    }

    private void SeedProducts(ModelBuilder modelBuilder)
    {
        var products = new List<ProductEntity>
        {
            // Pizzas
            new ProductEntity { Id = "prod-001", Name = "Pizza Margherita", Description = "Molho de tomate, mussarela, manjericão fresco e azeite de oliva", ImageUrl = "🍕", Price = 42.90, CategoryId = 1, PrepTimeMinutes = 25, IsAvailable = true },
            new ProductEntity { Id = "prod-002", Name = "Pizza Pepperoni", Description = "Molho de tomate, mussarela, pepperoni e orégano", ImageUrl = "🍕", Price = 48.90, CategoryId = 1, PrepTimeMinutes = 25, IsAvailable = true },
            new ProductEntity { Id = "prod-003", Name = "Pizza Quatro Queijos", Description = "Molho de tomate, mussarela, provolone, gorgonzola e parmesão", ImageUrl = "🍕", Price = 52.90, CategoryId = 1, PrepTimeMinutes = 30, IsAvailable = true },
            new ProductEntity { Id = "prod-004", Name = "Pizza Frango com Catupiry", Description = "Molho de tomate, mussarela, frango desfiado, catupiry, milho e azeitonas", ImageUrl = "🍕", Price = 49.90, CategoryId = 1, PrepTimeMinutes = 28, IsAvailable = true },
            new ProductEntity { Id = "prod-005", Name = "Pizza Calabresa", Description = "Molho de tomate, mussarela, calabresa fatiada, cebola e orégano", ImageUrl = "🍕", Price = 44.90, CategoryId = 1, PrepTimeMinutes = 25, IsAvailable = true },
            new ProductEntity { Id = "prod-006", Name = "Pizza Portuguesa", Description = "Molho de tomate, mussarela, presunto, ovos, cebola, azeitonas, ervilha e orégano", ImageUrl = "🍕", Price = 51.90, CategoryId = 1, PrepTimeMinutes = 30, IsAvailable = false },

            // Bebidas
            new ProductEntity { Id = "prod-007", Name = "Coca-Cola 2L", Description = "Refrigerante Coca-Cola original 2 litros", ImageUrl = "🥤", Price = 12.90, CategoryId = 2, PrepTimeMinutes = 2, IsAvailable = true },
            new ProductEntity { Id = "prod-008", Name = "Coca-Cola Zero 2L", Description = "Refrigerante Coca-Cola Zero açúcar 2 litros", ImageUrl = "🥤", Price = 12.90, CategoryId = 2, PrepTimeMinutes = 2, IsAvailable = true },
            new ProductEntity { Id = "prod-009", Name = "Guaraná Antarctica 2L", Description = "Refrigerante Guaraná Antarctica 2 litros", ImageUrl = "🥤", Price = 10.90, CategoryId = 2, PrepTimeMinutes = 2, IsAvailable = true },
            new ProductEntity { Id = "prod-010", Name = "Suco de Laranja 1L", Description = "Suco natural de laranja 1 litro", ImageUrl = "🧃", Price = 14.90, CategoryId = 2, PrepTimeMinutes = 3, IsAvailable = true },
            new ProductEntity { Id = "prod-011", Name = "Água Mineral 500ml", Description = "Água mineral sem gás 500ml", ImageUrl = "💧", Price = 4.50, CategoryId = 2, PrepTimeMinutes = 1, IsAvailable = true },
            new ProductEntity { Id = "prod-012", Name = "Cerveja Heineken 600ml", Description = "Cerveja Heineken long neck 600ml", ImageUrl = "🍺", Price = 16.90, CategoryId = 2, PrepTimeMinutes = 2, IsAvailable = true },

            // Sobremesas
            new ProductEntity { Id = "prod-013", Name = "Petit Gateau", Description = "Bolinho de chocolate com recheio cremoso, servido com sorvete de creme", ImageUrl = "🍫", Price = 18.90, CategoryId = 3, PrepTimeMinutes = 10, IsAvailable = true },
            new ProductEntity { Id = "prod-014", Name = "Pudim de Leite Condensado", Description = "Pudim caseiro de leite condensado com calda de caramelo", ImageUrl = "🍮", Price = 12.90, CategoryId = 3, PrepTimeMinutes = 5, IsAvailable = true },
            new ProductEntity { Id = "prod-015", Name = "Brownie com Sorvete", Description = "Brownie de chocolate quente com bola de sorvete de creme e calda de chocolate", ImageUrl = "🍰", Price = 16.90, CategoryId = 3, PrepTimeMinutes = 8, IsAvailable = true },

            // Acompanhamentos
            new ProductEntity { Id = "prod-016", Name = "Batata Frita Grande", Description = "Porção grande de batatas fritas crocantes", ImageUrl = "🍟", Price = 18.90, CategoryId = 4, PrepTimeMinutes = 12, IsAvailable = true },
            new ProductEntity { Id = "prod-017", Name = "Onion Rings", Description = "Anéis de cebola empanados e fritos", ImageUrl = "🧅", Price = 16.90, CategoryId = 4, PrepTimeMinutes = 10, IsAvailable = true },
            new ProductEntity { Id = "prod-018", Name = "Pão de Alho (4 unidades)", Description = "Pães de alho artesanais com queijo derretido", ImageUrl = "🧄", Price = 14.90, CategoryId = 4, PrepTimeMinutes = 8, IsAvailable = true }
        };

        modelBuilder.Entity<ProductEntity>().HasData(products);

        // CustomizationOptions e Choices para Margherita
        SeedCustomizations(modelBuilder);
    }

    private void SeedCustomizations(ModelBuilder modelBuilder)
    {
        var options = new List<CustomizationOptionEntity>
        {
            // Margherita
            new CustomizationOptionEntity { Id = "cust-001", ProductId = "prod-001", Name = "Tamanho", IsRequired = true, AllowMultiple = false, SortOrder = 1 },
            new CustomizationOptionEntity { Id = "cust-002", ProductId = "prod-001", Name = "Borda", IsRequired = false, AllowMultiple = false, SortOrder = 2 },
            new CustomizationOptionEntity { Id = "cust-003", ProductId = "prod-001", Name = "Ingredientes extras", IsRequired = false, AllowMultiple = true, SortOrder = 3 },

            // Pepperoni
            new CustomizationOptionEntity { Id = "cust-004", ProductId = "prod-002", Name = "Tamanho", IsRequired = true, AllowMultiple = false, SortOrder = 1 },
            new CustomizationOptionEntity { Id = "cust-005", ProductId = "prod-002", Name = "Borda", IsRequired = false, AllowMultiple = false, SortOrder = 2 },

            // Quatro Queijos
            new CustomizationOptionEntity { Id = "cust-006", ProductId = "prod-003", Name = "Tamanho", IsRequired = true, AllowMultiple = false, SortOrder = 1 },

            // Frango
            new CustomizationOptionEntity { Id = "cust-007", ProductId = "prod-004", Name = "Tamanho", IsRequired = true, AllowMultiple = false, SortOrder = 1 },

            // Calabresa
            new CustomizationOptionEntity { Id = "cust-008", ProductId = "prod-005", Name = "Tamanho", IsRequired = true, AllowMultiple = false, SortOrder = 1 },

            // Portuguesa
            new CustomizationOptionEntity { Id = "cust-009", ProductId = "prod-006", Name = "Tamanho", IsRequired = true, AllowMultiple = false, SortOrder = 1 }
        };

        modelBuilder.Entity<CustomizationOptionEntity>().HasData(options);

        var choices = new List<CustomizationChoiceEntity>
        {
            // Tamanho Margherita
            new CustomizationChoiceEntity { Id = "choice-001", OptionId = "cust-001", Name = "Pequena (6 fatias)", AdditionalPrice = 0, SortOrder = 1 },
            new CustomizationChoiceEntity { Id = "choice-002", OptionId = "cust-001", Name = "Média (8 fatias)", AdditionalPrice = 8.00, SortOrder = 2 },
            new CustomizationChoiceEntity { Id = "choice-003", OptionId = "cust-001", Name = "Grande (10 fatias)", AdditionalPrice = 15.00, SortOrder = 3 },

            // Borda Margherita
            new CustomizationChoiceEntity { Id = "choice-004", OptionId = "cust-002", Name = "Sem borda", AdditionalPrice = 0, SortOrder = 1 },
            new CustomizationChoiceEntity { Id = "choice-005", OptionId = "cust-002", Name = "Borda recheada com catupiry", AdditionalPrice = 6.00, SortOrder = 2 },
            new CustomizationChoiceEntity { Id = "choice-006", OptionId = "cust-002", Name = "Borda recheada com cheddar", AdditionalPrice = 6.00, SortOrder = 3 },

            // Ingredientes extras Margherita
            new CustomizationChoiceEntity { Id = "choice-007", OptionId = "cust-003", Name = "Tomate seco", AdditionalPrice = 3.00, SortOrder = 1 },
            new CustomizationChoiceEntity { Id = "choice-008", OptionId = "cust-003", Name = "Rúcula", AdditionalPrice = 2.50, SortOrder = 2 },
            new CustomizationChoiceEntity { Id = "choice-009", OptionId = "cust-003", Name = "Parmesão", AdditionalPrice = 3.50, SortOrder = 3 },
            new CustomizationChoiceEntity { Id = "choice-010", OptionId = "cust-003", Name = "Azeitonas", AdditionalPrice = 2.00, SortOrder = 4 },

            // Tamanho Pepperoni
            new CustomizationChoiceEntity { Id = "choice-011", OptionId = "cust-004", Name = "Pequena (6 fatias)", AdditionalPrice = 0, SortOrder = 1 },
            new CustomizationChoiceEntity { Id = "choice-012", OptionId = "cust-004", Name = "Média (8 fatias)", AdditionalPrice = 8.00, SortOrder = 2 },
            new CustomizationChoiceEntity { Id = "choice-013", OptionId = "cust-004", Name = "Grande (10 fatias)", AdditionalPrice = 15.00, SortOrder = 3 },

            // Borda Pepperoni
            new CustomizationChoiceEntity { Id = "choice-014", OptionId = "cust-005", Name = "Sem borda", AdditionalPrice = 0, SortOrder = 1 },
            new CustomizationChoiceEntity { Id = "choice-015", OptionId = "cust-005", Name = "Borda recheada com catupiry", AdditionalPrice = 6.00, SortOrder = 2 },

            // Tamanho Quatro Queijos
            new CustomizationChoiceEntity { Id = "choice-016", OptionId = "cust-006", Name = "Pequena (6 fatias)", AdditionalPrice = 0, SortOrder = 1 },
            new CustomizationChoiceEntity { Id = "choice-017", OptionId = "cust-006", Name = "Média (8 fatias)", AdditionalPrice = 8.00, SortOrder = 2 },
            new CustomizationChoiceEntity { Id = "choice-018", OptionId = "cust-006", Name = "Grande (10 fatias)", AdditionalPrice = 15.00, SortOrder = 3 },

            // Tamanho Frango
            new CustomizationChoiceEntity { Id = "choice-019", OptionId = "cust-007", Name = "Pequena (6 fatias)", AdditionalPrice = 0, SortOrder = 1 },
            new CustomizationChoiceEntity { Id = "choice-020", OptionId = "cust-007", Name = "Média (8 fatias)", AdditionalPrice = 8.00, SortOrder = 2 },
            new CustomizationChoiceEntity { Id = "choice-021", OptionId = "cust-007", Name = "Grande (10 fatias)", AdditionalPrice = 15.00, SortOrder = 3 },

            // Tamanho Calabresa
            new CustomizationChoiceEntity { Id = "choice-022", OptionId = "cust-008", Name = "Pequena (6 fatias)", AdditionalPrice = 0, SortOrder = 1 },
            new CustomizationChoiceEntity { Id = "choice-023", OptionId = "cust-008", Name = "Média (8 fatias)", AdditionalPrice = 8.00, SortOrder = 2 },
            new CustomizationChoiceEntity { Id = "choice-024", OptionId = "cust-008", Name = "Grande (10 fatias)", AdditionalPrice = 15.00, SortOrder = 3 },

            // Tamanho Portuguesa
            new CustomizationChoiceEntity { Id = "choice-025", OptionId = "cust-009", Name = "Pequena (6 fatias)", AdditionalPrice = 0, SortOrder = 1 },
            new CustomizationChoiceEntity { Id = "choice-026", OptionId = "cust-009", Name = "Média (8 fatias)", AdditionalPrice = 8.00, SortOrder = 2 },
            new CustomizationChoiceEntity { Id = "choice-027", OptionId = "cust-009", Name = "Grande (10 fatias)", AdditionalPrice = 15.00, SortOrder = 3 }
        };

        modelBuilder.Entity<CustomizationChoiceEntity>().HasData(choices);
    }
}