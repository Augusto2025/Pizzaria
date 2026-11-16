namespace PizzariaDesktop.Api.Controllers;

using System.ComponentModel.DataAnnotations;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PizzariaDesktop.Api.DTOs;
using PizzariaDesktop.Data;
using PizzariaDesktop.Data.Entities;
using PizzariaDesktop.Models;

[ApiController]
[Route("api/v1/addresses")]
[Authorize]
public class AddressesController : ControllerBase
{
    private readonly PizzariaDbContext _dbContext;

    public AddressesController(PizzariaDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    private string GetUserId()
    {
        return User.FindFirst(ClaimTypes.NameIdentifier)?.Value
            ?? User.FindFirst("sub")?.Value
            ?? throw new UnauthorizedAccessException("User not authenticated");
    }

    [HttpGet]
    public async Task<ActionResult<List<AddressDto>>> GetAddresses()
    {
        try
        {
            var userId = GetUserId();

            var addresses = await _dbContext.Addresses
                .Where(a => a.UserId == userId)
                .OrderByDescending(a => a.IsDefault)
                .ThenBy(a => a.Label)
                .Select(a => new AddressDto(
                    a.Id, a.Label, a.Street, a.Number, a.Complement,
                    a.Neighborhood, a.City, a.State, a.ZipCode,
                    a.Latitude, a.Longitude, a.IsDefault
                ))
                .ToListAsync();

            return Ok(addresses);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<AddressDto>> GetAddress(string id)
    {
        try
        {
            var userId = GetUserId();

            var address = await _dbContext.Addresses
                .FirstOrDefaultAsync(a => a.Id == id && a.UserId == userId);

            if (address == null)
            {
                return NotFound("Endereço não encontrado");
            }

            var addressDto = new AddressDto(
                address.Id, address.Label, address.Street, address.Number, address.Complement,
                address.Neighborhood, address.City, address.State, address.ZipCode,
                address.Latitude, address.Longitude, address.IsDefault
            );

            return Ok(addressDto);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    public record CreateAddressRequest(
        [Required][MaxLength(50)] string Label,
        [Required][MaxLength(100)] string Street,
        [Required][MaxLength(20)] string Number,
        [MaxLength(50)] string Complement,
        [Required][MaxLength(50)] string Neighborhood,
        [Required][MaxLength(50)] string City,
        [Required][MaxLength(2)] string State,
        [Required][MaxLength(10)] string ZipCode,
        double Latitude = 0,
        double Longitude = 0,
        bool IsDefault = false
    );

    [HttpPost]
    public async Task<ActionResult<AddressDto>> CreateAddress([FromBody] CreateAddressRequest request)
    {
        try
        {
            var userId = GetUserId();

            // If this is set as default, unset other defaults
            if (request.IsDefault)
            {
                var existingDefaults = await _dbContext.Addresses
                    .Where(a => a.UserId == userId && a.IsDefault)
                    .ToListAsync();
                foreach (var addr in existingDefaults)
                {
                    addr.IsDefault = false;
                }
            }

            var address = new AddressEntity
            {
                Id = Guid.NewGuid().ToString(),
                UserId = userId,
                Label = request.Label,
                Street = request.Street,
                Number = request.Number,
                Complement = request.Complement ?? "",
                Neighborhood = request.Neighborhood,
                City = request.City,
                State = request.State.ToUpper(),
                ZipCode = request.ZipCode,
                Latitude = request.Latitude,
                Longitude = request.Longitude,
                IsDefault = request.IsDefault
            };

            _dbContext.Addresses.Add(address);
            await _dbContext.SaveChangesAsync();

            var addressDto = new AddressDto(
                address.Id, address.Label, address.Street, address.Number, address.Complement,
                address.Neighborhood, address.City, address.State, address.ZipCode,
                address.Latitude, address.Longitude, address.IsDefault
            );

            return CreatedAtAction(nameof(GetAddress), new { id = address.Id }, addressDto);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    public record UpdateAddressRequest(
        [MaxLength(50)] string? Label,
        [MaxLength(100)] string? Street,
        [MaxLength(20)] string? Number,
        [MaxLength(50)] string? Complement,
        [MaxLength(50)] string? Neighborhood,
        [MaxLength(50)] string? City,
        [MaxLength(2)] string? State,
        [MaxLength(10)] string? ZipCode,
        double? Latitude,
        double? Longitude,
        bool? IsDefault
    );

    [HttpPut("{id}")]
    public async Task<ActionResult<AddressDto>> UpdateAddress(string id, [FromBody] UpdateAddressRequest request)
    {
        try
        {
            var userId = GetUserId();

            var address = await _dbContext.Addresses
                .FirstOrDefaultAsync(a => a.Id == id && a.UserId == userId);

            if (address == null)
            {
                return NotFound("Endereço não encontrado");
            }

            // If setting as default, unset other defaults
            if (request.IsDefault == true)
            {
                var existingDefaults = await _dbContext.Addresses
                    .Where(a => a.UserId == userId && a.IsDefault && a.Id != id)
                    .ToListAsync();
                foreach (var addr in existingDefaults)
                {
                    addr.IsDefault = false;
                }
            }

            if (request.Label != null) address.Label = request.Label;
            if (request.Street != null) address.Street = request.Street;
            if (request.Number != null) address.Number = request.Number;
            if (request.Complement != null) address.Complement = request.Complement;
            if (request.Neighborhood != null) address.Neighborhood = request.Neighborhood;
            if (request.City != null) address.City = request.City;
            if (request.State != null) address.State = request.State.ToUpper();
            if (request.ZipCode != null) address.ZipCode = request.ZipCode;
            if (request.Latitude.HasValue) address.Latitude = request.Latitude.Value;
            if (request.Longitude.HasValue) address.Longitude = request.Longitude.Value;
            if (request.IsDefault.HasValue) address.IsDefault = request.IsDefault.Value;

            await _dbContext.SaveChangesAsync();

            var addressDto = new AddressDto(
                address.Id, address.Label, address.Street, address.Number, address.Complement,
                address.Neighborhood, address.City, address.State, address.ZipCode,
                address.Latitude, address.Longitude, address.IsDefault
            );

            return Ok(addressDto);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpDelete("{id}")]
    public async Task<ActionResult> DeleteAddress(string id)
    {
        try
        {
            var userId = GetUserId();

            var address = await _dbContext.Addresses
                .FirstOrDefaultAsync(a => a.Id == id && a.UserId == userId);

            if (address == null)
            {
                return NotFound("Endereço não encontrado");
            }

            _dbContext.Addresses.Remove(address);
            await _dbContext.SaveChangesAsync();
            return Ok(new { success = true, message = "Endereço removido com sucesso" });
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpPost("{id}/set-default")]
    public async Task<ActionResult> SetDefaultAddress(string id)
    {
        try
        {
            var userId = GetUserId();

            var address = await _dbContext.Addresses
                .FirstOrDefaultAsync(a => a.Id == id && a.UserId == userId);

            if (address == null)
            {
                return NotFound("Endereço não encontrado");
            }

            // Unset all defaults
            var existingDefaults = await _dbContext.Addresses
                .Where(a => a.UserId == userId && a.IsDefault)
                .ToListAsync();
            foreach (var addr in existingDefaults)
            {
                addr.IsDefault = false;
            }

            address.IsDefault = true;
            await _dbContext.SaveChangesAsync();

            return Ok(new { success = true, message = "Endereço padrão atualizado" });
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }
}