namespace PizzariaDesktop.ViewModels;

using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows.Input;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data;
using PizzariaDesktop.Services;
using System.Collections.ObjectModel;
using System.Linq;
using Microsoft.Extensions.DependencyInjection;

public class MainViewModel : BaseViewModel
{
    private BaseViewModel? _currentView;
    private bool _isLoggedIn = false;
    private User? _currentUser;

    public BaseViewModel CurrentView
    {
        get => _currentView;
        set => SetProperty(ref _currentView, value);
    }

    public bool IsLoggedIn
    {
        get => _isLoggedIn;
        set => SetProperty(ref _isLoggedIn, value);
    }

    public User? CurrentUser
    {
        get => _currentUser;
        set => SetProperty(ref _currentUser, value);
    }

    public ObservableCollection<CartItem> CartItems { get; } = new(MockData.CartItems);
    public ObservableCollection<Order> UserOrders { get; } = new(MockData.Orders.OrderByDescending(o => o.CreatedAt));

    public int CartItemCount => CartItems.Sum(c => c.Quantity);
    public double CartSubtotal => CartItems.Sum(c => c.TotalPrice);
    public string FormattedCartSubtotal => $"R$ {CartSubtotal:F2}";

    // Commands
    public ICommand NavigateToHomeCommand { get; }
    public ICommand NavigateToMenuCommand { get; }
    public ICommand NavigateToCartCommand { get; }
    public ICommand NavigateToOrdersCommand { get; }
    public ICommand NavigateToProfileCommand { get; }
    public ICommand LogoutCommand { get; }
    public ICommand ToggleSidebarCommand { get; }

    public MainViewModel()
    {
        // Subscribe to cart changes
        foreach (var item in CartItems)
        {
            item.PropertyChanged += (s, e) => OnCartChanged();
        }

        // Setup login view with event handling
        var loginVM = CreateLoginViewModel();
        loginVM.OnLoginSuccess += user => Login(user);
        loginVM.OnGoToRegister += NavigateToRegister;
        CurrentView = loginVM;

        NavigateToHomeCommand = new RelayCommand(_ => NavigateToHome());
        NavigateToMenuCommand = new RelayCommand(_ => NavigateToMenu());
        NavigateToCartCommand = new RelayCommand(_ => NavigateToCart());
        NavigateToOrdersCommand = new RelayCommand(_ => NavigateToOrders());
        NavigateToProfileCommand = new RelayCommand(_ => NavigateToProfile());
        LogoutCommand = new RelayCommand(_ => Logout());
        ToggleSidebarCommand = new RelayCommand(_ => { /* Toggle sidebar logic */ });
    }

    private LoginViewModel CreateLoginViewModel()
    {
        // Try to get IAuthService from ServiceLocator if available
        IAuthService? authService = null;
        try
        {
            authService = ServiceLocator.GetService<IAuthService>();
        }
        catch { }

        return authService != null ? new LoginViewModel(authService) : new LoginViewModel();
    }

    private RegisterViewModel CreateRegisterViewModel()
    {
        // Try to get IAuthService from ServiceLocator if available
        IAuthService? authService = null;
        try
        {
            authService = ServiceLocator.GetService<IAuthService>();
        }
        catch { }

        return authService != null ? new RegisterViewModel(authService) : new RegisterViewModel();
    }

    public void NavigateToRegister()
    {
        var registerVM = CreateRegisterViewModel();
        registerVM.OnRegisterSuccess += user => Login(user);
        registerVM.OnGoToLogin += () => CurrentView = CreateLoginViewModel();
        CurrentView = registerVM;
    }

    public void NavigateTo(BaseViewModel viewModel)
    {
        CurrentView = viewModel;
    }

    public void Login(User user)
    {
        CurrentUser = user;
        IsLoggedIn = true;
        NavigateTo(new HomeViewModel(this));
    }

    public void Logout()
    {
        CurrentUser = null;
        IsLoggedIn = false;
        NavigateTo(new LoginViewModel());
    }

    public void NavigateToHome() => NavigateTo(new HomeViewModel(this));
    public void NavigateToMenu() => NavigateTo(new MenuViewModel(this));
    public void NavigateToCart() => NavigateTo(new CartViewModel(this));
    public void NavigateToOrders() => NavigateTo(new OrdersViewModel(this));
    public void NavigateToProfile() => NavigateTo(new ProfileViewModel(this));

    public void AddToCart(Product product, int quantity = 1)
    {
        var existingItem = CartItems.FirstOrDefault(c => c.Product.Id == product.Id);
        if (existingItem != null)
        {
            existingItem.Quantity += quantity;
        }
        else
        {
            var newItem = new CartItem { Product = product, Quantity = quantity };
            newItem.PropertyChanged += (s, e) => OnCartChanged();
            CartItems.Add(newItem);
        }
        OnCartChanged();
    }

    public void RemoveFromCart(string cartItemId)
    {
        var item = CartItems.FirstOrDefault(c => c.Id == cartItemId);
        if (item != null)
        {
            CartItems.Remove(item);
            OnCartChanged();
        }
    }

    public void UpdateCartItemQuantity(string cartItemId, int quantity)
    {
        var item = CartItems.FirstOrDefault(c => c.Id == cartItemId);
        if (item != null)
        {
            if (quantity <= 0)
            {
                CartItems.Remove(item);
            }
            else
            {
                item.Quantity = quantity;
            }
            OnCartChanged();
        }
    }

    public void ClearCart()
    {
        foreach (var item in CartItems)
        {
            item.PropertyChanged -= (s, e) => OnCartChanged();
        }
        CartItems.Clear();
        OnCartChanged();
    }

    public void AddOrderToHistory(Order order)
    {
        // Add to the beginning of the list (most recent first)
        UserOrders.Insert(0, order);
    }

    private void OnCartChanged()
    {
        OnPropertyChanged(nameof(CartItemCount));
        OnPropertyChanged(nameof(CartSubtotal));
        OnPropertyChanged(nameof(FormattedCartSubtotal));
    }
}