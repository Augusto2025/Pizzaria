using System.Windows;
using PizzariaDesktop.Models;
using PizzariaDesktop.ViewModels;

namespace PizzariaDesktop.Views.Cart
{
    public partial class OrderConfirmationDialog : Window
    {
        public OrderConfirmationDialog(Order order, MainViewModel mainViewModel)
        {
            InitializeComponent();
            Owner = Application.Current.MainWindow;
            DataContext = new OrderConfirmationViewModel(order, mainViewModel, this);
        }

        private void TrackOrderButton_Click(object sender, RoutedEventArgs e)
        {
            if (DataContext is OrderConfirmationViewModel vm)
            {
                vm.TrackOrder();
            }
            Close();
        }

        private void NewOrderButton_Click(object sender, RoutedEventArgs e)
        {
            if (DataContext is OrderConfirmationViewModel vm)
            {
                vm.StartNewOrder();
            }
            Close();
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            if (DataContext is OrderConfirmationViewModel vm)
            {
                vm.GoHome();
            }
            Close();
        }

        public class OrderConfirmationViewModel
        {
            private readonly Order _order;
            private readonly MainViewModel _mainViewModel;
            private readonly Window _dialog;

            public OrderConfirmationViewModel(Order order, MainViewModel mainViewModel, Window dialog)
            {
                _order = order;
                _mainViewModel = mainViewModel;
                _dialog = dialog;

                OrderIdText = $"#{_order.ShortId}";
                OrderTimeText = _order.FormattedCreatedAt;

                // Format delivery time prominently
                if (_order.EstimatedDeliveryTime.HasValue)
                {
                    var deliveryTime = _order.EstimatedDeliveryTime.Value;
                    DeliveryTimeText = deliveryTime.ToString("HH:mm");

                    // Calculate window: -10 to +20 minutes
                    var windowStart = deliveryTime.AddMinutes(-10).ToString("HH:mm");
                    var windowEnd = deliveryTime.AddMinutes(20).ToString("HH:mm");
                    DeliveryWindowText = $"entre {windowStart} - {windowEnd}";
                }
                else
                {
                    DeliveryTimeText = "--:--";
                    DeliveryWindowText = "a confirmar";
                }

                DeliveryAddressText = _order.DeliveryAddress?.FullAddress ?? "";
                PaymentMethodText = GetPaymentMethodDisplayName(_order.PaymentMethod);
                SubtotalText = _order.FormattedSubtotal;
                DeliveryFeeText = _order.FormattedDeliveryFee;
                TotalText = _order.FormattedTotal;
                ItemCountText = $"{_order.Items.Count} item{(_order.Items.Count != 1 ? "s" : "")}";

                // Header subtitle with delivery time
                if (_order.EstimatedDeliveryTime.HasValue)
                {
                    var dt = _order.EstimatedDeliveryTime.Value;
                    HeaderSubtitleText = $"Seu pedido será entregue até {dt:HH:mm} — pagamento aprovado ✅";
                }
                else
                {
                    HeaderSubtitleText = "Seu pagamento foi aprovado e o pedido está a caminho";
                }

                LoadOrderItems();
            }

            public string OrderIdText { get; }
            public string OrderTimeText { get; }
            public string DeliveryTimeText { get; }
            public string DeliveryWindowText { get; }
            public string DeliveryAddressText { get; }
            public string PaymentMethodText { get; }
            public string SubtotalText { get; }
            public string DeliveryFeeText { get; }
            public string TotalText { get; }
            public string ItemCountText { get; }
            public string HeaderSubtitleText { get; }

            public System.Collections.ObjectModel.ObservableCollection<OrderItemViewModel> OrderItems { get; } = new();

            private void LoadOrderItems()
            {
                foreach (var item in _order.Items)
                {
                    var icon = item.Product.Category switch
                    {
                        Category.Pizza => "🍕",
                        Category.Drink => "🥤",
                        Category.Dessert => "🍰",
                        Category.Side => "🍟",
                        _ => "🍽️"
                    };

                    var customizations = new List<string>();
                    if (item.Customizations != null)
                    {
                        foreach (var kvp in item.Customizations)
                        {
                            customizations.Add(kvp.Value);
                        }
                    }

                    var details = $"Qtd: {item.Quantity}";
                    if (customizations.Count > 0)
                    {
                        details += $" • {string.Join(", ", customizations)}";
                    }

                    OrderItems.Add(new OrderItemViewModel
                    {
                        Icon = icon,
                        Name = item.Product.Name,
                        Details = details,
                        Price = $"R$ {item.TotalPrice:F2}"
                    });
                }
            }

            private string GetPaymentMethodDisplayName(PaymentMethod method)
            {
                return method switch
                {
                    PaymentMethod.Pix => "PIX",
                    PaymentMethod.Card => "Cartão de Crédito/Débito",
                    PaymentMethod.Cash => "Dinheiro",
                    PaymentMethod.Wallet => "Carteira Digital",
                    _ => method.ToString()
                };
            }

            public void TrackOrder()
            {
                _mainViewModel.NavigateToOrders();
            }

            public void StartNewOrder()
            {
                _mainViewModel.NavigateToMenu();
            }

            public void GoHome()
            {
                _mainViewModel.NavigateToHome();
            }
        }

        public class OrderItemViewModel
        {
            public string Icon { get; set; } = "";
            public string Name { get; set; } = "";
            public string Details { get; set; } = "";
            public string Price { get; set; } = "";
        }
    }
}