namespace PizzariaDesktop.Data.Entities;

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using PizzariaDesktop.Models;

[Table("users")]
public class UserEntity
{
    [Key]
    [MaxLength(50)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    [Required]
    [MaxLength(100)]
    public string Name { get; set; } = string.Empty;

    [Required]
    [MaxLength(150)]
    public string Email { get; set; } = string.Empty;

    [Required]
    [MaxLength(255)]
    public string PasswordHash { get; set; } = string.Empty;

    [MaxLength(20)]
    public string Phone { get; set; } = string.Empty;

    [NotMapped]
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    // Navigation
    public virtual ICollection<AddressEntity> Addresses { get; set; } = new List<AddressEntity>();
    public virtual ICollection<CartItemEntity> CartItems { get; set; } = new List<CartItemEntity>();
    public virtual ICollection<OrderEntity> Orders { get; set; } = new List<OrderEntity>();

    // Converter para Model
    public User ToModel()
    {
        return new User
        {
            Id = Id,
            Name = Name,
            Email = Email,
            Phone = Phone,
            CreatedAt = CreatedAt,
            Addresses = Addresses?.Select(a => a.ToModel()).ToList() ?? new List<Address>()
        };
    }

    // Criar a partir do Model
    public static UserEntity FromModel(User user, string passwordHash)
    {
        return new UserEntity
        {
            Id = user.Id,
            Name = user.Name,
            Email = user.Email,
            PasswordHash = passwordHash,
            Phone = user.Phone,
            CreatedAt = user.CreatedAt
        };
    }
}

[Table("addresses")]
public class AddressEntity
{
    [Key]
    [MaxLength(50)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    [Required]
    [MaxLength(50)]
    public string UserId { get; set; } = string.Empty;

    [Required]
    [MaxLength(50)]
    public string Label { get; set; } = string.Empty;

    [Required]
    [MaxLength(100)]
    public string Street { get; set; } = string.Empty;

    [Required]
    [MaxLength(20)]
    public string Number { get; set; } = string.Empty;

    [MaxLength(50)]
    public string Complement { get; set; } = string.Empty;

    [Required]
    [MaxLength(50)]
    public string Neighborhood { get; set; } = string.Empty;

    [Required]
    [MaxLength(50)]
    public string City { get; set; } = string.Empty;

    [Required]
    [MaxLength(2)]
    public string State { get; set; } = string.Empty;

    [Required]
    [MaxLength(10)]
    public string ZipCode { get; set; } = string.Empty;

    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public bool IsDefault { get; set; }

    // Navigation
    [ForeignKey(nameof(UserId))]
    public virtual UserEntity User { get; set; } = null!;

    public Address ToModel()
    {
        return new Address
        {
            Id = Id,
            Label = Label,
            Street = Street,
            Number = Number,
            Complement = Complement,
            Neighborhood = Neighborhood,
            City = City,
            State = State,
            ZipCode = ZipCode,
            Latitude = Latitude,
            Longitude = Longitude,
            IsDefault = IsDefault
        };
    }

    public static AddressEntity FromModel(Address address, string userId)
    {
        return new AddressEntity
        {
            Id = address.Id,
            UserId = userId,
            Label = address.Label,
            Street = address.Street,
            Number = address.Number,
            Complement = address.Complement,
            Neighborhood = address.Neighborhood,
            City = address.City,
            State = address.State,
            ZipCode = address.ZipCode,
            Latitude = address.Latitude,
            Longitude = address.Longitude,
            IsDefault = address.IsDefault
        };
    }
}

[Table("categories")]
public class CategoryEntity
{
    [Key]
    public int Id { get; set; }

    [Required]
    [MaxLength(20)]
    public string Name { get; set; } = string.Empty;

    [Required]
    [MaxLength(50)]
    public string DisplayName { get; set; } = string.Empty;

    public int SortOrder { get; set; }

