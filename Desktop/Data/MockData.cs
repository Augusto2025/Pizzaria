namespace PizzariaDesktop.Data;

using System.Collections.Generic;
using System.Linq;
using PizzariaDesktop.Models;

public static class MockData
{
    public static List<Address> Addresses { get; } = CreateAddresses();
    public static List<Product> Products { get; } = CreateProducts();
    public static User CurrentUser { get; } = CreateUser();
    public static List<Order> Orders { get; } = CreateOrders();
    public static List<CartItem> CartItems { get; } = CreateCartItems();

    private static User CreateUser()
    {
        return new User
        {
            Id = "user-001",
            Name = "Gabriel Silva",
            Email = "gabriel@email.com",
            Phone = "(11) 99999-9999",
            Addresses = CreateAddresses(),
            CreatedAt = new DateTime(2024, 1, 15)
        };
    }

    private static List<Address> CreateAddresses()
    {
        var list = new List<Address>();
        list.Add(new Address
        {
            Id = "addr-001",
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
        });
        list.Add(new Address
        {
            Id = "addr-002",
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
        });
        return list;
    }

    private static List<Product> CreateProducts()
    {
        var list = new List<Product>();
        var products = new List<Product>();

        // PIZZAS
        var p1 = new Product
        {
            Id = "prod-001",
            Name = "Pizza Margherita",
            Description = "Molho de tomate, mussarela, manjericão fresco e azeite de oliva",
            ImageUrl = "🍕",
            Price = 42.90,
            Category = Category.Pizza,
            PrepTimeMinutes = 25,
            IsAvailable = true
        };
        p1.Customizations.AddRange(CreateMargheritaCustomizations());
        products.Add(p1);

        var p2 = new Product
        {
            Id = "prod-002",
            Name = "Pizza Pepperoni",
            Description = "Molho de tomate, mussarela, pepperoni e orégano",
            ImageUrl = "🍕",
            Price = 48.90,
            Category = Category.Pizza,
            PrepTimeMinutes = 25,
            IsAvailable = true
        };
        p2.Customizations.AddRange(CreatePepperoniCustomizations());
        products.Add(p2);

        var p3 = new Product
        {
            Id = "prod-003",
            Name = "Pizza Quatro Queijos",
            Description = "Molho de tomate, mussarela, provolone, gorgonzola e parmesão",
            ImageUrl = "🍕",
            Price = 52.90,
            Category = Category.Pizza,
            PrepTimeMinutes = 30,
            IsAvailable = true
        };
        p3.Customizations.AddRange(CreateQuatroQueijosCustomizations());
        products.Add(p3);

        var p4 = new Product
        {
            Id = "prod-004",
            Name = "Pizza Frango com Catupiry",
            Description = "Molho de tomate, mussarela, frango desfiado, catupiry, milho e azeitonas",
            ImageUrl = "🍕",
            Price = 49.90,
            Category = Category.Pizza,
            PrepTimeMinutes = 28,
            IsAvailable = true
        };
        p4.Customizations.AddRange(CreateFrangoCustomizations());
        products.Add(p4);

        var p5 = new Product
        {
            Id = "prod-005",
            Name = "Pizza Calabresa",
            Description = "Molho de tomate, mussarela, calabresa fatiada, cebola e orégano",
            ImageUrl = "🍕",
            Price = 44.90,
            Category = Category.Pizza,
            PrepTimeMinutes = 25,
            IsAvailable = true
        };
        p5.Customizations.AddRange(CreateCalabresaCustomizations());
        products.Add(p5);

        var p6 = new Product
        {
            Id = "prod-006",
            Name = "Pizza Portuguesa",
            Description = "Molho de tomate, mussarela, presunto, ovos, cebola, azeitonas, ervilha e orégano",
            ImageUrl = "🍕",
            Price = 51.90,
            Category = Category.Pizza,
            PrepTimeMinutes = 30,
            IsAvailable = false
        };
        p6.Customizations.AddRange(CreatePortuguesaCustomizations());
        products.Add(p6);

        // BEBIDAS
        products.Add(new Product { Id = "prod-007", Name = "Coca-Cola 2L", Description = "Refrigerante Coca-Cola original 2 litros", ImageUrl = "🥤", Price = 12.90, Category = Category.Drink, PrepTimeMinutes = 2, IsAvailable = true });
        products.Add(new Product { Id = "prod-008", Name = "Coca-Cola Zero 2L", Description = "Refrigerante Coca-Cola Zero açúcar 2 litros", ImageUrl = "🥤", Price = 12.90, Category = Category.Drink, PrepTimeMinutes = 2, IsAvailable = true });
        products.Add(new Product { Id = "prod-009", Name = "Guaraná Antarctica 2L", Description = "Refrigerante Guaraná Antarctica 2 litros", ImageUrl = "🥤", Price = 10.90, Category = Category.Drink, PrepTimeMinutes = 2, IsAvailable = true });
        products.Add(new Product { Id = "prod-010", Name = "Suco de Laranja 1L", Description = "Suco natural de laranja 1 litro", ImageUrl = "🧃", Price = 14.90, Category = Category.Drink, PrepTimeMinutes = 3, IsAvailable = true });
        products.Add(new Product { Id = "prod-011", Name = "Água Mineral 500ml", Description = "Água mineral sem gás 500ml", ImageUrl = "💧", Price = 4.50, Category = Category.Drink, PrepTimeMinutes = 1, IsAvailable = true });
        products.Add(new Product { Id = "prod-012", Name = "Cerveja Heineken 600ml", Description = "Cerveja Heineken long neck 600ml", ImageUrl = "🍺", Price = 16.90, Category = Category.Drink, PrepTimeMinutes = 2, IsAvailable = true });

        // SOBREMESAS
        products.Add(new Product { Id = "prod-013", Name = "Petit Gateau", Description = "Bolinho de chocolate com recheio cremoso, servido com sorvete de creme", ImageUrl = "🍫", Price = 18.90, Category = Category.Dessert, PrepTimeMinutes = 10, IsAvailable = true });
        products.Add(new Product { Id = "prod-014", Name = "Pudim de Leite Condensado", Description = "Pudim caseiro de leite condensado com calda de caramelo", ImageUrl = "🍮", Price = 12.90, Category = Category.Dessert, PrepTimeMinutes = 5, IsAvailable = true });
        products.Add(new Product { Id = "prod-015", Name = "Brownie com Sorvete", Description = "Brownie de chocolate quente com bola de sorvete de creme e calda de chocolate", ImageUrl = "🍰", Price = 16.90, Category = Category.Dessert, PrepTimeMinutes = 8, IsAvailable = true });

        // ACOMPANHAMENTOS
        products.Add(new Product { Id = "prod-016", Name = "Batata Frita Grande", Description = "Porção grande de batatas fritas crocantes", ImageUrl = "🍟", Price = 18.90, Category = Category.Side, PrepTimeMinutes = 12, IsAvailable = true });
        products.Add(new Product { Id = "prod-017", Name = "Onion Rings", Description = "Anéis de cebola empanados e fritos", ImageUrl = "🧅", Price = 16.90, Category = Category.Side, PrepTimeMinutes = 10, IsAvailable = true });
        products.Add(new Product { Id = "prod-018", Name = "Pão de Alho (4 unidades)", Description = "Pães de alho artesanais com queijo derretido", ImageUrl = "🧄", Price = 14.90, Category = Category.Side, PrepTimeMinutes = 8, IsAvailable = true });

        return products;
    }

