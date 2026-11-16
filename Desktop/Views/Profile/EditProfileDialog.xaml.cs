namespace PizzariaDesktop.Views.Profile;

using System;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data.Repositories;
using PizzariaDesktop.Services;
using BCrypt.Net;

public partial class EditProfileDialog : Window
{
    private readonly User _currentUser;
    private readonly IUserRepository? _userRepository;
    private bool _isSaving = false;

    public EditProfileDialog(User currentUser)
    {
        InitializeComponent();
        _currentUser = currentUser;

        // Use GetServiceOrDefault to avoid crash if ServiceLocator not initialized
        try
        {
            _userRepository = ServiceLocator.GetServiceOrDefault<IUserRepository>();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Erro ao obter IUserRepository: {ex.Message}");
            _userRepository = null;
        }

        LoadUserData();
    }

    private void LoadUserData()
    {
        NameTextBox.Text = _currentUser.Name;
        EmailTextBox.Text = _currentUser.Email;
        PhoneTextBox.Text = _currentUser.Phone ?? "";
    }

    private async void SaveButton_Click(object sender, RoutedEventArgs e)
    {
        if (_isSaving) return;

        var name = NameTextBox.Text?.Trim() ?? "";
        var phone = PhoneTextBox.Text?.Trim() ?? "";
        var currentPassword = CurrentPasswordBox.Password ?? "";
        var newPassword = NewPasswordBox.Password ?? "";
        var confirmPassword = ConfirmPasswordBox.Password ?? "";

        // Validate name
        if (string.IsNullOrWhiteSpace(name))
        {
            ShowMessage("Nome é obrigatório", isError: true);
            return;
        }

        if (name.Length < 3)
        {
            ShowMessage("Nome deve ter pelo menos 3 caracteres", isError: true);
            return;
        }

        // Validate phone
        if (string.IsNullOrWhiteSpace(phone))
        {
            ShowMessage("Telefone é obrigatório", isError: true);
            return;
        }

        // Validate password change if provided
        if (!string.IsNullOrWhiteSpace(currentPassword) || !string.IsNullOrWhiteSpace(newPassword) || !string.IsNullOrWhiteSpace(confirmPassword))
        {
            if (string.IsNullOrWhiteSpace(currentPassword))
            {
                ShowMessage("Digite a senha atual para alterar a senha", isError: true);
                return;
            }

            if (string.IsNullOrWhiteSpace(newPassword))
            {
                ShowMessage("Digite a nova senha", isError: true);
                return;
            }

            if (newPassword.Length < 6)
            {
                ShowMessage("A nova senha deve ter pelo menos 6 caracteres", isError: true);
                return;
            }

            if (newPassword != confirmPassword)
            {
                ShowMessage("As senhas não coincidem", isError: true);
                return;
            }

            // Verify current password
            if (_userRepository != null)
            {
                var isValid = await _userRepository.VerifyPasswordAsync(_currentUser.Email, currentPassword);
                if (!isValid)
                {
                    ShowMessage("Senha atual incorreta", isError: true);
                    return;
                }
            }
        }

        _isSaving = true;
        SaveButton.IsEnabled = false;
        UpdateSaveButtonContent();

        try
        {
            bool hasChanges = false;

            // Update name
            if (name != _currentUser.Name)
            {
                _currentUser.Name = name;
                hasChanges = true;
            }

            // Update phone
            if (phone != _currentUser.Phone)
            {
                _currentUser.Phone = phone;
                hasChanges = true;
            }

            // Update password if provided (handled separately in repository if needed)
            if (!string.IsNullOrWhiteSpace(newPassword))
            {
                hasChanges = true;
            }

            if (hasChanges && _userRepository != null)
            {
                // Update user in database (name, phone)
                var success = await _userRepository.UpdateAsync(_currentUser);

                // If password changed, update it separately
                if (success && !string.IsNullOrWhiteSpace(newPassword))
                {
                    var passwordHash = BCrypt.HashPassword(newPassword);
                    success = await _userRepository.UpdatePasswordAsync(_currentUser.Id, passwordHash);
                }

                if (success)
                {
                    ShowMessage("Perfil atualizado com sucesso!", isError: false);

                    // Wait a bit then close
                    await Task.Delay(1000);
                    DialogResult = true;
                    Close();
                    return;
                }
                else
                {
                    ShowMessage("Erro ao salvar alterações", isError: true);
                }
            }
            else if (!hasChanges)
            {
                ShowMessage("Nenhuma alteração detectada", isError: true);
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Erro ao salvar perfil: {ex.Message}");
            ShowMessage($"Erro ao salvar: {ex.Message}", isError: true);
        }
        finally
        {
            _isSaving = false;
            SaveButton.IsEnabled = true;
            UpdateSaveButtonContent();
        }
    }

    private void UpdateSaveButtonContent()
    {
        if (_isSaving)
        {
            SaveButton.Content = "Salvando...";
        }
        else
        {
            var contentPanel = new StackPanel { Orientation = Orientation.Horizontal };
            contentPanel.Children.Add(new TextBlock { Text = "💾", FontSize = 18, Margin = new Thickness(0, 0, 10, 0), VerticalAlignment = VerticalAlignment.Center });
            contentPanel.Children.Add(new TextBlock { Text = "Salvar Alterações", VerticalAlignment = VerticalAlignment.Center, FontWeight = FontWeights.SemiBold });
            SaveButton.Content = contentPanel;
        }
    }

    private void ShowMessage(string message, bool isError)
    {
        MessageBorder.Visibility = Visibility.Visible;
        MessageText.Text = message;

        if (isError)
        {
            MessageBorder.Background = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#FFF8D7DA"));
            MessageBorder.BorderBrush = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#FFF5C6CB"));
            MessageText.Foreground = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#FF721C24"));
        }
        else
        {
            MessageBorder.Background = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#FFE8F5E9"));
            MessageBorder.BorderBrush = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#FF4CAF50"));
            MessageText.Foreground = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#FF2E7D32"));
        }
    }

    private void CloseButton_Click(object sender, RoutedEventArgs e)
    {
        DialogResult = false;
        Close();
    }
}