    public virtual ICollection<ProductEntity> Products { get; set; } = new List<ProductEntity>();
}

[Table("products")]
public class ProductEntity
{
    [Key]
    [MaxLength(50)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    [Required]
    [MaxLength(100)]
    public string Name { get; set; } = string.Empty;

    [MaxLength(500)]
    public string Description { get; set; } = string.Empty;

    [MaxLength(255)]
    public string ImageUrl { get; set; } = string.Empty;

    [Required]
    public double Price { get; set; }

    [Required]
    public int CategoryId { get; set; }

    [Required]
    public int PrepTimeMinutes { get; set; }

    public bool IsAvailable { get; set; } = true;

    // Navigation
    [ForeignKey(nameof(CategoryId))]
    public virtual CategoryEntity Category { get; set; } = null!;

    public virtual ICollection<CustomizationOptionEntity> Customizations { get; set; } = new List<CustomizationOptionEntity>();

    public Product ToModel()
    {
        return new Product
        {
            Id = Id,
            Name = Name,
            Description = Description,
            ImageUrl = ImageUrl,
            Price = Price,
            Category = (Category)(CategoryId - 1), // Assumindo enum ordenado
            PrepTimeMinutes = PrepTimeMinutes,
            IsAvailable = IsAvailable,
            Customizations = Customizations?.Select(c => c.ToModel()).ToList() ?? new List<CustomizationOption>()
        };
    }

    public static ProductEntity FromModel(Product product)
    {
        return new ProductEntity
        {
            Id = product.Id,
            Name = product.Name,
            Description = product.Description,
            ImageUrl = product.ImageUrl,
            Price = product.Price,
            CategoryId = (int)product.Category + 1,
            PrepTimeMinutes = product.PrepTimeMinutes,
            IsAvailable = product.IsAvailable
        };
    }
}

[Table("customization_options")]
public class CustomizationOptionEntity
{
    [Key]
    [MaxLength(50)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    [Required]
    [MaxLength(50)]
    public string ProductId { get; set; } = string.Empty;

    [Required]
    [MaxLength(50)]
    public string Name { get; set; } = string.Empty;

    public bool IsRequired { get; set; }
    public bool AllowMultiple { get; set; }
    public int SortOrder { get; set; }

    // Navigation
    [ForeignKey(nameof(ProductId))]
    public virtual ProductEntity Product { get; set; } = null!;

    public virtual ICollection<CustomizationChoiceEntity> Choices { get; set; } = new List<CustomizationChoiceEntity>();

    public CustomizationOption ToModel()
    {
        return new CustomizationOption
        {
            Id = Id,
            Name = Name,
            IsRequired = IsRequired,
            AllowMultiple = AllowMultiple,
            Choices = Choices?.Select(c => c.ToModel()).ToList() ?? new List<CustomizationChoice>()
        };
    }

    public static CustomizationOptionEntity FromModel(CustomizationOption option, string productId)
    {
        return new CustomizationOptionEntity
        {
            Id = option.Id,
            ProductId = productId,
            Name = option.Name,
            IsRequired = option.IsRequired,
            AllowMultiple = option.AllowMultiple,
            Choices = option.Choices?.Select(c => CustomizationChoiceEntity.FromModel(c, option.Id)).ToList() ?? new List<CustomizationChoiceEntity>()
        };
    }
}

[Table("customization_choices")]
public class CustomizationChoiceEntity
{
    [Key]
    [MaxLength(50)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    [Required]
    [MaxLength(50)]
    public string OptionId { get; set; } = string.Empty;

    [Required]
    [MaxLength(50)]
    public string Name { get; set; } = string.Empty;

    public double AdditionalPrice { get; set; }
    public int SortOrder { get; set; }

    // Navigation
    [ForeignKey(nameof(OptionId))]
    public virtual CustomizationOptionEntity Option { get; set; } = null!;

    public CustomizationChoice ToModel()
    {
        return new CustomizationChoice
        {
            Id = Id,
            Name = Name,
            AdditionalPrice = AdditionalPrice
        };
    }

    public static CustomizationChoiceEntity FromModel(CustomizationChoice choice, string optionId)
    {
        return new CustomizationChoiceEntity
        {
            Id = choice.Id,
            OptionId = optionId,
            Name = choice.Name,
            AdditionalPrice = choice.AdditionalPrice
        };
    }
}

[Table("cart_items")]
public class CartItemEntity
{
    [Key]
    [MaxLength(50)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    [Required]
    [MaxLength(50)]
    public string UserId { get; set; } = string.Empty;

    [Required]
    [MaxLength(50)]
    public string ProductId { get; set; } = string.Empty;

    public int Quantity { get; set; } = 1;

    [MaxLength(2000)]
    public string SelectedCustomizationsJson { get; set; } = "{}";

    [MaxLength(500)]
    public string Notes { get; set; } = string.Empty;

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    // Navigation
    [ForeignKey(nameof(UserId))]
    public virtual UserEntity User { get; set; } = null!;

    [ForeignKey(nameof(ProductId))]
    public virtual ProductEntity Product { get; set; } = null!;

    public CartItem ToModel(Product product)
    {
        var customizations = new Dictionary<string, string>();
        if (!string.IsNullOrEmpty(SelectedCustomizationsJson) && SelectedCustomizationsJson != "{}")
        {
            try
            {
                customizations = System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, string>>(SelectedCustomizationsJson)
                    ?? new Dictionary<string, string>();
            }
            catch { }
        }

        return new CartItem
        {
            Id = Id,
            Product = product,
            Quantity = Quantity,
            SelectedCustomizations = customizations,
            Notes = Notes
        };
    }

    public static CartItemEntity FromModel(CartItem cartItem, string userId)
    {
        return new CartItemEntity
        {
            Id = cartItem.Id,
            UserId = userId,
            ProductId = cartItem.Product.Id,
            Quantity = cartItem.Quantity,
            SelectedCustomizationsJson = System.Text.Json.JsonSerializer.Serialize(cartItem.SelectedCustomizations),
            Notes = cartItem.Notes,
            CreatedAt = DateTime.UtcNow
        };
    }
}

[Table("orders")]
public class OrderEntity
{
    [Key]
    [MaxLength(50)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    [Required]
    [MaxLength(50)]
    public string UserId { get; set; } = string.Empty;

    [Required]
    [MaxLength(50)]
    public string DeliveryAddressId { get; set; } = string.Empty;

    public int PaymentMethod { get; set; } // Enum PaymentMethod
    public int Status { get; set; } // Enum OrderStatus

    public double Subtotal { get; set; }
    public double DeliveryFee { get; set; }

    [MaxLength(500)]
    public string Notes { get; set; } = string.Empty;

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? EstimatedDeliveryTime { get; set; }

    // Navigation
    [ForeignKey(nameof(UserId))]
    public virtual UserEntity User { get; set; } = null!;

    [ForeignKey(nameof(DeliveryAddressId))]
    public virtual AddressEntity DeliveryAddress { get; set; } = null!;

    public virtual ICollection<OrderItemEntity> Items { get; set; } = new List<OrderItemEntity>();
    public virtual ICollection<OrderStatusTimelineEntity> Timeline { get; set; } = new List<OrderStatusTimelineEntity>();

    public Order ToModel()
    {
        return new Order
        {
            Id = Id,
            UserId = UserId,
            DeliveryAddress = DeliveryAddress?.ToModel() ?? new Address(),
            PaymentMethod = (PaymentMethod)PaymentMethod,
            Status = (OrderStatus)Status,
            Subtotal = Subtotal,
            DeliveryFee = DeliveryFee,
            Notes = Notes,
            CreatedAt = CreatedAt,
            EstimatedDeliveryTime = EstimatedDeliveryTime,
            Items = Items?.Select(i => i.ToModel()).ToList() ?? new List<OrderItem>(),
            Timeline = Timeline?.Select(t => t.ToModel()).ToList() ?? new List<StatusTimeline>()
        };
    }

    public static OrderEntity FromModel(Order order)
    {
        return new OrderEntity
        {
            Id = order.Id,
            UserId = order.UserId,
            DeliveryAddressId = order.DeliveryAddress.Id,
            PaymentMethod = (int)order.PaymentMethod,
            Status = (int)order.Status,
            Subtotal = order.Subtotal,
            DeliveryFee = order.DeliveryFee,
            Notes = order.Notes,
            CreatedAt = order.CreatedAt,
            EstimatedDeliveryTime = order.EstimatedDeliveryTime,
            Items = order.Items?.Select(i => OrderItemEntity.FromModel(i, order.Id)).ToList() ?? new List<OrderItemEntity>(),
            Timeline = order.Timeline?.Select(t => OrderStatusTimelineEntity.FromModel(t, order.Id)).ToList() ?? new List<OrderStatusTimelineEntity>()
        };
    }
}

[Table("order_items")]
public class OrderItemEntity
{
    [Key]
    [MaxLength(50)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    [Required]
    [MaxLength(50)]
    public string OrderId { get; set; } = string.Empty;

    [Required]
    [MaxLength(50)]
    public string ProductId { get; set; } = string.Empty;

    public int Quantity { get; set; }
    public double UnitPrice { get; set; }

    [MaxLength(2000)]
    public string CustomizationsJson { get; set; } = "{}";

    [MaxLength(500)]
    public string Notes { get; set; } = string.Empty;

    // Navigation
    [ForeignKey(nameof(OrderId))]
    public virtual OrderEntity Order { get; set; } = null!;

    [ForeignKey(nameof(ProductId))]
    public virtual ProductEntity Product { get; set; } = null!;

    public OrderItem ToModel()
    {
        var customizations = new Dictionary<string, string>();
        if (!string.IsNullOrEmpty(CustomizationsJson) && CustomizationsJson != "{}")
        {
            try
            {
                customizations = System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, string>>(CustomizationsJson)
                    ?? new Dictionary<string, string>();
            }
            catch { }
        }

        return new OrderItem
        {
            Id = Id,
            Product = Product?.ToModel() ?? new Product { Id = ProductId, Name = "Produto removido" },
            Quantity = Quantity,
            UnitPrice = UnitPrice,
            Customizations = customizations,
            Notes = Notes
        };
    }

    public static OrderItemEntity FromModel(OrderItem item, string orderId)
    {
        return new OrderItemEntity
        {
            Id = item.Id,
            OrderId = orderId,
            ProductId = item.Product.Id,
            Quantity = item.Quantity,
            UnitPrice = item.UnitPrice,
            CustomizationsJson = System.Text.Json.JsonSerializer.Serialize(item.Customizations),
            Notes = item.Notes
        };
    }
}

[Table("order_status_timeline")]
public class OrderStatusTimelineEntity
{
    [Key]
    public int Id { get; set; }

    [Required]
    [MaxLength(50)]
    public string OrderId { get; set; } = string.Empty;

    public int Status { get; set; }
    public DateTime Timestamp { get; set; }

    [MaxLength(500)]
    public string Note { get; set; } = string.Empty;

    // Navigation
    [ForeignKey(nameof(OrderId))]
    public virtual OrderEntity Order { get; set; } = null!;

    public StatusTimeline ToModel()
    {
        return new StatusTimeline
        {
            Status = (OrderStatus)Status,
            Timestamp = Timestamp,
            Note = Note
        };
    }

    public static OrderStatusTimelineEntity FromModel(StatusTimeline timeline, string orderId)
    {
        return new OrderStatusTimelineEntity
        {
            OrderId = orderId,
            Status = (int)timeline.Status,
            Timestamp = timeline.Timestamp,
            Note = timeline.Note ?? string.Empty
        };
    }
}