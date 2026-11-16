namespace PizzariaDesktop.Services;

using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using PizzariaDesktop.Models;

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
        var appDataPath = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
        var appFolder = Path.Combine(appDataPath, "PizzariaDesktop");
        Directory.CreateDirectory(appFolder);
        _settingsPath = Path.Combine(appFolder, "lastlogin.json");
    }

    public LastLoginInfo? GetLastLogin()
    {
        try
        {
            if (!File.Exists(_settingsPath))
                return null;

            var json = File.ReadAllText(_settingsPath);
            var info = JsonSerializer.Deserialize<LastLoginInfo>(json);
            return info;
        }
        catch
        {
            return null;
        }
    }

    public void SaveLastLogin(string email, string password)
    {
        try
        {
            // Encrypt password using DPAPI (Windows Data Protection API)
            var passwordBytes = Encoding.UTF8.GetBytes(password);
            var encryptedBytes = ProtectedData.Protect(passwordBytes, null, DataProtectionScope.CurrentUser);
            var encryptedPassword = Convert.ToBase64String(encryptedBytes);

            var info = new LastLoginInfo
            {
                Email = email,
                EncryptedPassword = encryptedPassword,
                LastAccess = DateTime.UtcNow
            };

            var json = JsonSerializer.Serialize(info, new JsonSerializerOptions { WriteIndented = true });
            File.WriteAllText(_settingsPath, json);
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"[LastLoginService] Erro ao salvar último login: {ex.Message}");
        }
    }

    public void ClearLastLogin()
    {
        try
        {
            if (File.Exists(_settingsPath))
                File.Delete(_settingsPath);
        }
        catch
        {
            // Ignore
        }
    }

    public string? DecryptPassword(string encryptedPassword)
    {
        try
        {
            var encryptedBytes = Convert.FromBase64String(encryptedPassword);
            var decryptedBytes = ProtectedData.Unprotect(encryptedBytes, null, DataProtectionScope.CurrentUser);
            return Encoding.UTF8.GetString(decryptedBytes);
        }
        catch
        {
            return null;
        }
    }
}