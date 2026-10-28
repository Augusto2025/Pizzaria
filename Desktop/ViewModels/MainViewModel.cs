namespace PizzariaDesktop.ViewModels;

using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows.Input;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data;
using System.Collections.ObjectModel;

public class MainViewModel : BaseViewModel
{
    private BaseViewModel _currentView;
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
        var loginVM = new LoginViewModel();
        loginVM.OnLoginSuccess += user => Login(user);
        loginVM.OnGoToRegister += () => { /* TODO: navigate to register */ };
        CurrentView = loginVM;

        NavigateToHomeCommand = new RelayCommand(_ => NavigateToHome());
        NavigateToMenuCommand = new RelayCommand(_ => NavigateToMenu());
        NavigateToCartCommand = new RelayCommand(_ => NavigateToCart());
        NavigateToOrdersCommand = new RelayCommand(_ => NavigateToOrders());
        NavigateToProfileCommand = new RelayCommand(_ => NavigateToProfile());
        LogoutCommand = new RelayCommand(_ => Logout());
        ToggleSidebarCommand = new RelayCommand(_ => { /* Toggle sidebar logic */ });
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
            CartItems.Add(new CartItem { Product = product, Quantity = quantity });
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
        CartItems.Clear();
        OnCartChanged();
    }

    private void OnCartChanged()
    {
        OnPropertyChanged(nameof(CartItemCount));
        OnPropertyChanged(nameof(CartSubtotal));
        OnPropertyChanged(nameof(FormattedCartSubtotal));
    }
}