    private static List<CustomizationOption> CreateMargheritaCustomizations()
    {
        var list = new List<CustomizationOption>();
        list.Add(new CustomizationOption
        {
            Id = "cust-001",
            Name = "Tamanho",
            IsRequired = true,
            AllowMultiple = false,
            Choices = new List<CustomizationChoice>
            {
                new CustomizationChoice { Id = "choice-001", Name = "Pequena (6 fatias)", AdditionalPrice = 0 },
                new CustomizationChoice { Id = "choice-002", Name = "Média (8 fatias)", AdditionalPrice = 8.00 },
                new CustomizationChoice { Id = "choice-003", Name = "Grande (10 fatias)", AdditionalPrice = 15.00 }
            }
        });
        list.Add(new CustomizationOption
        {
            Id = "cust-002",
            Name = "Borda",
            IsRequired = false,
            AllowMultiple = false,
            Choices = new List<CustomizationChoice>
            {
                new CustomizationChoice { Id = "choice-004", Name = "Sem borda", AdditionalPrice = 0 },
                new CustomizationChoice { Id = "choice-005", Name = "Borda recheada com catupiry", AdditionalPrice = 6.00 },
                new CustomizationChoice { Id = "choice-006", Name = "Borda recheada com cheddar", AdditionalPrice = 6.00 }
            }
        });
        list.Add(new CustomizationOption
        {
            Id = "cust-003",
            Name = "Ingredientes extras",
            IsRequired = false,
            AllowMultiple = true,
            Choices = new List<CustomizationChoice>
            {
                new CustomizationChoice { Id = "choice-007", Name = "Tomate seco", AdditionalPrice = 3.00 },
                new CustomizationChoice { Id = "choice-008", Name = "Rúcula", AdditionalPrice = 2.50 },
                new CustomizationChoice { Id = "choice-009", Name = "Parmesão", AdditionalPrice = 3.50 },
                new CustomizationChoice { Id = "choice-010", Name = "Azeitonas", AdditionalPrice = 2.00 }
            }
        });
        return list;
    }

