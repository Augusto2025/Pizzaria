namespace PizzariaDesktop.Api.DTOs;

public record CategoryDto(
    int Id,
    string Name,
    string DisplayName,
    int SortOrder
);

public record ProductDto(
    string Id,
    string Name,
    string Description,
    string ImageUrl,
    decimal Price,
    int CategoryId,
    string CategoryName,
    string CategoryDisplayName,
    int PrepTimeMinutes,
    bool IsAvailable,
    List<CustomizationOptionDto> Customizations
);

public record CustomizationOptionDto(
    string Id,
    string Name,
    bool IsRequired,
    bool AllowMultiple,
    int SortOrder,
    List<CustomizationChoiceDto> Choices
);

public record CustomizationChoiceDto(
    string Id,
    string Name,
    decimal AdditionalPrice,
    int SortOrder
);

public record MenuResponse(
    List<CategoryDto> Categories,
    List<ProductDto> Products
);