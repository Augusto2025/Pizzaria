namespace PizzariaDesktop.Data.Repositories;

using Microsoft.EntityFrameworkCore;
using PizzariaDesktop.Data.Entities;
using PizzariaDesktop.Models;
using BCrypt.Net;
using System.Text.Json;

public class UserRepository : IUserRepository
{
    private readonly PizzariaDbContext _context;

    public UserRepository(PizzariaDbContext context)
    {
        _context = context;
    }

    public async Task<User?> GetByIdAsync(string id)
    {
        var entity = await _context.Users.FindAsync(id);
        return entity?.ToModel();
    }

    public async Task<User?> GetByEmailAsync(string email)
    {
        var entity = await _context.Users
            .AsNoTracking()
            .FirstOrDefaultAsync(u => EF.Functions.ILike(u.Email, email));
        return entity?.ToModel();
    }

    public async Task<User?> GetByEmailWithAddressesAsync(string email)
    {
        var entity = await _context.Users
            .Include(u => u.Addresses)
            .AsNoTracking()
            .FirstOrDefaultAsync(u => EF.Functions.ILike(u.Email, email));
        return entity?.ToModel();
    }

    public async Task<User> CreateAsync(User user, string passwordHash)
    {
        var entity = UserEntity.FromModel(user, passwordHash);
        _context.Users.Add(entity);
        try
        {
            await _context.SaveChangesAsync();
            return entity.ToModel();
        }
        catch (DbUpdateException ex)
        {
            // Log the full inner exception details
            var innerMessage = ex.InnerException?.Message ?? "No inner exception";
            var innerStackTrace = ex.InnerException?.StackTrace ?? "No stack trace";

            Console.WriteLine($"=== DB UPDATE ERROR ===");
            Console.WriteLine($"Message: {ex.Message}");
            Console.WriteLine($"Inner Exception: {innerMessage}");
            Console.WriteLine($"Inner StackTrace: {innerStackTrace}");
            Console.WriteLine($"Entity: {entity.Email}, Name: {entity.Name}");
            Console.WriteLine($"=======================");

            throw; // Re-throw to preserve original behavior
        }
    }

