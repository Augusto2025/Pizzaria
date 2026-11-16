namespace PizzariaDesktop.Views.Profile;

using System;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using Microsoft.Extensions.DependencyInjection;
using PizzariaDesktop;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data.Repositories;
using PizzariaDesktop.Services;
using BCrypt.Net;

public partial class EditProfileDialog : Window
{
    private readonly User _currentUser;
    private readonly IUserRepository _userRepository;
    private readonly IServiceScope _serviceScope;
    private bool _isSaving = false;

    public EditProfileDialog(User currentUser)
    {
        try
        {
            InitializeComponent();
            _currentUser = currentUser ?? throw new ArgumentNullException(nameof(currentUser));

            // Create a scope to resolve Scoped services (repositories, DbContext)
            _serviceScope = App.Services.CreateScope();
            _userRepository = _serviceScope.ServiceProvider.GetRequiredService<IUserRepository>();

            LoadUserData();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Erro no construtor EditProfileDialog: {ex.Message}");
            System.Diagnostics.Debug.WriteLine($"StackTrace: {ex.StackTrace}");
            if (ex.InnerException != null)
            {
                System.Diagnostics.Debug.WriteLine($"Inner Exception: {ex.InnerException.Message}");
                System.Diagnostics.Debug.WriteLine($"Inner StackTrace: {ex.InnerException.StackTrace}");
            }
            throw; // Re-throw to let the caller handle it
        }
    }

    protected override void OnClosed(EventArgs e)
    {
        base.OnClosed(e);
        // Dispose the scope when dialog closes
        _serviceScope?.Dispose();
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

            if (hasChanges)
            {
                System.Diagnostics.Debug.WriteLine($"[EditProfileDialog] Saving changes for user ID: {_currentUser.Id}, Email: {_currentUser.Email}");

                // Update user in database (name, phone)
                var success = await _userRepository.UpdateAsync(_currentUser);
                System.Diagnostics.Debug.WriteLine($"[EditProfileDialog] UpdateAsync result: {success}");

                // If password changed, update it separately
                if (success && !string.IsNullOrWhiteSpace(newPassword))
                {
                    var passwordHash = BCrypt.HashPassword(newPassword);
                    success = await _userRepository.UpdatePasswordAsync(_currentUser.Id, passwordHash);
                    System.Diagnostics.Debug.WriteLine($"[EditProfileDialog] UpdatePasswordAsync result: {success}");
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
                    System.Diagnostics.Debug.WriteLine($"[EditProfileDialog] UpdateAsync returned false - user not found or save failed");
                    ShowMessage("Erro ao salvar alterações: usuário não encontrado no banco de dados", isError: true);
                }
            }
            else if (!hasChanges)
            {
                ShowMessage("Nenhuma alteração detectada", isError: true);
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"[EditProfileDialog] ERRO ao salvar perfil: {ex.Message}");
            System.Diagnostics.Debug.WriteLine($"[EditProfileDialog] StackTrace: {ex.StackTrace}");
            if (ex.InnerException != null)
            {
                System.Diagnostics.Debug.WriteLine($"[EditProfileDialog] InnerException: {ex.InnerException.Message}");
                System.Diagnostics.Debug.WriteLine($"[EditProfileDialog] InnerStackTrace: {ex.InnerException.StackTrace}");
            }
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