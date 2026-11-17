namespace PizzariaDesktop.Api.Controllers;

using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PizzariaDesktop.Api.DTOs;
using PizzariaDesktop.Data;
using PizzariaDesktop.Models;
using PizzariaDesktop.Services;
using BCrypt.Net;

[ApiController]
[Route("api/v1/auth")]
public class AuthController : ControllerBase
{
    private readonly PizzariaDbContext _dbContext;
    private readonly IAuthService _authService;
    private readonly IConfiguration _configuration;

    public AuthController(PizzariaDbContext dbContext, IAuthService authService, IConfiguration configuration)
    {
        _dbContext = dbContext;
        _authService = authService;
        _configuration = configuration;
    }

    [HttpPost("login")]
    public async Task<ActionResult<AuthResponse>> Login([FromBody] LoginRequest request)
    {
        try
        {
            var result = await _authService.LoginAsync(request.Email, request.Password);

            if (!result.Success || result.User == null)
            {
                return BadRequest(new AuthResponse(false, result.ErrorMessage, null, null));
            }

            var token = _authService.GenerateJwtToken(result.User);

            var userDto = new UserDto(
                result.User.Id,
                result.User.Name,
                result.User.Email,
                result.User.Phone,
                result.User.CreatedAt,
                result.User.Addresses?.Select(a => new AddressDto(
                    a.Id, a.Label, a.Street, a.Number, a.Complement,
                    a.Neighborhood, a.City, a.State, a.ZipCode,
                    a.Latitude, a.Longitude, a.IsDefault)).ToList()
            );

            return Ok(new AuthResponse(true, null, userDto, token));
        }
        catch (Exception ex)
        {
            return StatusCode(500, new AuthResponse(false, $"Erro interno: {ex.Message}", null, null));
        }
    }

    [HttpPost("register")]
    public async Task<ActionResult<AuthResponse>> Register([FromBody] RegisterRequest request)
    {
        try
        {
            var cleanPhone = System.Text.RegularExpressions.Regex.Replace(request.Phone, @"\D", "");
            var result = await _authService.RegisterAsync(request.Name, request.Email, request.Password, cleanPhone);

            if (!result.Success || result.User == null)
            {
                return BadRequest(new AuthResponse(false, result.ErrorMessage, null, null));
            }

            var token = _authService.GenerateJwtToken(result.User);

            var userDto = new UserDto(
                result.User.Id,
                result.User.Name,
                result.User.Email,
                result.User.Phone,
                result.User.CreatedAt
            );

            return Ok(new AuthResponse(true, null, userDto, token));
        }
        catch (Exception ex)
        {
            return StatusCode(500, new AuthResponse(false, $"Erro interno: {ex.Message}", null, null));
        }
    }

    [HttpGet("me")]
    [Authorize]
    public async Task<ActionResult<AuthResponse>> GetCurrentUser()
    {
        try
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value
                        ?? User.FindFirst("sub")?.Value;

            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized(new AuthResponse(false, "Usuário não autenticado", null, null));
            }

            var user = await _dbContext.Users
                .Include(u => u.Addresses)
                .FirstOrDefaultAsync(u => u.Id == userId);

            if (user == null)
            {
                return NotFound(new AuthResponse(false, "Usuário não encontrado", null, null));
            }

            var userDto = new UserDto(
                user.Id,
                user.Name,
                user.Email,
                user.Phone,
                user.CreatedAt,
                user.Addresses?.Select(a => new AddressDto(
                    a.Id, a.Label, a.Street, a.Number, a.Complement,
                    a.Neighborhood, a.City, a.State, a.ZipCode,
                    a.Latitude, a.Longitude, a.IsDefault)).ToList()
            );

            return Ok(new AuthResponse(true, null, userDto, null));
        }
        catch (Exception ex)
        {
            return StatusCode(500, new AuthResponse(false, $"Erro interno: {ex.Message}", null, null));
        }
    }

    [HttpPost("logout")]
    [Authorize]
    public async Task<ActionResult> Logout()
    {
        // JWT is stateless, client just discards token
        // Could implement token blacklist here if needed
        return Ok(new { success = true, message = "Logged out successfully" });
    }
}