    public async Task<bool> UpdateAsync(User user)
    {
        var entity = await _context.Users.FindAsync(user.Id);
        if (entity == null) return false;

        entity.Name = user.Name;
        entity.Phone = user.Phone;
        // Email e PasswordHash não devem ser atualizados aqui

        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> DeleteAsync(string id)
    {
        var entity = await _context.Users.FindAsync(id);
        if (entity == null) return false;

        _context.Users.Remove(entity);
        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> ExistsAsync(string email)
    {
        return await _context.Users.AnyAsync(u => EF.Functions.ILike(u.Email, email));
    }

    public async Task<bool> VerifyPasswordAsync(string email, string password)
    {
        Console.WriteLine($"=== LOGIN ATTEMPT ===");
        Console.WriteLine($"Email input: {email}");
        Console.WriteLine($"Password length: {password?.Length ?? 0}");

        var entity = await _context.Users
            .AsNoTracking()
            .FirstOrDefaultAsync(u => EF.Functions.ILike(u.Email, email));

        Console.WriteLine($"Entity found: {entity != null}");
        if (entity != null)
        {
            Console.WriteLine($"Entity email: {entity.Email}");
            Console.WriteLine($"PasswordHash length: {entity.PasswordHash?.Length ?? 0}");
        }

        if (entity == null) return false;

        var result = BCrypt.Verify(password, entity.PasswordHash);
        Console.WriteLine($"Password verification result: {result}");
        return result;
    }
}

public class AddressRepository : IAddressRepository
{
    private readonly PizzariaDbContext _context;

    public AddressRepository(PizzariaDbContext context)
    {
        _context = context;
    }

    public async Task<List<Address>> GetByUserIdAsync(string userId)
    {
        return await _context.Addresses
            .AsNoTracking()
            .Where(a => a.UserId == userId)
            .Select(a => a.ToModel())
            .ToListAsync();
    }

    public async Task<Address?> GetByIdAsync(string id)
    {
        var entity = await _context.Addresses
            .AsNoTracking()
            .FirstOrDefaultAsync(a => a.Id == id);
        return entity?.ToModel();
    }

    public async Task<Address> CreateAsync(Address address, string userId)
    {
        var entity = AddressEntity.FromModel(address, userId);
        _context.Addresses.Add(entity);
        await _context.SaveChangesAsync();
        return entity.ToModel();
    }

    public async Task<bool> UpdateAsync(Address address)
    {
        var entity = await _context.Addresses.FindAsync(address.Id);
        if (entity == null) return false;

        entity.Label = address.Label;
        entity.Street = address.Street;
        entity.Number = address.Number;
        entity.Complement = address.Complement;
        entity.Neighborhood = address.Neighborhood;
        entity.City = address.City;
        entity.State = address.State;
        entity.ZipCode = address.ZipCode;
        entity.Latitude = address.Latitude;
        entity.Longitude = address.Longitude;
        entity.IsDefault = address.IsDefault;

        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> DeleteAsync(string id)
    {
        var entity = await _context.Addresses.FindAsync(id);
        if (entity == null) return false;

        _context.Addresses.Remove(entity);
        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> SetDefaultAsync(string userId, string addressId)
    {
        var addresses = await _context.Addresses
            .Where(a => a.UserId == userId)
            .ToListAsync();

        foreach (var addr in addresses)
        {
            addr.IsDefault = addr.Id == addressId;
        }

        await _context.SaveChangesAsync();
        return true;
    }
}

public class ProductRepository : IProductRepository
{
    private readonly PizzariaDbContext _context;

    public ProductRepository(PizzariaDbContext context)
    {
        _context = context;
    }

    public async Task<List<Product>> GetAllAsync()
    {
        return await _context.Products
            .AsNoTracking()
            .Where(p => p.IsAvailable)
            .Include(p => p.Customizations)
                .ThenInclude(c => c.Choices)
            .Select(p => p.ToModel())
            .ToListAsync();
    }

    public async Task<List<Product>> GetByCategoryAsync(Category category)
    {
        var categoryId = (int)category + 1;
        return await _context.Products
            .AsNoTracking()
            .Where(p => p.IsAvailable && p.CategoryId == categoryId)
            .Include(p => p.Customizations)
                .ThenInclude(c => c.Choices)
            .Select(p => p.ToModel())
            .ToListAsync();
    }

    public async Task<Product?> GetByIdAsync(string id)
    {
        var entity = await _context.Products
            .AsNoTracking()
            .Include(p => p.Customizations)
                .ThenInclude(c => c.Choices)
            .FirstOrDefaultAsync(p => p.Id == id);

        return entity?.ToModel();
    }

    public async Task<Product> CreateAsync(Product product)
    {
        var entity = ProductEntity.FromModel(product);
        _context.Products.Add(entity);
        await _context.SaveChangesAsync();
        return entity.ToModel();
    }

    public async Task<bool> UpdateAsync(Product product)
    {
        var entity = await _context.Products
            .Include(p => p.Customizations)
            .FirstOrDefaultAsync(p => p.Id == product.Id);

        if (entity == null) return false;

        entity.Name = product.Name;
        entity.Description = product.Description;
        entity.ImageUrl = product.ImageUrl;
        entity.Price = product.Price;
        entity.CategoryId = (int)product.Category + 1;
        entity.PrepTimeMinutes = product.PrepTimeMinutes;
        entity.IsAvailable = product.IsAvailable;

        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> DeleteAsync(string id)
    {
        var entity = await _context.Products.FindAsync(id);
        if (entity == null) return false;

        _context.Products.Remove(entity);
        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<List<CustomizationOption>> GetCustomizationsAsync(string productId)
    {
        return await _context.CustomizationOptions
            .AsNoTracking()
            .Where(c => c.ProductId == productId)
            .Include(c => c.Choices)
            .Select(c => c.ToModel())
            .ToListAsync();
    }
}

public class CartRepository : ICartRepository
{
    private readonly PizzariaDbContext _context;

    public CartRepository(PizzariaDbContext context)
    {
        _context = context;
    }

    public async Task<List<CartItem>> GetByUserIdAsync(string userId)
    {
        var entities = await _context.CartItems
            .AsNoTracking()
            .Where(c => c.UserId == userId)
            .Include(c => c.Product)
            .ToListAsync();

        var result = new List<CartItem>();
        foreach (var entity in entities)
        {
            var product = entity.Product?.ToModel();
            if (product != null)
            {
                result.Add(entity.ToModel(product));
            }
        }
        return result;
    }

    public async Task<CartItem?> GetByIdAsync(string id)
    {
        var entity = await _context.CartItems
            .AsNoTracking()
            .Include(c => c.Product)
            .FirstOrDefaultAsync(c => c.Id == id);

        if (entity?.Product == null) return null;
        return entity.ToModel(entity.Product.ToModel());
    }

    public async Task<CartItem> AddAsync(CartItem cartItem, string userId)
    {
        // Verifica se já existe o mesmo produto no carrinho
        var existing = await _context.CartItems
            .FirstOrDefaultAsync(c => c.UserId == userId && c.ProductId == cartItem.Product.Id);

        if (existing != null)
        {
            existing.Quantity += cartItem.Quantity;
            existing.Notes = cartItem.Notes;
            existing.SelectedCustomizationsJson = JsonSerializer.Serialize(cartItem.SelectedCustomizations);
            await _context.SaveChangesAsync();
            return existing.ToModel(existing.Product!.ToModel());
        }

        var entity = CartItemEntity.FromModel(cartItem, userId);
        _context.CartItems.Add(entity);
        await _context.SaveChangesAsync();

        // Carrega o produto para retornar o model completo
        var product = await _context.Products.FindAsync(cartItem.Product.Id);
        return entity.ToModel(product!.ToModel());
    }

    public async Task<bool> UpdateAsync(CartItem cartItem)
    {
        var entity = await _context.CartItems.FindAsync(cartItem.Id);
        if (entity == null) return false;

        entity.Quantity = cartItem.Quantity;
        entity.Notes = cartItem.Notes;
        entity.SelectedCustomizationsJson = JsonSerializer.Serialize(cartItem.SelectedCustomizations);

        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> RemoveAsync(string id)
    {
        var entity = await _context.CartItems.FindAsync(id);
        if (entity == null) return false;

        _context.CartItems.Remove(entity);
        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> ClearAsync(string userId)
    {
        var entities = await _context.CartItems
            .Where(c => c.UserId == userId)
            .ToListAsync();

        _context.CartItems.RemoveRange(entities);
        await _context.SaveChangesAsync();
        return true;
    }
}

public class OrderRepository : IOrderRepository
{
    private readonly PizzariaDbContext _context;

    public OrderRepository(PizzariaDbContext context)
    {
        _context = context;
    }

    public async Task<List<Order>> GetByUserIdAsync(string userId)
    {
        return await _context.Orders
            .AsNoTracking()
            .Where(o => o.UserId == userId)
            .Include(o => o.Items)
                .ThenInclude(i => i.Product)
            .Include(o => o.DeliveryAddress)
            .Include(o => o.Timeline)
            .OrderByDescending(o => o.CreatedAt)
            .Select(o => o.ToModel())
            .ToListAsync();
    }

    public async Task<Order?> GetByIdAsync(string id)
    {
        var entity = await _context.Orders
            .AsNoTracking()
            .Include(o => o.Items)
                .ThenInclude(i => i.Product)
            .Include(o => o.DeliveryAddress)
            .Include(o => o.Timeline)
            .FirstOrDefaultAsync(o => o.Id == id);

        return entity?.ToModel();
    }

    public async Task<Order> CreateAsync(Order order)
    {
        var entity = OrderEntity.FromModel(order);
        _context.Orders.Add(entity);
        await _context.SaveChangesAsync();
        return entity.ToModel();
    }

    public async Task<bool> UpdateAsync(Order order)
    {
        var entity = await _context.Orders
            .Include(o => o.Items)
            .Include(o => o.Timeline)
            .FirstOrDefaultAsync(o => o.Id == order.Id);

        if (entity == null) return false;

        entity.Status = (int)order.Status;
        entity.DeliveryFee = order.DeliveryFee;
        entity.Notes = order.Notes;
        entity.EstimatedDeliveryTime = order.EstimatedDeliveryTime;

        // Atualiza timeline se mudou o status
        if (entity.Status != (int)order.Status)
        {
            entity.Timeline.Add(new OrderStatusTimelineEntity
            {
                OrderId = order.Id,
                Status = (int)order.Status,
                Timestamp = DateTime.UtcNow,
                Note = $"Status alterado para {order.Status}"
            });
        }

        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> UpdateStatusAsync(string orderId, OrderStatus status, string? note = null)
    {
        var entity = await _context.Orders.FindAsync(orderId);
        if (entity == null) return false;

        entity.Status = (int)status;
        entity.Timeline.Add(new OrderStatusTimelineEntity
        {
            OrderId = orderId,
            Status = (int)status,
            Timestamp = DateTime.UtcNow,
            Note = note ?? $"Status alterado para {status}"
        });

        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<List<Order>> GetAllAsync()
    {
        return await _context.Orders
            .AsNoTracking()
            .Include(o => o.Items)
                .ThenInclude(i => i.Product)
            .Include(o => o.DeliveryAddress)
            .Include(o => o.Timeline)
            .OrderByDescending(o => o.CreatedAt)
            .Select(o => o.ToModel())
            .ToListAsync();
    }
}

public class CategoryRepository : ICategoryRepository
{
    public Task<List<Category>> GetAllAsync()
    {
        var categories = Enum.GetValues<Category>().ToList();
        return Task.FromResult(categories);
    }
}