    private static List<CustomizationOption> CreatePepperoniCustomizations()
    {
        var list = new List<CustomizationOption>();
        list.Add(new CustomizationOption
        {
            Id = "cust-004",
            Name = "Tamanho",
            IsRequired = true,
            AllowMultiple = false,
            Choices = new List<CustomizationChoice>
            {
                new CustomizationChoice { Id = "choice-011", Name = "Pequena (6 fatias)", AdditionalPrice = 0 },
                new CustomizationChoice { Id = "choice-012", Name = "Média (8 fatias)", AdditionalPrice = 8.00 },
                new CustomizationChoice { Id = "choice-013", Name = "Grande (10 fatias)", AdditionalPrice = 15.00 }
            }
        });
        list.Add(new CustomizationOption
        {
            Id = "cust-005",
            Name = "Borda",
            IsRequired = false,
            AllowMultiple = false,
            Choices = new List<CustomizationChoice>
            {
                new CustomizationChoice { Id = "choice-014", Name = "Sem borda", AdditionalPrice = 0 },
                new CustomizationChoice { Id = "choice-015", Name = "Borda recheada com catupiry", AdditionalPrice = 6.00 }
            }
        });
        return list;
    }

    private static List<CustomizationOption> CreateQuatroQueijosCustomizations()
    {
        var list = new List<CustomizationOption>();
        list.Add(new CustomizationOption
        {
            Id = "cust-006",
            Name = "Tamanho",
            IsRequired = true,
            AllowMultiple = false,
            Choices = new List<CustomizationChoice>
            {
                new CustomizationChoice { Id = "choice-016", Name = "Pequena (6 fatias)", AdditionalPrice = 0 },
                new CustomizationChoice { Id = "choice-017", Name = "Média (8 fatias)", AdditionalPrice = 8.00 },
                new CustomizationChoice { Id = "choice-018", Name = "Grande (10 fatias)", AdditionalPrice = 15.00 }
            }
        });
        return list;
    }

