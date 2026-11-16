namespace PizzariaDesktop.Api.DTOs;

using System.ComponentModel.DataAnnotations;

public record CartItemDto(
    string Id,
    string ProductId,
    string ProductName,
    string ProductDescription,
    string ProductImageUrl,
    decimal ProductPrice,
    int Quantity,
    Dictionary<string, string> SelectedCustomizations,
    string Notes
);

public record CartDto(
    List<CartItemDto> Items,
    decimal Subtotal,
    decimal DeliveryFee,
    decimal Total
);

public record AddToCartRequest(
    [Required] string ProductId,
    [Required][Range(1, 100)] int Quantity,
    Dictionary<string, string>? SelectedCustomizations = null,
    string? Notes = null
);

public record UpdateCartItemRequest(
    [Required][Range(1, 100)] int Quantity
);

public record CheckoutRequest(
    [Required] string DeliveryAddressId,
    [Required] int PaymentMethod,
    string? Notes = null
);

public record OrderItemDto(
    string Id,
    string ProductId,
    string ProductName,
    string ProductImageUrl,
    int Quantity,
    decimal UnitPrice,
    Dictionary<string, string> Customizations,
    string Notes,
    decimal TotalPrice
);

public record OrderDto(
    string Id,
    string UserId,
    DateTime CreatedAt,
    OrderStatusDto Status,
    AddressDto DeliveryAddress,
    int PaymentMethod,
    decimal Subtotal,
    decimal DeliveryFee,
    decimal Total,
    string Notes,
    DateTime? EstimatedDeliveryTime,
    List<OrderItemDto> Items,
    List<StatusTimelineDto> Timeline
);

public record OrderStatusDto(
    int Value,
    string Label,
    string Color
);

public record StatusTimelineDto(
    int Id,
    OrderStatusDto Status,
    DateTime Timestamp,
    string Note
);

public record OrdersResponse(
    List<OrderDto> Orders
);