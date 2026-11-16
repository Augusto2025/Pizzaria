using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using PizzariaDesktop.Models;
using PizzariaDesktop.ViewModels;

namespace PizzariaDesktop.Views.Orders
{
    public partial class OrdersView : UserControl
    {
        public OrdersView()
        {
            InitializeComponent();
        }

        private void OrderItem_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            if (sender is Border border && border.DataContext is Order order)
            {
                var viewModel = DataContext as OrdersViewModel;
                if (viewModel != null)
                {
                    ShowOrderDetailDialog(order, viewModel);
                }
            }
        }

        private void ShowOrderDetailDialog(Order order, OrdersViewModel viewModel)
        {
            var dialog = new OrderDetailDialog(order);
            var result = dialog.ShowDialog();

            // Check if user clicked "Pedir Novamente"
            if (result == true && dialog.Tag?.ToString() == "Reorder")
            {
                viewModel.Reorder(order);
            }
        }
    }
}