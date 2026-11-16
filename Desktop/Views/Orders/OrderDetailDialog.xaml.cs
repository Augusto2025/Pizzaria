namespace PizzariaDesktop.Views.Orders;

using System.Windows;
using System.Windows.Media;
using PizzariaDesktop.Models;

public partial class OrderDetailDialog : Window
{
    private readonly Order _order;

    public OrderDetailDialog(Order order)
    {
        InitializeComponent();
        _order = order;
        LoadOrderDetails();
    }

    private void LoadOrderDetails()
    {
        // Order ID and Date
        OrderIdText.Text = $"Pedido #{_order.ShortId}";
        OrderIdDetailText.Text = $"Pedido #{_order.ShortId}";
        OrderDateText.Text = _order.FormattedCreatedAt;

        // Status Badge
        StatusText.Text = _order.StatusDisplayName;
        StatusBadge.Background = GetStatusColor(_order.Status);

        // Paid Badge
        if (_order.Status == OrderStatus.Confirmed || _order.Status == OrderStatus.Preparing ||
            _order.Status == OrderStatus.Baking || _order.Status == OrderStatus.Ready ||
            _order.Status == OrderStatus.OutForDelivery || _order.Status == OrderStatus.Delivered)
        {
            PaidBadge.Visibility = Visibility.Visible;
        }

        // Payment Method
        PaymentMethodText.Text = _order.PaymentMethod.ToString();

        // Delivery Address
        DeliveryAddressText.Text = _order.DeliveryAddress.FullAddress;

        // Delivery Time
        if (_order.EstimatedDeliveryTime.HasValue)
        {
            DeliveryTimeCard.Visibility = Visibility.Visible;
            DeliveryTimeText.Text = _order.EstimatedDeliveryTime.Value.ToString("HH:mm");
            var start = _order.EstimatedDeliveryTime.Value.AddMinutes(-10).ToString("HH:mm");
            var end = _order.EstimatedDeliveryTime.Value.AddMinutes(20).ToString("HH:mm");
            DeliveryWindowText.Text = $"entre {start} - {end}";
        }

        // Timeline
        TimelineControl.ItemsSource = _order.Timeline;

        // Items
        ItemsControl.ItemsSource = _order.Items;

        // Notes
        if (!string.IsNullOrWhiteSpace(_order.Notes))
        {
            NotesCard.Visibility = Visibility.Visible;
            NotesText.Text = _order.Notes;
        }

        // Totals
        SubtotalText.Text = _order.FormattedSubtotal;
        DeliveryFeeText.Text = _order.FormattedDeliveryFee;
        TotalText.Text = _order.FormattedTotal;
    }

    private SolidColorBrush GetStatusColor(OrderStatus status)
    {
        return status switch
        {
            OrderStatus.Pending => new SolidColorBrush(Color.FromRgb(0xFF, 0xC1, 0x07)),      // Warning - Yellow
            OrderStatus.Confirmed => new SolidColorBrush(Color.FromRgb(0x28, 0xA7, 0x45)),    // Success - Green
            OrderStatus.Preparing => new SolidColorBrush(Color.FromRgb(0x17, 0xA2, 0xB8)),    // Info - Blue
            OrderStatus.Baking => new SolidColorBrush(Color.FromRgb(0xFD, 0x7E, 0x14)),       // Orange
            OrderStatus.Ready => new SolidColorBrush(Color.FromRgb(0x20, 0xC9, 0x97)),        // Teal
            OrderStatus.OutForDelivery => new SolidColorBrush(Color.FromRgb(0x6F, 0x42, 0xC1)), // Purple
            OrderStatus.Delivered => new SolidColorBrush(Color.FromRgb(0x28, 0xA7, 0x45)),    // Success - Green
            OrderStatus.Cancelled => new SolidColorBrush(Color.FromRgb(0xDC, 0x35, 0x45)),    // Danger - Red
            _ => new SolidColorBrush(Color.FromRgb(0x6C, 0x75, 0x7D))                        // Secondary - Gray
        };
    }

    private void CloseButton_Click(object sender, RoutedEventArgs e)
    {
        DialogResult = true;
        Close();
    }

    private void ReorderButton_Click(object sender, RoutedEventArgs e)
    {
        // Signal to reorder
        Tag = "Reorder";
        DialogResult = true;
        Close();
    }
}