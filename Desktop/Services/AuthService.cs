namespace PizzariaDesktop.Services;

using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using PizzariaDesktop.Data.Repositories;
using PizzariaDesktop.Models;
using BCrypt.Net;

public interface IAuthService
{
    Task<AuthResult> LoginAsync(string email, string password);
    Task<AuthResult> RegisterAsync(string name, string email, string password, string phone);
    Task<User?> GetCurrentUserAsync();
    Task<bool> LogoutAsync();
    string GenerateJwtToken(User user);
    ClaimsPrincipal? ValidateToken(string token);
    bool IsTokenExpired(string token);
}

public class AuthResult
{
    public bool Success { get; set; }
    public string ErrorMessage { get; set; } = string.Empty;
    public User? User { get; set; }
    public string? Token { get; set; }
}

public class AuthService : IAuthService
{
    private readonly IUserRepository _userRepository;
    private readonly IConfiguration _configuration;
    private User? _currentUser;
    private string? _currentToken;

    public AuthService(IUserRepository userRepository, IConfiguration configuration)
    {
        _userRepository = userRepository;
        _configuration = configuration;
    }

    public async Task<AuthResult> LoginAsync(string email, string password)
    {
        if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
        {
            return new AuthResult { Success = false, ErrorMessage = "Preencha todos os campos" };
        }

        var isValid = await _userRepository.VerifyPasswordAsync(email, password);
        if (!isValid)
        {
            return new AuthResult { Success = false, ErrorMessage = "Email ou senha inválidos" };
        }

        var user = await _userRepository.GetByEmailWithAddressesAsync(email);
        if (user == null)
        {
            return new AuthResult { Success = false, ErrorMessage = "Usuário não encontrado" };
        }

        var token = GenerateJwtToken(user);
        _currentUser = user;
        _currentToken = token;

        return new AuthResult
        {
            Success = true,
            User = user,
            Token = token
        };
    }

    public async Task<AuthResult> RegisterAsync(string name, string email, string password, string phone)
    {
        Console.WriteLine($"=== REGISTER ATTEMPT ===");
        Console.WriteLine($"Name: {name}");
        Console.WriteLine($"Email: {email}");
        Console.WriteLine($"Phone: {phone}");

        if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
        {
            Console.WriteLine($"Registration failed: Missing required fields");
            return new AuthResult { Success = false, ErrorMessage = "Preencha todos os campos obrigatórios" };
        }

        if (await _userRepository.ExistsAsync(email))
        {
            Console.WriteLine($"Registration failed: Email already exists: {email}");
            return new AuthResult { Success = false, ErrorMessage = "Este email já está cadastrado" };
        }

        if (password.Length < 6)
        {
            Console.WriteLine($"Registration failed: Password too short");
            return new AuthResult { Success = false, ErrorMessage = "A senha deve ter pelo menos 6 caracteres" };
        }

        try
        {
            var passwordHash = BCrypt.HashPassword(password, workFactor: 12);
            Console.WriteLine($"Password hashed successfully");

            var user = new User
            {
                Name = name,
                Email = email,
                Phone = phone ?? string.Empty,
                CreatedAt = DateTime.UtcNow
            };
            Console.WriteLine($"User object created: {user.Email}, CreatedAt: {user.CreatedAt} (Kind: {user.CreatedAt.Kind})");

            var createdUser = await _userRepository.CreateAsync(user, passwordHash);
            Console.WriteLine($"User created successfully in DB: {createdUser.Id}");

            var token = GenerateJwtToken(createdUser);
            _currentUser = createdUser;
            _currentToken = token;

            Console.WriteLine($"=== REGISTRATION SUCCESS ===");
            return new AuthResult
            {
                Success = true,
                User = createdUser,
                Token = token
            };
        }
        catch (Exception ex)
        {
            Console.WriteLine($"=== REGISTRATION ERROR ===");
            Console.WriteLine($"Exception Type: {ex.GetType().Name}");
            Console.WriteLine($"Message: {ex.Message}");
            Console.WriteLine($"StackTrace: {ex.StackTrace}");

            if (ex.InnerException != null)
            {
                Console.WriteLine($"--- INNER EXCEPTION ---");
                Console.WriteLine($"Inner Type: {ex.InnerException.GetType().Name}");
                Console.WriteLine($"Inner Message: {ex.InnerException.Message}");
                Console.WriteLine($"Inner StackTrace: {ex.InnerException.StackTrace}");

                if (ex.InnerException.InnerException != null)
                {
                    Console.WriteLine($"--- DEEP INNER EXCEPTION ---");
                    Console.WriteLine($"Deep Inner Type: {ex.InnerException.InnerException.GetType().Name}");
                    Console.WriteLine($"Deep Inner Message: {ex.InnerException.InnerException.Message}");
                    Console.WriteLine($"Deep Inner StackTrace: {ex.InnerException.InnerException.StackTrace}");
                }
            }
            Console.WriteLine($"==========================");

            return new AuthResult
            {
                Success = false,
                ErrorMessage = $"Erro ao cadastrar: {ex.Message}"
            };
        }
    }

