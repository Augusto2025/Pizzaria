namespace PizzariaDesktop.ViewModels;

using System.Collections.ObjectModel;
using System.Windows.Input;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data;

public class CartViewModel : BaseViewModel
{
    private readonly MainViewModel _mainViewModel;
    private string _deliveryAddress = "Rua das Flores, 123 - Jardim Primavera, São Paulo/SP";
    private string _paymentMethod = "PIX";
    private string _notes = string.Empty;
    private const double DeliveryFee = 5.00;

    public CartViewModel(MainViewModel mainViewModel)
    {
        _mainViewModel = mainViewModel;
        CartItems = _mainViewModel.CartItems;

        IncreaseQuantityCommand = new RelayCommand(item => IncreaseQuantity((CartItem)item!));
        DecreaseQuantityCommand = new RelayCommand(item => DecreaseQuantity((CartItem)item!));
        RemoveItemCommand = new RelayCommand(item => RemoveItem((CartItem)item!));
        GoToMenuCommand = new RelayCommand(_ => _mainViewModel.NavigateToMenu());
        GoToCheckoutCommand = new RelayCommand(_ => GoToCheckout());
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

    public List<string> PaymentMethods { get; } = new() { "PIX", "Cartão de Crédito", "Cartão de Débito", "Dinheiro", "Carteira Digital" };
    public List<Address> SavedAddresses { get; } = MockData.Addresses;

    public ICommand IncreaseQuantityCommand { get; }
    public ICommand DecreaseQuantityCommand { get; }
    public ICommand RemoveItemCommand { get; }
    public ICommand GoToMenuCommand { get; }
    public ICommand GoToCheckoutCommand { get; }

    public void IncreaseQuantity(CartItem item) => _mainViewModel.UpdateCartItemQuantity(item.Id, item.Quantity + 1);
    public void DecreaseQuantity(CartItem item) => _mainViewModel.UpdateCartItemQuantity(item.Id, item.Quantity - 1);
    public void RemoveItem(CartItem item) => _mainViewModel.RemoveFromCart(item.Id);

    public void GoToCheckout()
    {
        // In a real app, this would navigate to checkout
        // For demo, just show a message
    }

    public bool CanCheckout => CartItems.Count > 0;
}