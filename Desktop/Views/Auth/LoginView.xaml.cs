using System.Windows;
using System.Windows.Controls;
using PizzariaDesktop.ViewModels;

namespace PizzariaDesktop.Views.Auth
{
    public partial class LoginView : UserControl
    {
        private bool _isPasswordVisible = false;

        public LoginView()
        {
            InitializeComponent();
        }

        private void PasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            if (DataContext is LoginViewModel vm && sender is PasswordBox pb)
            {
                vm.Password = pb.Password;
                // Sync to TextBox if visible
                if (_isPasswordVisible)
                {
                    PasswordTextBox.Text = pb.Password;
                }
            }
        }

        private void PasswordTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (DataContext is LoginViewModel vm && sender is TextBox tb)
            {
                vm.Password = tb.Text;
                // Sync to PasswordBox if not visible
                if (!_isPasswordVisible)
                {
                    PasswordBox.Password = tb.Text;
                }
            }
        }

        private void TogglePasswordButton_Click(object sender, RoutedEventArgs e)
        {
            _isPasswordVisible = !_isPasswordVisible;

            if (_isPasswordVisible)
            {
                // Show password: copy to TextBox, show it, hide PasswordBox
                PasswordTextBox.Text = PasswordBox.Password;
                PasswordTextBox.Visibility = Visibility.Visible;
                PasswordBox.Visibility = Visibility.Collapsed;
                EyeIcon.Text = "🙈"; // Eye with slash
                ToolTipService.SetToolTip(TogglePasswordButton, "Ocultar senha");
                PasswordTextBox.Focus();
                PasswordTextBox.CaretIndex = PasswordTextBox.Text.Length;
            }
            else
            {
                // Hide password: copy to PasswordBox, show it, hide TextBox
                PasswordBox.Password = PasswordTextBox.Text;
                PasswordBox.Visibility = Visibility.Visible;
                PasswordTextBox.Visibility = Visibility.Collapsed;
                EyeIcon.Text = "👁"; // Open eye
                ToolTipService.SetToolTip(TogglePasswordButton, "Mostrar senha");
                PasswordBox.Focus();
            }
        }
    }
}