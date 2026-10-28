namespace PizzariaDesktop.ViewModels;

using System.Collections.ObjectModel;
using System.Windows.Input;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data;

public class OrdersViewModel : BaseViewModel
{
    private readonly MainViewModel _mainViewModel;
    private Order? _selectedOrder;

    public OrdersViewModel(MainViewModel mainViewModel)
    {
        _mainViewModel = mainViewModel;
        Orders = new ObservableCollection<Order>(MockData.Orders.OrderByDescending(o => o.CreatedAt));

        SelectOrderCommand = new RelayCommand(o => SelectOrder((Order)o!));
        ClearSelectionCommand = new RelayCommand(_ => ClearSelection());
        GoToHomeCommand = new RelayCommand(_ => _mainViewModel.NavigateToHome());
        GoToMenuCommand = new RelayCommand(_ => _mainViewModel.NavigateToMenu());
        ReorderCommand = new RelayCommand(o => Reorder((Order)o!));
    }

    public ObservableCollection<Order> Orders { get; }

    public Order? SelectedOrder
    {
        get => _selectedOrder;
        set
        {
            if (SetProperty(ref _selectedOrder, value))
            {
                OnPropertyChanged(nameof(HasSelectedOrder));
            }
        }
    }

    public bool HasSelectedOrder => SelectedOrder != null;

    public ICommand SelectOrderCommand { get; }
    public ICommand ClearSelectionCommand { get; }
    public ICommand GoToHomeCommand { get; }
    public ICommand GoToMenuCommand { get; }
    public ICommand ReorderCommand { get; }

    public void SelectOrder(Order order) => SelectedOrder = order;
    public void ClearSelection() => SelectedOrder = null;

    public void Reorder(Order order)
    {
        foreach (var item in order.Items)
        {
            _mainViewModel.AddToCart(item.Product, item.Quantity);
        }
        _mainViewModel.NavigateToCart();
    }
}

public class OrderDetailViewModel : BaseViewModel
{
    private readonly MainViewModel _mainViewModel;
    private readonly Order _order;

    public OrderDetailViewModel(MainViewModel mainViewModel, Order order)
    {
        _mainViewModel = mainViewModel;
        _order = order;

        GoBackCommand = new RelayCommand(_ => _mainViewModel.NavigateToOrders());
        ReorderCommand = new RelayCommand(_ => Reorder());
    }

    public Order Order => _order;
    public string FormattedId => $"#{_order.ShortId}";
    public string FormattedDate => _order.FormattedCreatedAt;
    public string FormattedStatus => _order.StatusDisplayName;
    public string FormattedSubtotal => _order.FormattedSubtotal;
    public string FormattedDeliveryFee => _order.FormattedDeliveryFee;
    public string FormattedTotal => _order.FormattedTotal;
    public string FormattedPaymentMethod => _order.PaymentMethod.ToString();
    public string FormattedAddress => _order.DeliveryAddress.FullAddress;
    public string FormattedEstimatedDelivery => _order.FormattedEstimatedDelivery;
    public string Notes => _order.Notes;

    public List<StatusTimeline> Timeline => _order.Timeline;

    public ICommand GoBackCommand { get; }
    public ICommand ReorderCommand { get; }

    public void Reorder()
    {
        foreach (var item in _order.Items)
        {
            _mainViewModel.AddToCart(item.Product, item.Quantity);
        }
        _mainViewModel.NavigateToCart();
    }
}