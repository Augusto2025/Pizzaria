namespace PizzariaDesktop.ViewModels;

using System.ComponentModel;
using System.Windows.Input;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data;

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

    public LoginViewModel()
    {
        LoginCommand = new RelayCommand(async _ => await LoginAsync());
        GoToRegisterCommand = new RelayCommand(_ => GoToRegister());
    }

    private async Task LoginAsync()
    {
        if (string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password))
        {
            ErrorMessage = "Preencha todos os campos";
            return;
        }

        IsLoading = true;
        ErrorMessage = string.Empty;

        // Simulate async login
        await Task.Delay(500);

        // Demo: any email/password works
        var user = MockData.CurrentUser;

        // Navigate via MainViewModel - we need to access it
        // For now, we'll use a callback approach
        OnLoginSuccess?.Invoke(user);
    }

    public event Action<User>? OnLoginSuccess;

    public void GoToRegister()
    {
        OnGoToRegister?.Invoke();
    }

    public event Action? OnGoToRegister;
}