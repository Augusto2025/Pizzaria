namespace PizzariaDesktop.Models;

public class CustomizationChoice
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
    public string Name { get; set; } = string.Empty;
    public double AdditionalPrice { get; set; }
}

public class CustomizationOption
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
    public string Name { get; set; } = string.Empty; // "Borda", "Tamanho", "Ingredientes extras"
    public List<CustomizationChoice> Choices { get; set; } = new();
    public bool IsRequired { get; set; }
    public bool AllowMultiple { get; set; }
}

public class Product
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string ImageUrl { get; set; } = string.Empty;
    public double Price { get; set; }
    public Category Category { get; set; }
    public int PrepTimeMinutes { get; set; }
    public List<CustomizationOption> Customizations { get; set; } = new();
    public bool IsAvailable { get; set; } = true;

    public string FormattedPrice => $"R$ {Price:F2}";
    public string FormattedPrepTime => $"{PrepTimeMinutes} min";
    public string CategoryDisplayName => Category switch
    {
        Category.Pizza => "Pizzas",
        Category.Drink => "Bebidas",
        Category.Dessert => "Sobremesas",
        Category.Side => "Acompanhamentos",
        _ => Category.ToString()
    };
}