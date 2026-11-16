namespace PizzariaDesktop.ViewModels;

using System.ComponentModel;
using System.Windows.Input;
using System.Windows;
using Microsoft.Extensions.DependencyInjection;
using PizzariaDesktop.Models;
using PizzariaDesktop.Services;

public class LoginViewModel : BaseViewModel
{
    private readonly ILastLoginService _lastLoginService;
    private string _email = string.Empty;
    private string _password = string.Empty;
    private string _errorMessage = string.Empty;
    private bool _isLoading = false;
    private bool _hasLastLogin = false;
    private string _lastLoginEmail = string.Empty;

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

    public bool HasLastLogin
    {
        get => _hasLastLogin;
        set => SetProperty(ref _hasLastLogin, value);
    }

    public string LastLoginEmail
    {
        get => _lastLoginEmail;
        set => SetProperty(ref _lastLoginEmail, value);
    }

    public ICommand LoginCommand { get; }
    public ICommand GoToRegisterCommand { get; }
    public ICommand UseLastLoginCommand { get; }

    public LoginViewModel(ILastLoginService lastLoginService)
    {
        _lastLoginService = lastLoginService;
        LoginCommand = new RelayCommand(async _ => await LoginAsync());
        GoToRegisterCommand = new RelayCommand(_ => GoToRegister());
        UseLastLoginCommand = new RelayCommand(async _ => await UseLastLoginAsync(), _ => HasLastLogin && !IsLoading);

        LoadLastLogin();
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
            // Create a scope for this operation
            using var scope = App.Services.CreateScope();
            var authService = scope.ServiceProvider.GetRequiredService<IAuthService>();
            var result = await authService.LoginAsync(trimmedEmail, trimmedPassword);

            if (result.Success && result.User != null)
            {
                // Save last login for next time
                _lastLoginService.SaveLastLogin(trimmedEmail, trimmedPassword);
                LoadLastLogin();

                OnLoginSuccess?.Invoke(result.User);
            }
            else
            {
                ErrorMessage = result.ErrorMessage;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"[LoginViewModel] Erro ao fazer login: {ex.Message}");
            System.Diagnostics.Debug.WriteLine($"[LoginViewModel] StackTrace: {ex.StackTrace}");
            if (ex.InnerException != null)
            {
                System.Diagnostics.Debug.WriteLine($"[LoginViewModel] InnerException: {ex.InnerException.Message}");
            }
            ErrorMessage = $"Erro ao fazer login: {ex.Message}";
        }
        finally
        {
            IsLoading = false;
            CommandManager.InvalidateRequerySuggested();
        }
    }

    private void LoadLastLogin()
    {
        var lastLogin = _lastLoginService.GetLastLogin();
        if (lastLogin != null && !string.IsNullOrEmpty(lastLogin.Email))
        {
            HasLastLogin = true;
            LastLoginEmail = lastLogin.Email;
        }
        else
        {
            HasLastLogin = false;
            LastLoginEmail = string.Empty;
        }
        CommandManager.InvalidateRequerySuggested();
    }

    private async Task UseLastLoginAsync()
    {
        var lastLogin = _lastLoginService.GetLastLogin();
        if (lastLogin == null || string.IsNullOrEmpty(lastLogin.Email))
            return;

        var password = _lastLoginService.DecryptPassword(lastLogin.EncryptedPassword);
        if (string.IsNullOrEmpty(password))
        {
            // If can't decrypt, just fill email and focus password
            Email = lastLogin.Email;
            Password = string.Empty;
            ErrorMessage = "Insira sua senha para continuar";
            return;
        }

        Email = lastLogin.Email;
        Password = password;

        // Auto-login
        await LoginAsync();
    }

    public event Action<User>? OnLoginSuccess;

    public void GoToRegister()
    {
        OnGoToRegister?.Invoke();
    }

    public event Action? OnGoToRegister;
}