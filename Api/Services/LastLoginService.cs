namespace PizzariaDesktop.Services;

using System;
using System.IO;
using System.Text.Json;

public interface ILastLoginService
{
    LastLoginInfo? GetLastLogin();
    void SaveLastLogin(string email, string password);
    void ClearLastLogin();
    string? DecryptPassword(string encryptedPassword);
}

public class LastLoginInfo
{
    public string Email { get; set; } = string.Empty;
    public string EncryptedPassword { get; set; } = string.Empty;
    public DateTime LastAccess { get; set; } = DateTime.UtcNow;
}

public class LastLoginService : ILastLoginService
{
    private readonly string _settingsPath;

    public LastLoginService()
    {
        // For API, we don't persist last login - it's a desktop feature
        // Mobile uses JWT tokens instead
        _settingsPath = Path.Combine(Path.GetTempPath(), "pizzaria_lastlogin.json");
    }

    public LastLoginInfo? GetLastLogin()
    {
        // API doesn't support "last login" feature - mobile uses JWT
        return null;
    }

    public void SaveLastLogin(string email, string password)
    {
        // No-op for API - mobile uses JWT tokens
    }

    public void ClearLastLogin()
    {
        // No-op for API
    }

    public string? DecryptPassword(string encryptedPassword)
    {
        // No-op for API
        return null;
    }
}