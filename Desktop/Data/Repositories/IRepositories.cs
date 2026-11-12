namespace PizzariaDesktop.Data.Repositories;

using PizzariaDesktop.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

public interface IUserRepository
{
    Task<User?> GetByIdAsync(string id);
    Task<User?> GetByEmailAsync(string email);
    Task<User?> GetByEmailWithAddressesAsync(string email);
    Task<User> CreateAsync(User user, string passwordHash);
    Task<bool> UpdateAsync(User user);
    Task<bool> DeleteAsync(string id);
    Task<bool> ExistsAsync(string email);
    Task<bool> VerifyPasswordAsync(string email, string password);
}

public interface IAddressRepository
{
    Task<List<Address>> GetByUserIdAsync(string userId);
    Task<Address?> GetByIdAsync(string id);
    Task<Address> CreateAsync(Address address, string userId);
    Task<bool> UpdateAsync(Address address);
    Task<bool> DeleteAsync(string id);
    Task<bool> SetDefaultAsync(string userId, string addressId);
}

public interface IProductRepository
{
    Task<List<Product>> GetAllAsync();
    Task<List<Product>> GetByCategoryAsync(Category category);
    Task<Product?> GetByIdAsync(string id);
    Task<Product> CreateAsync(Product product);
    Task<bool> UpdateAsync(Product product);
    Task<bool> DeleteAsync(string id);
    Task<List<CustomizationOption>> GetCustomizationsAsync(string productId);
}

public interface ICartRepository
{
    Task<List<CartItem>> GetByUserIdAsync(string userId);
    Task<CartItem?> GetByIdAsync(string id);
    Task<CartItem> AddAsync(CartItem cartItem, string userId);
    Task<bool> UpdateAsync(CartItem cartItem);
    Task<bool> RemoveAsync(string id);
    Task<bool> ClearAsync(string userId);
}

public interface IOrderRepository
{
    Task<List<Order>> GetByUserIdAsync(string userId);
    Task<Order?> GetByIdAsync(string id);
    Task<Order> CreateAsync(Order order);
    Task<bool> UpdateAsync(Order order);
    Task<bool> UpdateStatusAsync(string orderId, OrderStatus status, string? note = null);
    Task<List<Order>> GetAllAsync(); // Para admin
}

public interface ICategoryRepository
{
    Task<List<Category>> GetAllAsync();
}