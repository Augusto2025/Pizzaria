namespace PizzariaDesktop.Models;

public enum Category
{
    Pizza,
    Drink,
    Dessert,
    Side
}

public enum OrderStatus
{
    Pending,
    Confirmed,
    Preparing,
    Baking,
    Ready,
    OutForDelivery,
    Delivered,
    Cancelled
}

public enum PaymentMethod
{
    Cash,
    Card,
    Pix,
    Wallet
}