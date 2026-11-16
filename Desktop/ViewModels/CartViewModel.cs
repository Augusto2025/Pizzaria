namespace PizzariaDesktop.ViewModels;

using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input;
using System.ComponentModel;
using System.Threading.Tasks;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data;
using PizzariaDesktop.Views.Cart;
using PizzariaDesktop.Data.Repositories;
using PizzariaDesktop.Services;

public class CartViewModel : BaseViewModel
{
    private readonly MainViewModel _mainViewModel;
    private Address? _selectedAddress;
    private string _paymentMethod = "PIX";
    private string _notes = string.Empty;
    private bool _isProcessing = false;
    private bool _justCheckedOut = false;
    private DateTime? _lastOrderDeliveryTime;
    private const double DeliveryFee = 5.00;
    private List<Address> _savedAddresses = new();

    public CartViewModel(MainViewModel mainViewModel)
    {
        _mainViewModel = mainViewModel;
        CartItems = _mainViewModel.CartItems;

        IncreaseQuantityCommand = new RelayCommand(item => IncreaseQuantity((CartItem)item!));
        DecreaseQuantityCommand = new RelayCommand(item => DecreaseQuantity((CartItem)item!));
        RemoveItemCommand = new RelayCommand(item => RemoveItem((CartItem)item!));
        GoToMenuCommand = new RelayCommand(_ => _mainViewModel.NavigateToMenu());
        GoToCheckoutCommand = new RelayCommand(async _ => await GoToCheckoutAsync(), _ => CanCheckout && !IsProcessing);
        GoToOrdersCommand = new RelayCommand(_ => _mainViewModel.NavigateToOrders());

        // Load addresses when viewmodel is created (user should be logged in by then)
        _ = LoadAddressesAsync();
    }

    public ObservableCollection<CartItem> CartItems { get; }

    public int ItemCount => CartItems.Sum(c => c.Quantity);
    public double Subtotal => CartItems.Sum(c => c.TotalPrice);
    public double Total => Subtotal + DeliveryFee;

    public string FormattedSubtotal => $"R$ {Subtotal:F2}";
    public string FormattedDeliveryFee => $"R$ {DeliveryFee:F2}";
    public string FormattedTotal => $"R$ {Total:F2}";

    public Address? SelectedAddress
    {
        get => _selectedAddress;
        set
        {
            if (SetProperty(ref _selectedAddress, value) && value != null)
            {
                // Update delivery address string for backward compatibility
                _deliveryAddress = value.FullAddress;
                OnPropertyChanged(nameof(DeliveryAddress));
            }
        }
    }

    // Backward compatibility property for order creation
    private string _deliveryAddress = "Rua das Flores, 123 - Jardim Primavera, São Paulo/SP";
    public string DeliveryAddress
    {
        get => _deliveryAddress;
        set => SetProperty(ref _deliveryAddress, value);
    }

    public string PaymentMethod
    {
        get => _paymentMethod;
        set => SetProperty(ref _paymentMethod, value);
    }

    public string Notes
    {
        get => _notes;
        set => SetProperty(ref _notes, value);
    }

    public bool IsProcessing
    {
        get => _isProcessing;
        set
        {
            if (SetProperty(ref _isProcessing, value))
            {
                OnPropertyChanged(nameof(CanCheckout));
                CommandManager.InvalidateRequerySuggested();
            }
        }
    }

    public List<string> PaymentMethods { get; } = new() { "PIX", "Cartão de Crédito", "Cartão de Débito", "Dinheiro", "Carteira Digital" };
    public List<Address> SavedAddresses => _savedAddresses;

    public ICommand IncreaseQuantityCommand { get; }
    public ICommand DecreaseQuantityCommand { get; }
    public ICommand RemoveItemCommand { get; }
    public ICommand GoToMenuCommand { get; }
    public ICommand GoToCheckoutCommand { get; }
    public ICommand GoToOrdersCommand { get; }

