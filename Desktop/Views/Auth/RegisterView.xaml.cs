using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using PizzariaDesktop.ViewModels;

namespace PizzariaDesktop.Views.Auth
{
    public partial class RegisterView : UserControl
    {
        public RegisterView()
        {
            InitializeComponent();
        }

        private void PasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            if (sender is PasswordBox pb && DataContext is RegisterViewModel vm)
            {
                // Directly update ViewModel (trimmed), then sync to TextBox if visible
                vm.Password = pb.Password.Trim();
                if (PasswordBox.Visibility == Visibility.Visible)
                {
                    PasswordTextBox.Text = pb.Password;
                }
            }
        }

        private void PasswordTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            // Only sync back to PasswordBox when TextBox is visible (show password mode)
            if (sender is TextBox tb && DataContext is RegisterViewModel vm && PasswordBox.Visibility == Visibility.Collapsed)
            {
                vm.Password = tb.Text.Trim();
                PasswordBox.Password = tb.Text;
            }
        }

        private void TogglePasswordButton_Click(object sender, RoutedEventArgs e)
        {
            if (PasswordBox.Visibility == Visibility.Visible)
            {
                PasswordBox.Visibility = Visibility.Collapsed;
                PasswordTextBox.Visibility = Visibility.Visible;
                PasswordTextBox.Text = PasswordBox.Password.Trim();
                EyeIcon.Text = "🙈";
            }
            else
            {
                PasswordBox.Visibility = Visibility.Visible;
                PasswordTextBox.Visibility = Visibility.Collapsed;
                PasswordBox.Password = PasswordTextBox.Text.Trim();
                EyeIcon.Text = "👁";
            }
        }

        private void ConfirmPasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            if (sender is PasswordBox pb && DataContext is RegisterViewModel vm)
            {
                // Directly update ViewModel (trimmed), then sync to TextBox if visible
                vm.ConfirmPassword = pb.Password.Trim();
                if (ConfirmPasswordBox.Visibility == Visibility.Visible)
                {
                    ConfirmPasswordTextBox.Text = pb.Password;
                }
            }
        }

        private void ConfirmPasswordTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            // Only sync back to PasswordBox when TextBox is visible (show password mode)
            if (sender is TextBox tb && DataContext is RegisterViewModel vm && ConfirmPasswordBox.Visibility == Visibility.Collapsed)
            {
                vm.ConfirmPassword = tb.Text.Trim();
                ConfirmPasswordBox.Password = tb.Text;
            }
        }

        private void ToggleConfirmPasswordButton_Click(object sender, RoutedEventArgs e)
        {
            if (ConfirmPasswordBox.Visibility == Visibility.Visible)
            {
                ConfirmPasswordBox.Visibility = Visibility.Collapsed;
                ConfirmPasswordTextBox.Visibility = Visibility.Visible;
                ConfirmPasswordTextBox.Text = ConfirmPasswordBox.Password.Trim();
                ConfirmEyeIcon.Text = "🙈";
            }
            else
            {
                ConfirmPasswordBox.Visibility = Visibility.Visible;
                ConfirmPasswordTextBox.Visibility = Visibility.Collapsed;
                ConfirmPasswordBox.Password = ConfirmPasswordTextBox.Text.Trim();
                ConfirmEyeIcon.Text = "👁";
            }
        }

        // Phone formatting for Brazilian format: (11) 99999-9999
        private void PhoneTextBox_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            // Only allow digits
            var regex = new Regex("[^0-9]+");
            e.Handled = regex.IsMatch(e.Text);
        }

        private void PhoneTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            var textBox = sender as TextBox;
            if (textBox == null) return;

            // Save cursor position
            var caretIndex = textBox.CaretIndex;
            var oldText = textBox.Text;

            // Remove all non-digits
            var digitsOnly = Regex.Replace(textBox.Text, @"\D", "");

            // Limit to 11 digits (DDD + 9 digits)
            if (digitsOnly.Length > 11)
            {
                digitsOnly = digitsOnly.Substring(0, 11);
            }

            // Format as (11) 99999-9999
            var formatted = FormatPhoneNumber(digitsOnly);

            // Only update if changed to avoid infinite loop
            if (formatted != oldText)
            {
                textBox.Text = formatted;

                // Restore cursor position (approximately)
                var newCaretIndex = caretIndex;
                // Adjust for added formatting characters
                if (caretIndex > 0 && caretIndex <= 3) newCaretIndex = caretIndex + 1; // After "("
                else if (caretIndex > 3 && caretIndex <= 6) newCaretIndex = caretIndex + 2; // After ") "
                else if (caretIndex > 6 && caretIndex <= 11) newCaretIndex = caretIndex + 3; // After "-"

                textBox.CaretIndex = Math.Min(newCaretIndex, formatted.Length);
            }
        }

        private string FormatPhoneNumber(string digits)
        {
            if (string.IsNullOrEmpty(digits))
                return string.Empty;

            // Format: (11) 99999-9999
            if (digits.Length <= 2)
            {
                return $"({digits}";
            }
            else if (digits.Length <= 7)
            {
                return $"({digits.Substring(0, 2)}) {digits.Substring(2)}";
            }
            else
            {
                return $"({digits.Substring(0, 2)}) {digits.Substring(2, 5)}-{digits.Substring(7)}";
            }
        }
    }
}