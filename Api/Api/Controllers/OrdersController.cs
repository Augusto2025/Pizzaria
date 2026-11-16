namespace PizzariaDesktop.Api.Controllers;

using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PizzariaDesktop.Api.DTOs;
using PizzariaDesktop.Data;
using PizzariaDesktop.Data.Entities;
using PizzariaDesktop.Models;

[ApiController]
[Route("api/v1/orders")]
[Authorize]
public class OrdersController : ControllerBase
{
    private readonly PizzariaDbContext _dbContext;

    public OrdersController(PizzariaDbContext dbContext)
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
    public async Task<ActionResult<OrdersResponse>> GetOrders()
    {
        try
        {
            var userId = GetUserId();

            var orders = await _dbContext.Orders
                .Include(o => o.Items)
                    .ThenInclude(oi => oi.Product)
                .Include(o => o.DeliveryAddress)
                .Include(o => o.Timeline)
                .Where(o => o.UserId == userId)
                .OrderByDescending(o => o.CreatedAt)
                .ToListAsync();

            var orderDtos = orders.Select(o => MapOrderToDto(o, o.DeliveryAddress)).ToList();

            return Ok(new OrdersResponse(orderDtos));
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<OrderDto>> GetOrder(string id)
    {
        try
        {
            var userId = GetUserId();

            var order = await _dbContext.Orders
                .Include(o => o.Items)
                    .ThenInclude(oi => oi.Product)
                .Include(o => o.DeliveryAddress)
                .Include(o => o.Timeline)
                .FirstOrDefaultAsync(o => o.Id == id && o.UserId == userId);

            if (order == null)
            {
                return NotFound("Pedido não encontrado");
            }

            var orderDto = MapOrderToDto(order, order.DeliveryAddress);
            return Ok(orderDto);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpPost("{id}/cancel")]
    public async Task<ActionResult> CancelOrder(string id)
    {
        try
        {
            var userId = GetUserId();

            var order = await _dbContext.Orders
                .FirstOrDefaultAsync(o => o.Id == id && o.UserId == userId);

            if (order == null)
            {
                return NotFound("Pedido não encontrado");
            }

            if (order.Status >= (int)OrderStatus.OutForDelivery)
            {
                return BadRequest("Não é possível cancelar pedido que já saiu para entrega");
            }

            order.Status = (int)OrderStatus.Cancelled;
            order.Timeline.Add(new OrderStatusTimelineEntity
            {
                OrderId = order.Id,
                Status = (int)OrderStatus.Cancelled,
                Timestamp = DateTime.UtcNow,
                Note = "Pedido cancelado pelo cliente"
            });

            await _dbContext.SaveChangesAsync();
            return Ok(new { success = true, message = "Pedido cancelado com sucesso" });
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpPost("{id}/reorder")]
    public async Task<ActionResult> Reorder(string id)
    {
        try
        {
            var userId = GetUserId();

            var order = await _dbContext.Orders
                .Include(o => o.Items)
                .FirstOrDefaultAsync(o => o.Id == id && o.UserId == userId);

            if (order == null)
            {
                return NotFound("Pedido não encontrado");
            }

            foreach (var item in order.Items)
            {
                var existingCartItem = await _dbContext.CartItems
                    .FirstOrDefaultAsync(ci => ci.UserId == userId && ci.ProductId == item.ProductId);

                if (existingCartItem != null)
                {
                    existingCartItem.Quantity += item.Quantity;
                }
                else
                {
                    var cartItem = new CartItemEntity
                    {
                        Id = Guid.NewGuid().ToString(),
                        UserId = userId,
                        ProductId = item.ProductId,
                        Quantity = item.Quantity,
                        SelectedCustomizationsJson = item.CustomizationsJson,
                        Notes = item.Notes,
                        CreatedAt = DateTime.UtcNow
                    };
                    _dbContext.CartItems.Add(cartItem);
                }
            }

            await _dbContext.SaveChangesAsync();
            return Ok(new { success = true, message = "Itens adicionados ao carrinho" });
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    private OrderDto MapOrderToDto(OrderEntity order, AddressEntity address)
    {
        return new OrderDto(
            order.Id,
            order.UserId,
            order.CreatedAt,
            new OrderStatusDto(order.Status, GetStatusLabel(order.Status), GetStatusColor(order.Status)),
            new AddressDto(
                address.Id, address.Label, address.Street, address.Number, address.Complement,
                address.Neighborhood, address.City, address.State, address.ZipCode,
                address.Latitude, address.Longitude, address.IsDefault
            ),
            order.PaymentMethod,
            (decimal)order.Subtotal,
            (decimal)order.DeliveryFee,
            (decimal)(order.Subtotal + order.DeliveryFee),
            order.Notes,
            order.EstimatedDeliveryTime,
            order.Items.Select(oi => new OrderItemDto(
                oi.Id,
                oi.ProductId,
                oi.Product?.Name ?? "Produto",
                oi.Product?.ImageUrl ?? "",
                oi.Quantity,
                (decimal)oi.UnitPrice,
                oi.CustomizationsJson != null
                    ? System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, string>>(oi.CustomizationsJson) ?? new()
                    : new(),
                oi.Notes,
                (decimal)oi.UnitPrice * oi.Quantity
            )).ToList(),
            order.Timeline.Select(t => new StatusTimelineDto(
                t.Id,
                new OrderStatusDto(t.Status, GetStatusLabel(t.Status), GetStatusColor(t.Status)),
                t.Timestamp,
                t.Note
            )).ToList()
        );
    }

    private static string GetStatusLabel(int status)
    {
        return status switch
        {
            0 => "Aguardando",
            1 => "Confirmado",
            2 => "Preparando",
            3 => "No Forno",
            4 => "Pronto",
            5 => "Saiu p/ Entrega",
            6 => "Entregue",
            7 => "Cancelado",
            _ => "Desconhecido"
        };
    }

    private static string GetStatusColor(int status)
    {
        return status switch
        {
            0 => "#FFC107",
            1 => "#17A2B8",
            2 => "#FD7E14",
            3 => "#E85D2E",
            4 => "#28A745",
            5 => "#6F42C1",
            6 => "#28A745",
            7 => "#DC3545",
            _ => "#666666"
        };
    }
}