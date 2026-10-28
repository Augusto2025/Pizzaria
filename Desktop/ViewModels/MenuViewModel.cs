namespace PizzariaDesktop.ViewModels;

using System.Collections.ObjectModel;
using System.Windows.Input;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data;

public class MenuViewModel : BaseViewModel
{
    private readonly MainViewModel _mainViewModel;
    private Category _selectedCategory = Category.Pizza;
    private string _searchText = string.Empty;

    public MenuViewModel(MainViewModel mainViewModel)
    {
        _mainViewModel = mainViewModel;
        Categories = Enum.GetValues(typeof(Category)).Cast<Category>().ToList();
        UpdateFilteredProducts();

        SelectCategoryCommand = new RelayCommand(c => SelectCategory((Category)c!));
        AddToCartCommand = new RelayCommand(p => AddToCart((Product)p!));
        GoToCartCommand = new RelayCommand(_ => _mainViewModel.NavigateToCart());
    }

    public List<Category> Categories { get; }
    public ObservableCollection<Product> FilteredProducts { get; } = new();

    public Category SelectedCategory
    {
        get => _selectedCategory;
        set
        {
            if (SetProperty(ref _selectedCategory, value))
            {
                UpdateFilteredProducts();
            }
        }
    }

    public string SearchText
    {
        get => _searchText;
        set
        {
            if (SetProperty(ref _searchText, value))
            {
                UpdateFilteredProducts();
            }
        }
    }

    public string SelectedCategoryDisplayName => SelectedCategory switch
    {
        Category.Pizza => "Pizzas",
        Category.Drink => "Bebidas",
        Category.Dessert => "Sobremesas",
        Category.Side => "Acompanhamentos",
        _ => SelectedCategory.ToString()
    };

    public ICommand SelectCategoryCommand { get; }
    public ICommand AddToCartCommand { get; }
    public ICommand GoToCartCommand { get; }

    // Expose cart info from MainViewModel
    public int CartItemCount => _mainViewModel.CartItemCount;
    public string FormattedCartSubtotal => _mainViewModel.FormattedCartSubtotal;

    public void SelectCategory(Category category) => SelectedCategory = category;

    public void AddToCart(Product product) => _mainViewModel.AddToCart(product);

    private void UpdateFilteredProducts()
    {
        var products = MockData.GetProductsByCategory(SelectedCategory);

        if (!string.IsNullOrWhiteSpace(SearchText))
        {
            products = products.Where(p =>
                p.Name.Contains(SearchText, StringComparison.OrdinalIgnoreCase) ||
                p.Description.Contains(SearchText, StringComparison.OrdinalIgnoreCase)
            ).ToList();
        }

        FilteredProducts.Clear();
        foreach (var product in products)
        {
            FilteredProducts.Add(product);
        }
    }
}