    private static List<CustomizationOption> CreateFrangoCustomizations()
    {
        var list = new List<CustomizationOption>();
        list.Add(new CustomizationOption
        {
            Id = "cust-007",
            Name = "Tamanho",
            IsRequired = true,
            AllowMultiple = false,
            Choices = new List<CustomizationChoice>
            {
                new CustomizationChoice { Id = "choice-019", Name = "Pequena (6 fatias)", AdditionalPrice = 0 },
                new CustomizationChoice { Id = "choice-020", Name = "Média (8 fatias)", AdditionalPrice = 8.00 },
                new CustomizationChoice { Id = "choice-021", Name = "Grande (10 fatias)", AdditionalPrice = 15.00 }
            }
        });
        return list;
    }

    private static List<CustomizationOption> CreateCalabresaCustomizations()
    {
        var list = new List<CustomizationOption>();
        list.Add(new CustomizationOption
        {
            Id = "cust-008",
            Name = "Tamanho",
            IsRequired = true,
            AllowMultiple = false,
            Choices = new List<CustomizationChoice>
            {
                new CustomizationChoice { Id = "choice-022", Name = "Pequena (6 fatias)", AdditionalPrice = 0 },
                new CustomizationChoice { Id = "choice-023", Name = "Média (8 fatias)", AdditionalPrice = 8.00 },
                new CustomizationChoice { Id = "choice-024", Name = "Grande (10 fatias)", AdditionalPrice = 15.00 }
            }
        });
        return list;
    }

    private static List<CustomizationOption> CreatePortuguesaCustomizations()
    {
        var list = new List<CustomizationOption>();
        list.Add(new CustomizationOption
        {
            Id = "cust-009",
            Name = "Tamanho",
            IsRequired = true,
            AllowMultiple = false,
            Choices = new List<CustomizationChoice>
            {
                new CustomizationChoice { Id = "choice-025", Name = "Pequena (6 fatias)", AdditionalPrice = 0 },
                new CustomizationChoice { Id = "choice-026", Name = "Média (8 fatias)", AdditionalPrice = 8.00 },
                new CustomizationChoice { Id = "choice-027", Name = "Grande (10 fatias)", AdditionalPrice = 15.00 }
            }
        });
        return list;
    }

    private static List<CartItem> CreateCartItems()
    {
        var list = new List<CartItem>();
        var products = Products;

        var item1 = new CartItem
        {
            Id = "cart-001",
            Product = products.First(p => p.Id == "prod-001"),
            Quantity = 1
        };
        item1.SelectedCustomizations.Add("cust-001", "choice-002");
        item1.SelectedCustomizations.Add("cust-002", "choice-005");
        item1.Notes = "Sem cebola por favor";
        list.Add(item1);

        var item2 = new CartItem
        {
            Id = "cart-002",
            Product = products.First(p => p.Id == "prod-007"),
            Quantity = 2
        };
        item2.Notes = "Bem gelado";
        list.Add(item2);

        return list;
    }