    public Task<User?> GetCurrentUserAsync()
    {
        return Task.FromResult(_currentUser);
    }

    public Task<bool> LogoutAsync()
    {
        _currentUser = null;
        _currentToken = null;
        return Task.FromResult(true);
    }

    public string GenerateJwtToken(User user)
    {
        var secretKey = _configuration["JWT_SECRET_KEY"] ?? "PizzariaDesktop_SecretKey_2024_ChangeInProduction_UseStrongRandomKey!";
        var issuer = _configuration["JWT_ISSUER"] ?? "PizzariaDesktop";
        var audience = _configuration["JWT_AUDIENCE"] ?? "PizzariaDesktopUsers";
        var expiryHours = int.TryParse(_configuration["JWT_EXPIRY_HOURS"], out var hours) ? hours : 24;

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var claims = new[]
        {
            new Claim(JwtRegisteredClaimNames.Sub, user.Id),
            new Claim(JwtRegisteredClaimNames.Email, user.Email),
            new Claim(JwtRegisteredClaimNames.Name, user.Name),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            new Claim(ClaimTypes.NameIdentifier, user.Id)
        };

        var token = new JwtSecurityToken(
            issuer: issuer,
            audience: audience,
            claims: claims,
            expires: DateTime.UtcNow.AddHours(expiryHours),
            signingCredentials: creds
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    public ClaimsPrincipal? ValidateToken(string token)
    {
        if (string.IsNullOrEmpty(token)) return null;

        try
        {
            var secretKey = _configuration["JWT_SECRET_KEY"] ?? "PizzariaDesktop_SecretKey_2024_ChangeInProduction_UseStrongRandomKey!";
            var issuer = _configuration["JWT_ISSUER"] ?? "PizzariaDesktop";
            var audience = _configuration["JWT_AUDIENCE"] ?? "PizzariaDesktopUsers";

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey));
            var handler = new JwtSecurityTokenHandler();

            var validationParameters = new TokenValidationParameters
            {
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = key,
                ValidateIssuer = true,
                ValidIssuer = issuer,
                ValidateAudience = true,
                ValidAudience = audience,
                ValidateLifetime = true,
                ClockSkew = TimeSpan.Zero
            };

            var principal = handler.ValidateToken(token, validationParameters, out _);
            return principal;
        }
        catch
        {
            return null;
        }
    }

    public bool IsTokenExpired(string token)
    {
        try
        {
            var handler = new JwtSecurityTokenHandler();
            var jwtToken = handler.ReadJwtToken(token);
            return jwtToken.ValidTo < DateTime.UtcNow;
        }
        catch
        {
            return true;
        }
    }

    public void SetCurrentUser(User user, string token)
    {
        _currentUser = user;
        _currentToken = token;
    }
}