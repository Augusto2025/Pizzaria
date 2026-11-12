namespace PizzariaDesktop.ViewModels;

using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input;
using System.ComponentModel;
using System.Threading.Tasks;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data;
using PizzariaDesktop.Views.Cart;

public class CartViewModel : BaseViewModel
{
    private readonly MainViewModel _mainViewModel;
    private string _deliveryAddress = "Rua das Flores, 123 - Jardim Primavera, São Paulo/SP";
    private string _paymentMethod = "PIX";
    private string _notes = string.Empty;
    private bool _isProcessing = false;
    private bool _justCheckedOut = false;
    private DateTime? _lastOrderDeliveryTime;
    private const double DeliveryFee = 5.00;

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
    }

    public ObservableCollection<CartItem> CartItems { get; }

    public int ItemCount => CartItems.Sum(c => c.Quantity);
    public double Subtotal => CartItems.Sum(c => c.TotalPrice);
    public double Total => Subtotal + DeliveryFee;

    public string FormattedSubtotal => $"R$ {Subtotal:F2}";
    public string FormattedDeliveryFee => $"R$ {DeliveryFee:F2}";
    public string FormattedTotal => $"R$ {Total:F2}";

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
    public List<Address> SavedAddresses { get; } = MockData.Addresses;

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
            var order = CreateOrderFromCart();

            // Store delivery time for success display
            _lastOrderDeliveryTime = order.EstimatedDeliveryTime;

            // Add to orders list
            _mainViewModel.AddOrderToHistory(order);

            // Clear the cart
            _mainViewModel.ClearCart();

            // Show success state in cart view
            JustCheckedOut = true;

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
            MessageBox.Show($"Erro ao finalizar pedido: {ex.Message}", "Erro",
                MessageBoxButton.OK, MessageBoxImage.Error);
        }
        finally
        {
            IsProcessing = false;
        }
    }

    private Order CreateOrderFromCart()
    {
        var now = DateTime.Now;
        // Calculate estimated delivery based on items (more items = longer prep)
        var maxPrepTime = CartItems.Any() ? CartItems.Max(c => c.Product.PrepTimeMinutes) : 25;
        var estimatedDelivery = now.AddMinutes(maxPrepTime + 15); // prep + delivery

        // Find matching saved address or create new one
        Address deliveryAddress;
        var savedAddr = SavedAddresses.FirstOrDefault(a => a.FullAddress == DeliveryAddress);
        if (savedAddr != null)
        {
            deliveryAddress = savedAddr;
        }
        else
        {
            // Parse the address string to create a new Address object
            deliveryAddress = Address.FromFullAddress(DeliveryAddress);
        }

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
}