namespace PizzariaDesktop.Api.DTOs;

using System.ComponentModel.DataAnnotations;

public record LoginRequest(
    [Required][EmailAddress] string Email,
    [Required][MinLength(6)] string Password
);

public record RegisterRequest(
    [Required][MinLength(2)] string Name,
    [Required][EmailAddress] string Email,
    [Required][Phone] string Phone,
    [Required][MinLength(6)] string Password,
    [Required] string ConfirmPassword
);

public record AuthResponse(
    bool Success,
    string? ErrorMessage,
    UserDto? User,
    string? Token
);

public record UserDto(
    string Id,
    string Name,
    string Email,
    string Phone,
    DateTime CreatedAt,
    List<AddressDto>? Addresses = null
);

public record AddressDto(
    string Id,
    string Label,
    string Street,
    string Number,
    string Complement,
    string Neighborhood,
    string City,
    string State,
    string ZipCode,
    double Latitude,
    double Longitude,
    bool IsDefault
);