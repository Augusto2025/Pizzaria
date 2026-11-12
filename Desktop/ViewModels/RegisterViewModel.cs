namespace PizzariaDesktop.ViewModels;

using System.ComponentModel;
using System.Windows.Input;
using System.Windows;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using PizzariaDesktop.Models;
using PizzariaDesktop.Services;

public class RegisterViewModel : BaseViewModel
{
    private string _name = string.Empty;
    private string _email = string.Empty;
    private string _phone = string.Empty;
    private string _password = string.Empty;
    private string _confirmPassword = string.Empty;
    private string _errorMessage = string.Empty;
    private bool _isLoading = false;

    // Field validation properties
    private bool _hasNameError;
    private bool _hasEmailError;
    private bool _hasPhoneError;
    private bool _hasPasswordError;
    private bool _hasConfirmPasswordError;

    public string Name
    {
        get => _name;
        set => SetProperty(ref _name, value);
    }

    public string Email
    {
        get => _email;
        set => SetProperty(ref _email, value);
    }

    public string Phone
    {
        get => _phone;
        set => SetProperty(ref _phone, value);
    }

    public string Password
    {
        get => _password;
        set => SetProperty(ref _password, value);
    }

    public string ConfirmPassword
    {
        get => _confirmPassword;
        set => SetProperty(ref _confirmPassword, value);
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

    // Field validation properties
    public bool HasNameError
    {
        get => _hasNameError;
        set => SetProperty(ref _hasNameError, value);
    }

    public bool HasEmailError
    {
        get => _hasEmailError;
        set => SetProperty(ref _hasEmailError, value);
    }

    public bool HasPhoneError
    {
        get => _hasPhoneError;
        set => SetProperty(ref _hasPhoneError, value);
    }

    public bool HasPasswordError
    {
        get => _hasPasswordError;
        set => SetProperty(ref _hasPasswordError, value);
    }

    public bool HasConfirmPasswordError
    {
        get => _hasConfirmPasswordError;
        set => SetProperty(ref _hasConfirmPasswordError, value);
    }

    public ICommand RegisterCommand { get; }
    public ICommand GoToLoginCommand { get; }

    private readonly IAuthService? _authService;

    public RegisterViewModel()
    {
        // Para design-time
        RegisterCommand = new RelayCommand(async _ => await RegisterAsync());
        GoToLoginCommand = new RelayCommand(_ => GoToLogin());
        _authService = null;
    }

    public RegisterViewModel(IAuthService authService) : this()
    {
        _authService = authService;
    }

    private async Task RegisterAsync()
    {
        Console.WriteLine($"=== REGISTER BUTTON CLICKED ===");
        Console.WriteLine($"Name: {Name}");
        Console.WriteLine($"Email: {Email}");
        Console.WriteLine($"Phone: {Phone}");

        // Clear previous field errors
        HasNameError = false;
        HasEmailError = false;
        HasPhoneError = false;
        HasPasswordError = false;
        HasConfirmPasswordError = false;
        ErrorMessage = string.Empty;

        bool hasErrors = false;

        // Validate each field individually
        if (string.IsNullOrWhiteSpace(Name))
        {
            HasNameError = true;
            hasErrors = true;
        }

        if (string.IsNullOrWhiteSpace(Email))
        {
            HasEmailError = true;
            hasErrors = true;
        }
        else if (!Email.Contains("@") || !Email.Contains("."))
        {
            HasEmailError = true;
            hasErrors = true;
        }

        if (string.IsNullOrWhiteSpace(Phone))
        {
            HasPhoneError = true;
            hasErrors = true;
        }

        if (string.IsNullOrWhiteSpace(Password))
        {
            HasPasswordError = true;
            hasErrors = true;
        }
        else if (Password.Trim().Length < 6)
        {
            HasPasswordError = true;
            hasErrors = true;
        }

        if (string.IsNullOrWhiteSpace(ConfirmPassword))
        {
            HasConfirmPasswordError = true;
            hasErrors = true;
        }
        else if (Password.Trim() != ConfirmPassword.Trim())
        {
            HasConfirmPasswordError = true;
            hasErrors = true;
        }

        if (hasErrors)
        {
            ErrorMessage = "Preencha todos os campos obrigatórios";
            Console.WriteLine($"Registration validation failed: {ErrorMessage}");
            return;
        }

        IsLoading = true;
        ErrorMessage = string.Empty;

        try
        {
            // Clean phone - remove mask characters, keep only digits
            var cleanPhone = System.Text.RegularExpressions.Regex.Replace(Phone, @"\D", "");
            Console.WriteLine($"Clean phone: {cleanPhone}");

            // Trim password for storage
            var trimmedPassword = Password.Trim();

            if (_authService != null)
            {
                Console.WriteLine($"Calling AuthService.RegisterAsync...");
                var result = await _authService.RegisterAsync(Name, Email, trimmedPassword, cleanPhone);

                if (result.Success && result.User != null)
                {
                    Console.WriteLine($"Registration successful, invoking OnRegisterSuccess");
                    OnRegisterSuccess?.Invoke(result.User);
                }
                else
                {
                    ErrorMessage = result.ErrorMessage;
                    Console.WriteLine($"Registration failed from AuthService: {ErrorMessage}");
                }
            }
            else
            {
                Console.WriteLine($"AuthService is null, using fallback demo mode");
                // Fallback para modo demo (sem DI)
                await Task.Delay(500);
                var user = new User
                {
                    Id = $"user-{DateTime.UtcNow:yyyyMMddHHmmss}",
                    Name = Name,
                    Email = Email,
                    Phone = cleanPhone,
                    CreatedAt = DateTime.UtcNow
                };
                OnRegisterSuccess?.Invoke(user);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"=== REGISTER VIEWMODEL ERROR ===");
            Console.WriteLine($"Exception Type: {ex.GetType().Name}");
            Console.WriteLine($"Message: {ex.Message}");
            Console.WriteLine($"StackTrace: {ex.StackTrace}");
            if (ex.InnerException != null)
            {
                Console.WriteLine($"Inner Exception: {ex.InnerException.Message}");
            }
            Console.WriteLine($"=================================");

            ErrorMessage = $"Erro ao cadastrar: {ex.Message}";
        }
        finally
        {
            IsLoading = false;
        }
    }

    public event Action<User>? OnRegisterSuccess;

    public void GoToLogin()
    {
        OnGoToLogin?.Invoke();
    }

    public event Action? OnGoToLogin;
}