    public void IncreaseQuantity(CartItem item) => _mainViewModel.UpdateCartItemQuantity(item.Id, item.Quantity + 1);
    public void DecreaseQuantity(CartItem item) => _mainViewModel.UpdateCartItemQuantity(item.Id, item.Quantity - 1);
    public void RemoveItem(CartItem item) => _mainViewModel.RemoveFromCart(item.Id);

    public bool JustCheckedOut
    {
        get => _justCheckedOut;
        set => SetProperty(ref _justCheckedOut, value);
    }

    public string EstimatedDeliveryTimeDisplay
    {
        get
        {
            if (!CartItems.Any()) return "Entrega em ~35-45 min";
            var maxPrep = CartItems.Max(c => c.Product.PrepTimeMinutes);
            var deliveryTime = DateTime.Now.AddMinutes(maxPrep + 15);
            var windowStart = deliveryTime.AddMinutes(-10).ToString("HH:mm");
            var windowEnd = deliveryTime.AddMinutes(20).ToString("HH:mm");
            return $"Entrega prevista: {deliveryTime:HH:mm} ({windowStart} - {windowEnd})";
        }
    }

    public async Task GoToCheckoutAsync()
    {
        if (!CanCheckout || IsProcessing) return;

        IsProcessing = true;

        try
        {
            // Simulate payment processing with a small delay for UX
            await Task.Delay(800);

            // Create the order from cart items
            var order = await CreateOrderFromCartAsync();

            // Store delivery time for success display
            _lastOrderDeliveryTime = order.EstimatedDeliveryTime;

            // Save order to database
            try
            {
                var orderRepo = ServiceLocator.GetService<IOrderRepository>();
                if (orderRepo != null)
                {
                    await orderRepo.CreateAsync(order);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Erro ao salvar pedido no banco: {ex.Message}");
            }

            // Add to orders list (in-memory for immediate UI update)
            _mainViewModel.AddOrderToHistory(order);

            // Clear the cart
            _mainViewModel.ClearCart();

            // Show success state in cart view
            JustCheckedOut = true;

            // Hide loading overlay BEFORE showing dialog
            IsProcessing = false;

            // Show confirmation dialog
            var dialog = new OrderConfirmationDialog(order, _mainViewModel);
            dialog.ShowDialog();

            // Reset success state after dialog closes
            JustCheckedOut = false;

            // Navigate to orders after dialog closes
            _mainViewModel.NavigateToOrders();
        }
        catch (Exception ex)
        {
            IsProcessing = false;
            MessageBox.Show($"Erro ao finalizar pedido: {ex.Message}", "Erro",
                MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }

    private async Task<Order> CreateOrderFromCartAsync()
    {
        var now = DateTime.Now;
        // Calculate estimated delivery based on items (more items = longer prep)
        var maxPrepTime = CartItems.Any() ? CartItems.Max(c => c.Product.PrepTimeMinutes) : 25;
        var estimatedDelivery = now.AddMinutes(maxPrepTime + 15); // prep + delivery

        // Use selected address from ComboBox, fallback to first saved address, or parse from string
        Address deliveryAddress;
        if (SelectedAddress != null)
        {
            deliveryAddress = SelectedAddress;
        }
        else if (SavedAddresses.Any())
        {
            deliveryAddress = SavedAddresses.First();
        }
        else
        {
            // Parse the address string to create a new Address object
            deliveryAddress = Address.FromFullAddress(DeliveryAddress);
        }

        // Ensure address is saved to database (if new)
        deliveryAddress = await EnsureAddressSavedAsync(deliveryAddress);

        var order = new Order
        {
            Id = $"ord-{now:yyyyMMddHHmmss}-{Guid.NewGuid().ToString()[..4]}",
            UserId = _mainViewModel.CurrentUser?.Id ?? "user-001",
            DeliveryAddress = deliveryAddress,
            PaymentMethod = ParsePaymentMethod(_paymentMethod),
            Status = OrderStatus.Confirmed,
            Subtotal = Subtotal,
            DeliveryFee = DeliveryFee,
            Notes = Notes,
            CreatedAt = now,
            EstimatedDeliveryTime = estimatedDelivery
        };

        // Add items to order
        foreach (var cartItem in CartItems)
        {
            var orderItem = new OrderItem
            {
                Id = Guid.NewGuid().ToString(),
                Product = cartItem.Product,
                Quantity = cartItem.Quantity,
                UnitPrice = cartItem.Product.Price,
                Customizations = cartItem.SelectedCustomizations,
                Notes = cartItem.Notes
            };
            order.Items.Add(orderItem);
        }

        // Add timeline
        order.Timeline.Add(new StatusTimeline
        {
            Status = OrderStatus.Pending,
            Timestamp = now,
            Note = "Pedido recebido"
        });
        order.Timeline.Add(new StatusTimeline
        {
            Status = OrderStatus.Confirmed,
            Timestamp = now.AddMinutes(1),
            Note = "Pagamento aprovado ✅"
        });
        order.Timeline.Add(new StatusTimeline
        {
            Status = OrderStatus.Preparing,
            Timestamp = now.AddMinutes(3),
            Note = "Iniciando preparação"
        });

        return order;
    }

    private Models.PaymentMethod ParsePaymentMethod(string method)
    {
        return method switch
        {
            "PIX" => Models.PaymentMethod.Pix,
            "Cartão de Crédito" => Models.PaymentMethod.Card,
            "Cartão de Débito" => Models.PaymentMethod.Card,
            "Dinheiro" => Models.PaymentMethod.Cash,
            "Carteira Digital" => Models.PaymentMethod.Wallet,
            _ => Models.PaymentMethod.Pix
        };
    }

    public bool CanCheckout => CartItems.Count > 0 && !IsProcessing;

    // Delivery time estimate for display in sidebar
    public string EstimatedDeliveryRange
    {
        get
        {
            if (!CartItems.Any()) return "35 - 45 min";
            var maxPrepTime = CartItems.Max(c => c.Product.PrepTimeMinutes);
            var minDelivery = maxPrepTime + 10;
            var maxDelivery = maxPrepTime + 20;
            return $"{minDelivery} - {maxDelivery} min";
        }
    }

    // Load addresses from database
    public async Task LoadAddressesAsync()
    {
        if (_mainViewModel.CurrentUser == null) return;

        try
        {
            var addressRepo = ServiceLocator.GetServiceOrDefault<IAddressRepository>();
            if (addressRepo != null)
            {
                var addresses = await addressRepo.GetByUserIdAsync(_mainViewModel.CurrentUser.Id);
                _savedAddresses.Clear();
                _savedAddresses.AddRange(addresses);
                OnPropertyChanged(nameof(SavedAddresses));

                // Select default address or first address
                if (_savedAddresses.Any())
                {
                    var defaultAddress = _savedAddresses.FirstOrDefault(a => a.IsDefault) ?? _savedAddresses.First();
                    SelectedAddress = defaultAddress;
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Erro ao carregar endereços: {ex.Message}");
        }
    }

    // Save new address to database if needed
    private async Task<Address> EnsureAddressSavedAsync(Address address)
    {
        if (_mainViewModel.CurrentUser == null) return address;

        // Check if address already exists in saved addresses (by ID or by FullAddress)
        var existing = _savedAddresses.FirstOrDefault(a => a.Id == address.Id || a.FullAddress == address.FullAddress);
        if (existing != null)
        {
            return existing;
        }

        // Save new address to database
        try
        {
            var addressRepo = ServiceLocator.GetServiceOrDefault<IAddressRepository>();
            if (addressRepo != null)
            {
                var savedAddress = await addressRepo.CreateAsync(address, _mainViewModel.CurrentUser.Id);
                _savedAddresses.Add(savedAddress);
                OnPropertyChanged(nameof(SavedAddresses));
                return savedAddress;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Erro ao salvar endereço: {ex.Message}");
        }

        return address;
    }
}