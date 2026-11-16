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
using PizzariaDesktop.Data.Repositories;

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

    public ObservableCollection<CartItem> CartItems { get; } = new();
    public ObservableCollection<Order> UserOrders { get; } = new();

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
        // LoginViewModel now creates its own scope during login operation
        return new LoginViewModel();
    }

    private RegisterViewModel CreateRegisterViewModel()
    {
        // RegisterViewModel now creates its own scope during registration operation
        return new RegisterViewModel();
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

    public async void Login(User user)
    {
        CurrentUser = user;
        IsLoggedIn = true;
        await LoadCartFromDatabaseAsync();
        await LoadUserAddressesAsync();
        NavigateTo(new HomeViewModel(this));
    }

    public async Task LoadUserAddressesAsync()
    {
        if (CurrentUser == null) return;

        try
        {
            using var scope = App.Services.CreateScope();
            var addressRepo = scope.ServiceProvider.GetRequiredService<IAddressRepository>();
            var addresses = await addressRepo.GetByUserIdAsync(CurrentUser.Id);
            CurrentUser.Addresses.Clear();
            CurrentUser.Addresses.AddRange(addresses);
            System.Diagnostics.Debug.WriteLine($"[MainViewModel] Loaded {addresses.Count} addresses from database for user {CurrentUser.Id}");
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"[MainViewModel] Erro ao carregar endereços do usuário: {ex.Message}");
            System.Diagnostics.Debug.WriteLine($"[MainViewModel] StackTrace: {ex.StackTrace}");
        }
    }

    public async Task LoadCartFromDatabaseAsync()
    {
        if (CurrentUser == null) return;

        try
        {
            using var scope = App.Services.CreateScope();
            var cartRepo = scope.ServiceProvider.GetRequiredService<ICartRepository>();
            var cartItems = await cartRepo.GetByUserIdAsync(CurrentUser.Id);
            CartItems.Clear();
            foreach (var item in cartItems)
            {
                item.PropertyChanged += (s, e) => OnCartChanged();
                CartItems.Add(item);
            }
            OnCartChanged();
            System.Diagnostics.Debug.WriteLine($"[MainViewModel] Loaded {cartItems.Count} cart items from database for user {CurrentUser.Id}");
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"[MainViewModel] Erro ao carregar carrinho: {ex.Message}");
            System.Diagnostics.Debug.WriteLine($"[MainViewModel] StackTrace: {ex.StackTrace}");
        }
    }

    public async Task SaveCartToDatabaseAsync()
    {
        if (CurrentUser == null) return;

        try
        {
            using var scope = App.Services.CreateScope();
            var cartRepo = scope.ServiceProvider.GetRequiredService<ICartRepository>();
            await cartRepo.ClearAsync(CurrentUser.Id);
            foreach (var item in CartItems)
            {
                await cartRepo.AddAsync(item, CurrentUser.Id);
            }
            System.Diagnostics.Debug.WriteLine($"[MainViewModel] Saved {CartItems.Count} cart items to database for user {CurrentUser.Id}");
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"[MainViewModel] Erro ao salvar carrinho: {ex.Message}");
            System.Diagnostics.Debug.WriteLine($"[MainViewModel] StackTrace: {ex.StackTrace}");
        }
    }

    public async void Logout()
    {
        // Save cart to database before logging out
        if (CurrentUser != null && CartItems.Count > 0)
        {
            await SaveCartToDatabaseAsync();
        }

        CurrentUser = null;
        IsLoggedIn = false;

        // Create and configure LoginViewModel with event subscriptions (same as constructor)
        var loginVM = CreateLoginViewModel();
        loginVM.OnLoginSuccess += user => Login(user);
        loginVM.OnGoToRegister += NavigateToRegister;
        NavigateTo(loginVM);
    }

    public void NavigateToHome() => NavigateTo(new HomeViewModel(this));
    public void NavigateToMenu() => NavigateTo(new MenuViewModel(this));
    public void NavigateToCart() => NavigateTo(new CartViewModel(this));
    public void NavigateToOrders() => NavigateTo(new OrdersViewModel(this));
    public void NavigateToProfile() => NavigateTo(new ProfileViewModel(this));

    public async void AddToCart(Product product, int quantity = 1)
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
        await SaveCartToDatabaseAsync();
    }

    public async void RemoveFromCart(string cartItemId)
    {
        var item = CartItems.FirstOrDefault(c => c.Id == cartItemId);
        if (item != null)
        {
            CartItems.Remove(item);
            OnCartChanged();
            await SaveCartToDatabaseAsync();
        }
    }

    public async void UpdateCartItemQuantity(string cartItemId, int quantity)
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
            await SaveCartToDatabaseAsync();
        }
    }

    public async void ClearCart()
    {
        foreach (var item in CartItems)
        {
            item.PropertyChanged -= (s, e) => OnCartChanged();
        }
        CartItems.Clear();
        OnCartChanged();

        // Also clear from database
        if (CurrentUser != null)
        {
            try
            {
                using var scope = App.Services.CreateScope();
                var cartRepo = scope.ServiceProvider.GetRequiredService<ICartRepository>();
                await cartRepo.ClearAsync(CurrentUser.Id);
                System.Diagnostics.Debug.WriteLine($"[MainViewModel] Cleared cart from database for user {CurrentUser.Id}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[MainViewModel] Erro ao limpar carrinho do banco: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"[MainViewModel] StackTrace: {ex.StackTrace}");
            }
        }
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