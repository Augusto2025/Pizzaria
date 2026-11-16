namespace PizzariaDesktop.Api.Controllers;

using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PizzariaDesktop.Api.DTOs;
using PizzariaDesktop.Data;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data.Entities;

[ApiController]
[Route("api/v1/cart")]
[Authorize]
public class CartController : ControllerBase
{
    private readonly PizzariaDbContext _dbContext;

    public CartController(PizzariaDbContext dbContext)
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
    public async Task<ActionResult<CartDto>> GetCart()
    {
        try
        {
            var userId = GetUserId();

            var cartItems = await _dbContext.CartItems
                .Include(ci => ci.Product)
                    .ThenInclude(p => p.Category)
                .Where(ci => ci.UserId == userId)
                .ToListAsync();

            var items = cartItems.Select(ci => new CartItemDto(
                ci.Id,
                ci.ProductId,
                ci.Product.Name,
                ci.Product.Description,
                ci.Product.ImageUrl,
                ci.Product.Price,
                ci.Quantity,
                ci.SelectedCustomizationsJson != null
                    ? System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, string>>(ci.SelectedCustomizationsJson) ?? new()
                    : new(),
                ci.Notes
            )).ToList();

            var subtotal = items.Sum(i => i.ProductPrice * i.Quantity);
            var deliveryFee = 5.00m;
            var total = subtotal + deliveryFee;

            return Ok(new CartDto(items, subtotal, deliveryFee, total));
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpPost("items")]
    public async Task<ActionResult<CartItemDto>> AddToCart([FromBody] AddToCartRequest request)
    {
        try
        {
            var userId = GetUserId();

            var product = await _dbContext.Products.FindAsync(request.ProductId);
            if (product == null || !product.IsAvailable)
            {
                return NotFound("Produto não encontrado ou indisponível");
            }

            var existingItem = await _dbContext.CartItems
                .FirstOrDefaultAsync(ci => ci.UserId == userId && ci.ProductId == request.ProductId);

            if (existingItem != null)
            {
                existingItem.Quantity += request.Quantity;
                if (request.SelectedCustomizations != null)
                {
                    existingItem.SelectedCustomizationsJson = System.Text.Json.JsonSerializer.Serialize(request.SelectedCustomizations);
                }
                if (!string.IsNullOrEmpty(request.Notes))
                {
                    existingItem.Notes = request.Notes;
                }
            }
            else
            {
                var cartItem = new CartItemEntity
                {
                    Id = Guid.NewGuid().ToString(),
                    UserId = userId,
                    ProductId = request.ProductId,
                    Quantity = request.Quantity,
                    SelectedCustomizationsJson = request.SelectedCustomizations != null
                        ? System.Text.Json.JsonSerializer.Serialize(request.SelectedCustomizations)
                        : "{}",
                    Notes = request.Notes ?? "",
                    CreatedAt = DateTime.UtcNow
                };
                _dbContext.CartItems.Add(cartItem);
            }

            await _dbContext.SaveChangesAsync();

            // Return updated cart
            return await GetCart();
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpPut("items/{itemId}")]
    public async Task<ActionResult<CartDto>> UpdateCartItem(string itemId, [FromBody] UpdateCartItemRequest request)
    {
        try
        {
            var userId = GetUserId();

            var cartItem = await _dbContext.CartItems
                .FirstOrDefaultAsync(ci => ci.Id == itemId && ci.UserId == userId);

            if (cartItem == null)
            {
                return NotFound("Item não encontrado no carrinho");
            }

            if (request.Quantity <= 0)
            {
                _dbContext.CartItems.Remove(cartItem);
            }
            else
            {
                cartItem.Quantity = request.Quantity;
            }

            await _dbContext.SaveChangesAsync();
            return await GetCart();
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpDelete("items/{itemId}")]
    public async Task<ActionResult<CartDto>> RemoveFromCart(string itemId)
    {
        try
        {
            var userId = GetUserId();

            var cartItem = await _dbContext.CartItems
                .FirstOrDefaultAsync(ci => ci.Id == itemId && ci.UserId == userId);

            if (cartItem == null)
            {
                return NotFound("Item não encontrado no carrinho");
            }

            _dbContext.CartItems.Remove(cartItem);
            await _dbContext.SaveChangesAsync();
            return await GetCart();
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpDelete]
    public async Task<ActionResult<CartDto>> ClearCart()
    {
        try
        {
            var userId = GetUserId();

            var cartItems = await _dbContext.CartItems
                .Where(ci => ci.UserId == userId)
                .ToListAsync();

            _dbContext.CartItems.RemoveRange(cartItems);
            await _dbContext.SaveChangesAsync();
            return await GetCart();
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpPost("checkout")]
    public async Task<ActionResult<OrderDto>> Checkout([FromBody] CheckoutRequest request)
    {
        try
        {
            var userId = GetUserId();

            var cartItems = await _dbContext.CartItems
                .Include(ci => ci.Product)
                    .ThenInclude(p => p.Category)
                .Where(ci => ci.UserId == userId)
                .ToListAsync();

            if (!cartItems.Any())
            {
                return BadRequest("Carrinho vazio");
            }

            var address = await _dbContext.Addresses
                .FirstOrDefaultAsync(a => a.Id == request.DeliveryAddressId && a.UserId == userId);

            if (address == null)
            {
                return BadRequest("Endereço de entrega inválido");
            }

            var now = DateTime.UtcNow;
            var maxPrepTime = cartItems.Max(ci => ci.Product.PrepTimeMinutes);
            var estimatedDelivery = now.AddMinutes(maxPrepTime + 15);

            var subtotal = cartItems.Sum(ci => ci.Product.Price * ci.Quantity);
            var deliveryFee = 5.00m;

            var order = new OrderEntity
            {
                Id = $"ord-{now:yyyyMMddHHmmss}-{Guid.NewGuid().ToString()[..4]}",
                UserId = userId,
                DeliveryAddressId = request.DeliveryAddressId,
                PaymentMethod = request.PaymentMethod,
                Status = (int)OrderStatus.Confirmed,
                Subtotal = subtotal,
                DeliveryFee = deliveryFee,
                Notes = request.Notes ?? "",
                CreatedAt = now,
                EstimatedDeliveryTime = estimatedDelivery
            };

            foreach (var cartItem in cartItems)
            {
                var orderItem = new OrderItemEntity
                {
                    Id = Guid.NewGuid().ToString(),
                    OrderId = order.Id,
                    ProductId = cartItem.ProductId,
                    Quantity = cartItem.Quantity,
                    UnitPrice = cartItem.Product.Price,
                    CustomizationsJson = cartItem.SelectedCustomizationsJson ?? "{}",
                    Notes = cartItem.Notes ?? ""
                };
                order.Items.Add(orderItem);
            }

            order.Timeline.Add(new OrderStatusTimelineEntity
            {
                OrderId = order.Id,
                Status = (int)OrderStatus.Pending,
                Timestamp = now,
                Note = "Pedido recebido"
            });
            order.Timeline.Add(new OrderStatusTimelineEntity
            {
                OrderId = order.Id,
                Status = (int)OrderStatus.Confirmed,
                Timestamp = now.AddMinutes(1),
                Note = "Pagamento aprovado ✅"
            });
            order.Timeline.Add(new OrderStatusTimelineEntity
            {
                OrderId = order.Id,
                Status = (int)OrderStatus.Preparing,
                Timestamp = now.AddMinutes(3),
                Note = "Iniciando preparação"
            });

            _dbContext.Orders.Add(order);
            _dbContext.CartItems.RemoveRange(cartItems);
            await _dbContext.SaveChangesAsync();

            // Return created order
            var orderDto = MapOrderToDto(order, address);
            return CreatedAtAction(nameof(GetOrder), new { id = order.Id }, orderDto);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro interno: {ex.Message}");
        }
    }

    [HttpGet("orders/{id}")]
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
            order.Subtotal,
            order.DeliveryFee,
            order.Subtotal + order.DeliveryFee,
            order.Notes,
            order.EstimatedDeliveryTime,
            order.Items.Select(oi => new OrderItemDto(
                oi.Id,
                oi.ProductId,
                oi.Product?.Name ?? "Produto",
                oi.Product?.ImageUrl ?? "",
                oi.Quantity,
                oi.UnitPrice,
                oi.CustomizationsJson != null
                    ? System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, string>>(oi.CustomizationsJson) ?? new()
                    : new(),
                oi.Notes,
                oi.UnitPrice * oi.Quantity
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