namespace PizzariaDesktop.ViewModels;

using System.ComponentModel;
using System.Windows.Input;
using System.Windows;
using PizzariaDesktop.Models;
using PizzariaDesktop.Services;

public class LoginViewModel : BaseViewModel
{
    private string _email = string.Empty;
    private string _password = string.Empty;
    private string _errorMessage = string.Empty;
    private bool _isLoading = false;

    public string Email
    {
        get => _email;
        set => SetProperty(ref _email, value);
    }

    public string Password
    {
        get => _password;
        set => SetProperty(ref _password, value);
    }

    public string ErrorMessage
    {
        get => _errorMessage;
        set => SetProperty(ref _errorMessage, value);
    }

    public bool IsLoading
    {
        get => _isLoading;
        set => SetProperty(ref _isLoading, value);
    }

    public ICommand LoginCommand { get; }
    public ICommand GoToRegisterCommand { get; }

    private readonly IAuthService? _authService;

    public LoginViewModel()
    {
        // Para design-time
        LoginCommand = new RelayCommand(async _ => await LoginAsync());
        GoToRegisterCommand = new RelayCommand(_ => GoToRegister());
        _authService = null;
    }

    public LoginViewModel(IAuthService authService) : this()
    {
        _authService = authService;
    }

    private async Task LoginAsync()
    {
        // Trim email and password to avoid whitespace issues
        var trimmedEmail = Email?.Trim() ?? string.Empty;
        var trimmedPassword = Password?.Trim() ?? string.Empty;

        if (string.IsNullOrWhiteSpace(trimmedEmail) || string.IsNullOrWhiteSpace(trimmedPassword))
        {
            ErrorMessage = "Preencha todos os campos";
            return;
        }

        IsLoading = true;
        ErrorMessage = string.Empty;

        try
        {
            if (_authService != null)
            {
                var result = await _authService.LoginAsync(trimmedEmail, trimmedPassword);

                if (result.Success && result.User != null)
                {
                    OnLoginSuccess?.Invoke(result.User);
                }
                else
                {
                    ErrorMessage = result.ErrorMessage;
                }
            }
            else
            {
                // Fallback para modo demo (sem DI)
                await Task.Delay(500);
                var user = new User
                {
                    Id = "demo-001",
                    Name = "Usuário Demo",
                    Email = Email,
                    Phone = "(11) 99999-9999",
                    CreatedAt = DateTime.Now
                };
                OnLoginSuccess?.Invoke(user);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage = $"Erro ao fazer login: {ex.Message}";
        }
        finally
        {
            IsLoading = false;
        }
    }

    public event Action<User>? OnLoginSuccess;

    public void GoToRegister()
    {
        OnGoToRegister?.Invoke();
    }

    public event Action? OnGoToRegister;
}