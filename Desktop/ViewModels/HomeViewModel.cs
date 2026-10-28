namespace PizzariaDesktop.ViewModels;

using System.Windows.Input;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data;

public class HomeViewModel : BaseViewModel
{
    private readonly MainViewModel _mainViewModel;
    private Order? _lastOrder;

    public HomeViewModel(MainViewModel mainViewModel)
    {
        _mainViewModel = mainViewModel;
        _lastOrder = MockData.Orders.FirstOrDefault(o => o.Status != OrderStatus.Delivered && o.Status != OrderStatus.Cancelled);

        GoToMenuCommand = new RelayCommand(_ => _mainViewModel.NavigateToMenu());
        GoToOrdersCommand = new RelayCommand(_ => _mainViewModel.NavigateToOrders());
        GoToProfileCommand = new RelayCommand(_ => _mainViewModel.NavigateToProfile());
        GoToCartCommand = new RelayCommand(_ => _mainViewModel.NavigateToCart());
    }

    public User? CurrentUser => _mainViewModel.CurrentUser;
    public string WelcomeMessage => CurrentUser != null ? $"Olá, {CurrentUser.Name.Split(' ')[0]}! 👋" : "Bem-vindo!";
    public int CartItemCount => _mainViewModel.CartItemCount;
    public string FormattedCartSubtotal => _mainViewModel.FormattedCartSubtotal;

    public Order? LastOrder => _lastOrder;
    public bool HasLastOrder => _lastOrder != null;
    public string LastOrderStatusText => _lastOrder?.StatusDisplayName ?? "";
    public string LastOrderTimeText => _lastOrder != null ? $"Pedido #{_lastOrder.ShortId} - {_lastOrder.FormattedCreatedAt}" : "";

    public ICommand GoToMenuCommand { get; }
    public ICommand GoToOrdersCommand { get; }
    public ICommand GoToProfileCommand { get; }
    public ICommand GoToCartCommand { get; }

    // Promotions (static)
    public List<Promotion> Promotions { get; } = new()
    {
        new Promotion { Title = "🍕 Terça da Pizza", Description = "Todas as pizzas médias com 20% OFF", Badge = "TERÇA", Color = "#FF6B35" },
        new Promotion { Title = "🥤 Combo Família", Description = "2 Pizzas Grandes + 2L Refrigerante + Batata Frita", Badge = "COMBO", Color = "#28A745" },
        new Promotion { Title = "🍰 Sobremesa Grátis", Description = "Na compra de qualquer pizza grande", Badge = "PROMO", Color = "#DC3545" }
    };
}

public class Promotion
{
    public string Title { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string Badge { get; set; } = string.Empty;
    public string Color { get; set; } = "#FF6B35";
}