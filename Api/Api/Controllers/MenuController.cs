namespace PizzariaDesktop.Api.Controllers;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PizzariaDesktop.Api.DTOs;
using PizzariaDesktop.Data;
using PizzariaDesktop.Models;

[ApiController]
[Route("api/v1/menu")]
[Authorize]
public class MenuController : ControllerBase
{
    private readonly PizzariaDbContext _dbContext;

    public MenuController(PizzariaDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    [HttpGet]
    public async Task<ActionResult<MenuResponse>> GetMenu()
    {
        try
        {
            var categories = await _dbContext.Categories
                .OrderBy(c => c.SortOrder)
                .Select(c => new CategoryDto(c.Id, c.Name, c.DisplayName, c.SortOrder))
                .ToListAsync();

            var products = await _dbContext.Products
                .Include(p => p.Category)
                .Include(p => p.Customizations.OrderBy(co => co.SortOrder))
                    .ThenInclude(co => co.Choices.OrderBy(c => c.SortOrder))
                .Where(p => p.IsAvailable)
                .Select(p => new ProductDto(
                    p.Id,
                    p.Name,
                    p.Description,
                    p.ImageUrl,
                    (decimal)p.Price,
                    p.CategoryId,
                    p.Category.Name,
                    p.Category.DisplayName,
                    p.PrepTimeMinutes,
                    p.IsAvailable,
                    p.Customizations.Select(co => new CustomizationOptionDto(
                        co.Id,
                        co.Name,
                        co.IsRequired,
                        co.AllowMultiple,
                        co.SortOrder,
                        co.Choices.Select(c => new CustomizationChoiceDto(
                            c.Id, c.Name, (decimal)c.AdditionalPrice, c.SortOrder)).ToList()
                    )).ToList()
                ))
                .ToListAsync();

            return Ok(new MenuResponse(categories, products));
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpGet("categories")]
    public async Task<ActionResult<List<CategoryDto>>> GetCategories()
    {
        try
        {
            var categories = await _dbContext.Categories
                .OrderBy(c => c.SortOrder)
                .Select(c => new CategoryDto(c.Id, c.Name, c.DisplayName, c.SortOrder))
                .ToListAsync();

            return Ok(categories);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpGet("products")]
    public async Task<ActionResult<List<ProductDto>>> GetProducts([FromQuery] int? categoryId = null)
    {
        try
        {
            var query = _dbContext.Products
                .Include(p => p.Category)
                .Include(p => p.Customizations.OrderBy(co => co.SortOrder))
                    .ThenInclude(co => co.Choices.OrderBy(c => c.SortOrder))
                .Where(p => p.IsAvailable);

            if (categoryId.HasValue)
            {
                query = query.Where(p => p.CategoryId == categoryId.Value);
            }

            var products = await query
                .Select(p => new ProductDto(
                    p.Id,
                    p.Name,
                    p.Description,
                    p.ImageUrl,
                    (decimal)p.Price,
                    p.CategoryId,
                    p.Category.Name,
                    p.Category.DisplayName,
                    p.PrepTimeMinutes,
                    p.IsAvailable,
                    p.Customizations.Select(co => new CustomizationOptionDto(
                        co.Id,
                        co.Name,
                        co.IsRequired,
                        co.AllowMultiple,
                        co.SortOrder,
                        co.Choices.Select(c => new CustomizationChoiceDto(
                            c.Id, c.Name, (decimal)c.AdditionalPrice, c.SortOrder)).ToList()
                    )).ToList()
                ))
                .ToListAsync();

            return Ok(products);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpGet("products/{id}")]
    public async Task<ActionResult<ProductDto>> GetProduct(string id)
    {
        try
        {
            var product = await _dbContext.Products
                .Include(p => p.Category)
                .Include(p => p.Customizations.OrderBy(co => co.SortOrder))
                    .ThenInclude(co => co.Choices.OrderBy(c => c.SortOrder))
                .FirstOrDefaultAsync(p => p.Id == id && p.IsAvailable);

            if (product == null)
            {
                return NotFound("Produto não encontrado");
            }

            var productDto = new ProductDto(
                product.Id,
                product.Name,
                product.Description,
                product.ImageUrl,
                (decimal)product.Price,
                product.CategoryId,
                product.Category.Name,
                product.Category.DisplayName,
                product.PrepTimeMinutes,
                product.IsAvailable,
                product.Customizations.Select(co => new CustomizationOptionDto(
                    co.Id,
                    co.Name,
                    co.IsRequired,
                    co.AllowMultiple,
                    co.SortOrder,
                    co.Choices.Select(c => new CustomizationChoiceDto(
                        c.Id, c.Name, (decimal)c.AdditionalPrice, c.SortOrder)).ToList()
                )).ToList()
            );

            return Ok(productDto);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }
}