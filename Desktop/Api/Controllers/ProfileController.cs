namespace PizzariaDesktop.Api.Controllers;

using System.ComponentModel.DataAnnotations;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PizzariaDesktop.Api.DTOs;
using PizzariaDesktop.Data;
using PizzariaDesktop.Data.Entities;
using PizzariaDesktop.Services;
using BCrypt.Net;

[ApiController]
[Route("api/v1/profile")]
[Authorize]
public class ProfileController : ControllerBase
{
    private readonly PizzariaDbContext _dbContext;
    private readonly IAuthService _authService;

    public ProfileController(PizzariaDbContext dbContext, IAuthService authService)
    {
        _dbContext = dbContext;
        _authService = authService;
    }

    private string GetUserId()
    {
        return User.FindFirst(ClaimTypes.NameIdentifier)?.Value
            ?? User.FindFirst("sub")?.Value
            ?? throw new UnauthorizedAccessException("User not authenticated");
    }

    [HttpGet]
    public async Task<ActionResult<UserDto>> GetProfile()
    {
        try
        {
            var userId = GetUserId();

            var user = await _dbContext.Users
                .Include(u => u.Addresses)
                .FirstOrDefaultAsync(u => u.Id == userId);

            if (user == null)
            {
                return NotFound("Usuário não encontrado");
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

            return Ok(userDto);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    public record UpdateProfileRequest(
        [MaxLength(100)] string? Name,
        [MaxLength(20)] string? Phone,
        string? CurrentPassword,
        [MinLength(6)] string? NewPassword,
        [Compare("NewPassword")] string? ConfirmNewPassword
    );

    [HttpPut]
    public async Task<ActionResult<UserDto>> UpdateProfile([FromBody] UpdateProfileRequest request)
    {
        try
        {
            var userId = GetUserId();

            var user = await _dbContext.Users
                .Include(u => u.Addresses)
                .FirstOrDefaultAsync(u => u.Id == userId);

            if (user == null)
            {
                return NotFound("Usuário não encontrado");
            }

            // Update name
            if (!string.IsNullOrEmpty(request.Name))
            {
                user.Name = request.Name;
            }

            // Update phone
            if (!string.IsNullOrEmpty(request.Phone))
            {
                user.Phone = System.Text.RegularExpressions.Regex.Replace(request.Phone, @"\D", "");
            }

            // Update password if provided
            if (!string.IsNullOrEmpty(request.CurrentPassword) && !string.IsNullOrEmpty(request.NewPassword))
            {
                if (request.NewPassword != request.ConfirmNewPassword)
                {
                    return BadRequest("Nova senha e confirmação não coincidem");
                }

                // Verify current password
                if (!BCrypt.Net.BCrypt.Verify(request.CurrentPassword, user.PasswordHash))
                {
                    return BadRequest("Senha atual incorreta");
                }

                user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.NewPassword);
            }

            await _dbContext.SaveChangesAsync();

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

            return Ok(userDto);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpDelete]
    public async Task<ActionResult> DeleteAccount()
    {
        try
        {
            var userId = GetUserId();

            var user = await _dbContext.Users.FindAsync(userId);
            if (user == null)
            {
                return NotFound("Usuário não encontrado");
            }

            _dbContext.Users.Remove(user);
            await _dbContext.SaveChangesAsync();

            return Ok(new { success = true, message = "Conta excluída com sucesso" });
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpGet("stats")]
    public async Task<ActionResult> GetStats()
    {
        try
        {
            var userId = GetUserId();

            var totalOrders = await _dbContext.Orders.CountAsync(o => o.UserId == userId);
            var deliveredOrders = await _dbContext.Orders.CountAsync(o => o.UserId == userId && o.Status == (int)OrderStatus.Delivered);
            var totalSpent = await _dbContext.Orders
                .Where(o => o.UserId == userId && o.Status == (int)OrderStatus.Delivered)
                .SumAsync(o => (decimal?)(o.Subtotal + o.DeliveryFee)) ?? 0;

            return Ok(new
            {
                totalOrders,
                deliveredOrders,
                totalSpent
            });
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }
}