    private static List<Order> CreateOrders()
    {
        var list = new List<Order>();
        var products = Products;
        var addresses = Addresses;

        // Order 1
        var order1 = new Order
        {
            Id = "ord-20241120-001",
            UserId = "user-001",
            DeliveryAddress = addresses.First(a => a.Id == "addr-001"),
            PaymentMethod = PaymentMethod.Pix,
            Status = OrderStatus.Delivered,
            Subtotal = 61.80,
            DeliveryFee = 5.00,
            Notes = "Interfone 45",
            CreatedAt = new DateTime(2024, 11, 20, 19, 30, 0),
            EstimatedDeliveryTime = new DateTime(2024, 11, 20, 20, 15, 0)
        };
        order1.Items.Add(new OrderItem
        {
            Id = "item-001",
            Product = products.First(p => p.Id == "prod-002"),
            Quantity = 1,
            UnitPrice = 48.90,
            Customizations = new Dictionary<string, string> { { "cust-004", "choice-012" }, { "cust-005", "choice-014" } }
        });
        order1.Items.Add(new OrderItem
        {
            Id = "item-002",
            Product = products.First(p => p.Id == "prod-008"),
            Quantity = 1,
            UnitPrice = 12.90
        });
        order1.Timeline.AddRange(new List<StatusTimeline>
        {
            new StatusTimeline { Status = OrderStatus.Pending, Timestamp = new DateTime(2024, 11, 20, 19, 30, 0), Note = "Pedido recebido" },
            new StatusTimeline { Status = OrderStatus.Confirmed, Timestamp = new DateTime(2024, 11, 20, 19, 32, 0), Note = "Confirmado pela pizzaria" },
            new StatusTimeline { Status = OrderStatus.Preparing, Timestamp = new DateTime(2024, 11, 20, 19, 35, 0), Note = "Iniciando preparação" },
            new StatusTimeline { Status = OrderStatus.Baking, Timestamp = new DateTime(2024, 11, 20, 19, 45, 0), Note = "No forno" },
            new StatusTimeline { Status = OrderStatus.Ready, Timestamp = new DateTime(2024, 11, 20, 20, 0, 0), Note = "Pronto para entrega" },
            new StatusTimeline { Status = OrderStatus.OutForDelivery, Timestamp = new DateTime(2024, 11, 20, 20, 5, 0), Note = "Entregador a caminho" },
            new StatusTimeline { Status = OrderStatus.Delivered, Timestamp = new DateTime(2024, 11, 20, 20, 12, 0), Note = "Entregue ao cliente" }
        });
        list.Add(order1);

        // Order 2
        var order2 = new Order
        {
            Id = "ord-20241122-001",
            UserId = "user-001",
            DeliveryAddress = addresses.First(a => a.Id == "addr-001"),
            PaymentMethod = PaymentMethod.Card,
            Status = OrderStatus.OutForDelivery,
            Subtotal = 82.70,
            DeliveryFee = 5.00,
            Notes = "Portaria do condomínio",
            CreatedAt = new DateTime(2024, 11, 22, 20, 15, 0),
            EstimatedDeliveryTime = new DateTime(2024, 11, 22, 21, 0, 0)
        };
        order2.Items.Add(new OrderItem
        {
            Id = "item-003",
            Product = products.First(p => p.Id == "prod-003"),
            Quantity = 1,
            UnitPrice = 52.90,
            Customizations = new Dictionary<string, string> { { "cust-006", "choice-017" } }
        });
        order2.Items.Add(new OrderItem
        {
            Id = "item-004",
            Product = products.First(p => p.Id == "prod-013"),
            Quantity = 1,
            UnitPrice = 18.90
        });
        order2.Items.Add(new OrderItem
        {
            Id = "item-005",
            Product = products.First(p => p.Id == "prod-009"),
            Quantity = 1,
            UnitPrice = 10.90
        });
        order2.Timeline.AddRange(new List<StatusTimeline>
        {
            new StatusTimeline { Status = OrderStatus.Pending, Timestamp = new DateTime(2024, 11, 22, 20, 15, 0), Note = "Pedido recebido" },
            new StatusTimeline { Status = OrderStatus.Confirmed, Timestamp = new DateTime(2024, 11, 22, 20, 17, 0), Note = "Confirmado pela pizzaria" },
            new StatusTimeline { Status = OrderStatus.Preparing, Timestamp = new DateTime(2024, 11, 22, 20, 20, 0), Note = "Iniciando preparação" },
            new StatusTimeline { Status = OrderStatus.Baking, Timestamp = new DateTime(2024, 11, 22, 20, 35, 0), Note = "No forno" },
            new StatusTimeline { Status = OrderStatus.Ready, Timestamp = new DateTime(2024, 11, 22, 20, 45, 0), Note = "Pronto para entrega" },
            new StatusTimeline { Status = OrderStatus.OutForDelivery, Timestamp = new DateTime(2024, 11, 22, 20, 50, 0), Note = "Entregador a caminho" }
        });
        list.Add(order2);

        // Order 3
        var order3 = new Order
        {
            Id = "ord-20241124-001",
            UserId = "user-001",
            DeliveryAddress = addresses.First(a => a.Id == "addr-002"),
            PaymentMethod = PaymentMethod.Cash,
            Status = OrderStatus.Preparing,
            Subtotal = 104.70,
            DeliveryFee = 5.00,
            Notes = "Sala 1200",
            CreatedAt = new DateTime(2024, 11, 24, 18, 45, 0),
            EstimatedDeliveryTime = new DateTime(2024, 11, 24, 19, 30, 0)
        };
        order3.Items.Add(new OrderItem
        {
            Id = "item-006",
            Product = products.First(p => p.Id == "prod-001"),
            Quantity = 2,
            UnitPrice = 42.90,
            Customizations = new Dictionary<string, string> { { "cust-001", "choice-003" }, { "cust-002", "choice-006" } }
        });
        order3.Items.Add(new OrderItem
        {
            Id = "item-007",
            Product = products.First(p => p.Id == "prod-016"),
            Quantity = 1,
            UnitPrice = 18.90
        });
        order3.Timeline.AddRange(new List<StatusTimeline>
        {
            new StatusTimeline { Status = OrderStatus.Pending, Timestamp = new DateTime(2024, 11, 24, 18, 45, 0), Note = "Pedido recebido" },
            new StatusTimeline { Status = OrderStatus.Confirmed, Timestamp = new DateTime(2024, 11, 24, 18, 47, 0), Note = "Confirmado pela pizzaria" },
            new StatusTimeline { Status = OrderStatus.Preparing, Timestamp = new DateTime(2024, 11, 24, 18, 50, 0), Note = "Iniciando preparação" }
        });
        list.Add(order3);

        // Order 4
        var order4 = new Order
        {
            Id = "ord-20241115-001",
            UserId = "user-001",
            DeliveryAddress = addresses.First(a => a.Id == "addr-001"),
            PaymentMethod = PaymentMethod.Pix,
            Status = OrderStatus.Cancelled,
            Subtotal = 64.80,
            DeliveryFee = 5.00,
            Notes = "",
            CreatedAt = new DateTime(2024, 11, 15, 19, 0, 0),
            EstimatedDeliveryTime = new DateTime(2024, 11, 15, 19, 45, 0)
        };
        order4.Items.Add(new OrderItem
        {
            Id = "item-008",
            Product = products.First(p => p.Id == "prod-004"),
            Quantity = 1,
            UnitPrice = 49.90
        });
        order4.Items.Add(new OrderItem
        {
            Id = "item-009",
            Product = products.First(p => p.Id == "prod-010"),
            Quantity = 1,
            UnitPrice = 14.90
        });
        order4.Timeline.AddRange(new List<StatusTimeline>
        {
            new StatusTimeline { Status = OrderStatus.Pending, Timestamp = new DateTime(2024, 11, 15, 19, 0, 0), Note = "Pedido recebido" },
            new StatusTimeline { Status = OrderStatus.Confirmed, Timestamp = new DateTime(2024, 11, 15, 19, 2, 0), Note = "Confirmado pela pizzaria" },
            new StatusTimeline { Status = OrderStatus.Cancelled, Timestamp = new DateTime(2024, 11, 15, 19, 10, 0), Note = "Cancelado pelo cliente" }
        });
        list.Add(order4);

        return list;
    }

    public static List<Product> GetProductsByCategory(Category category)
    {
        return Products.Where(p => p.Category == category && p.IsAvailable).ToList();
    }

    public static Product? GetProductById(string id)
    {
        return Products.FirstOrDefault(p => p.Id == id);
    }
}