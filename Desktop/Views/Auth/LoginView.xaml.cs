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

        private void ExitSystemButton_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void PasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            if (sender is PasswordBox pb && DataContext is LoginViewModel vm)
            {
                // Directly update ViewModel (trimmed), then sync to TextBox if visible
                vm.Password = pb.Password.Trim();
                if (_isPasswordVisible)
                {
                    PasswordTextBox.Text = pb.Password;
                }
            }
        }

        private void PasswordTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            // Only sync back to PasswordBox when TextBox is visible (show password mode)
            if (sender is TextBox tb && DataContext is LoginViewModel vm && _isPasswordVisible)
            {
                vm.Password = tb.Text.Trim();
                PasswordBox.Password = tb.Text;
            }
        }

        private void TogglePasswordButton_Click(object sender, RoutedEventArgs e)
        {
            _isPasswordVisible = !_isPasswordVisible;

            if (_isPasswordVisible)
            {
                // Show password: copy to TextBox, show it, hide PasswordBox
                PasswordTextBox.Text = PasswordBox.Password.Trim();
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
                PasswordBox.Password = PasswordTextBox.Text.Trim();
                PasswordBox.Visibility = Visibility.Visible;
                PasswordTextBox.Visibility = Visibility.Collapsed;
                EyeIcon.Text = "👁"; // Open eye
                ToolTipService.SetToolTip(TogglePasswordButton, "Mostrar senha");
                PasswordBox.Focus();
            }
        }
    }
}