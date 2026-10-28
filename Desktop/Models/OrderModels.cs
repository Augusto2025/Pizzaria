namespace PizzariaDesktop.Models;

using System.ComponentModel;
using System.Runtime.CompilerServices;

public class StatusTimeline : INotifyPropertyChanged
{
    public event PropertyChangedEventHandler? PropertyChanged;

    protected virtual void OnPropertyChanged([CallerMemberName] string? propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }

    private OrderStatus _status;
    public OrderStatus Status
    {
        get => _status;
        set
        {
            if (_status != value)
            {
                _status = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(StatusDisplayName));
            }
        }
    }

    private DateTime _timestamp;
    public DateTime Timestamp
    {
        get => _timestamp;
        set
        {
            if (_timestamp != value)
            {
                _timestamp = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(FormattedTime));
            }
        }
    }

    private string? _note;
    public string? Note
    {
        get => _note;
        set
        {
            if (_note != value)
            {
                _note = value;
                OnPropertyChanged();
            }
        }
    }

    public string FormattedTime => Timestamp.ToString("dd/MM/yyyy HH:mm");
    public string StatusDisplayName => Status switch
    {
        OrderStatus.Pending => "Aguardando confirmação",
        OrderStatus.Confirmed => "Confirmado pela pizzaria",
        OrderStatus.Preparing => "Em preparação",
        OrderStatus.Baking => "No forno",
        OrderStatus.Ready => "Pronto para retirada/entrega",
        OrderStatus.OutForDelivery => "Saiu para entrega",
        OrderStatus.Delivered => "Entregue",
        OrderStatus.Cancelled => "Cancelado",
        _ => Status.ToString()
    };
}

public class CartItem : INotifyPropertyChanged
{
    public event PropertyChangedEventHandler? PropertyChanged;

    protected virtual void OnPropertyChanged([CallerMemberName] string? propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }

    private string _id = Guid.NewGuid().ToString();
    public string Id
    {
        get => _id;
        set
        {
            if (_id != value)
            {
                _id = value;
                OnPropertyChanged();
            }
        }
    }

    private Product _product = new();
    public Product Product
    {
        get => _product;
        set
        {
            if (_product != value)
            {
                _product = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(TotalPrice));
                OnPropertyChanged(nameof(FormattedTotalPrice));
            }
        }
    }

    private int _quantity = 1;
    public int Quantity
    {
        get => _quantity;
        set
        {
            if (_quantity != value)
            {
                _quantity = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(TotalPrice));
                OnPropertyChanged(nameof(FormattedTotalPrice));
            }
        }
    }

    private Dictionary<string, string> _selectedCustomizations = new();
    public Dictionary<string, string> SelectedCustomizations
    {
        get => _selectedCustomizations;
        set
        {
            if (_selectedCustomizations != value)
            {
                _selectedCustomizations = value;
                OnPropertyChanged();
            }
        }
    }

    private string _notes = string.Empty;
    public string Notes
    {
        get => _notes;
        set
        {
            if (_notes != value)
            {
                _notes = value;
                OnPropertyChanged();
            }
        }
    }

    public double TotalPrice => Product.Price * Quantity;
    public string FormattedTotalPrice => $"R$ {TotalPrice:F2}";
}

public class OrderItem : INotifyPropertyChanged
{
    public event PropertyChangedEventHandler? PropertyChanged;

    protected virtual void OnPropertyChanged([CallerMemberName] string? propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }

    private string _id = Guid.NewGuid().ToString();
    public string Id
    {
        get => _id;
        set
        {
            if (_id != value)
            {
                _id = value;
                OnPropertyChanged();
            }
        }
    }

    private Product _product = new();
    public Product Product
    {
        get => _product;
        set
        {
            if (_product != value)
            {
                _product = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(TotalPrice));
                OnPropertyChanged(nameof(FormattedTotalPrice));
                OnPropertyChanged(nameof(FormattedUnitPrice));
            }
        }
    }

    private int _quantity;
    public int Quantity
    {
        get => _quantity;
        set
        {
            if (_quantity != value)
            {
                _quantity = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(TotalPrice));
                OnPropertyChanged(nameof(FormattedTotalPrice));
            }
        }
    }

    private Dictionary<string, string> _customizations = new();
    public Dictionary<string, string> Customizations
    {
        get => _customizations;
        set
        {
            if (_customizations != value)
            {
                _customizations = value;
                OnPropertyChanged();
            }
        }
    }

    private string _notes = string.Empty;
    public string Notes
    {
        get => _notes;
        set
        {
            if (_notes != value)
            {
                _notes = value;
                OnPropertyChanged();
            }
        }
    }

    private double _unitPrice;
    public double UnitPrice
    {
        get => _unitPrice;
        set
        {
            if (_unitPrice != value)
            {
                _unitPrice = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(TotalPrice));
                OnPropertyChanged(nameof(FormattedTotalPrice));
                OnPropertyChanged(nameof(FormattedUnitPrice));
            }
        }
    }

    public double TotalPrice => UnitPrice * Quantity;
    public string FormattedUnitPrice => $"R$ {UnitPrice:F2}";
    public string FormattedTotalPrice => $"R$ {TotalPrice:F2}";
}

public class Order : INotifyPropertyChanged
{
    public event PropertyChangedEventHandler? PropertyChanged;

    protected virtual void OnPropertyChanged([CallerMemberName] string? propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }

    private string _id = Guid.NewGuid().ToString();
    public string Id
    {
        get => _id;
        set
        {
            if (_id != value)
            {
                _id = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(ShortId));
            }
        }
    }

    private string _userId = string.Empty;
    public string UserId
    {
        get => _userId;
        set
        {
            if (_userId != value)
            {
                _userId = value;
                OnPropertyChanged();
            }
        }
    }

    private List<OrderItem> _items = new();
    public List<OrderItem> Items
    {
        get => _items;
        set
        {
            if (_items != value)
            {
                _items = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(Total));
                OnPropertyChanged(nameof(FormattedTotal));
            }
        }
    }

    private Address _deliveryAddress = new();
    public Address DeliveryAddress
    {
        get => _deliveryAddress;
        set
        {
            if (_deliveryAddress != value)
            {
                _deliveryAddress = value;
                OnPropertyChanged();
            }
        }
    }

    private PaymentMethod _paymentMethod;
    public PaymentMethod PaymentMethod
    {
        get => _paymentMethod;
        set
        {
            if (_paymentMethod != value)
            {
                _paymentMethod = value;
                OnPropertyChanged();
            }
        }
    }

    private OrderStatus _status;
    public OrderStatus Status
    {
        get => _status;
        set
        {
            if (_status != value)
            {
                _status = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(StatusDisplayName));
            }
        }
    }

    private double _subtotal;
    public double Subtotal
    {
        get => _subtotal;
        set
        {
            if (_subtotal != value)
            {
                _subtotal = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(FormattedSubtotal));
                OnPropertyChanged(nameof(Total));
                OnPropertyChanged(nameof(FormattedTotal));
            }
        }
    }

    private double _deliveryFee;
    public double DeliveryFee
    {
        get => _deliveryFee;
        set
        {
            if (_deliveryFee != value)
            {
                _deliveryFee = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(FormattedDeliveryFee));
                OnPropertyChanged(nameof(Total));
                OnPropertyChanged(nameof(FormattedTotal));
            }
        }
    }

    public double Total => Subtotal + DeliveryFee;

    private string _notes = string.Empty;
    public string Notes
    {
        get => _notes;
        set
        {
            if (_notes != value)
            {
                _notes = value;
                OnPropertyChanged();
            }
        }
    }

    private bool _isSelected;
    public bool IsSelected
    {
        get => _isSelected;
        set
        {
            if (_isSelected != value)
            {
                _isSelected = value;
                OnPropertyChanged();
            }
        }
    }

    private DateTime _createdAt = DateTime.Now;
    public DateTime CreatedAt
    {
        get => _createdAt;
        set
        {
            if (_createdAt != value)
            {
                _createdAt = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(FormattedCreatedAt));
            }
        }
    }

    private DateTime? _estimatedDeliveryTime;
    public DateTime? EstimatedDeliveryTime
    {
        get => _estimatedDeliveryTime;
        set
        {
            if (_estimatedDeliveryTime != value)
            {
                _estimatedDeliveryTime = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(FormattedEstimatedDelivery));
            }
        }
    }

    private List<StatusTimeline> _timeline = new();
    public List<StatusTimeline> Timeline
    {
        get => _timeline;
        set
        {
            if (_timeline != value)
            {
                _timeline = value;
                OnPropertyChanged();
            }
        }
    }

    public string FormattedSubtotal => $"R$ {Subtotal:F2}";
    public string FormattedDeliveryFee => $"R$ {DeliveryFee:F2}";
    public string FormattedTotal => $"R$ {Total:F2}";
    public string FormattedCreatedAt => CreatedAt.ToString("dd/MM/yyyy HH:mm");
    public string FormattedEstimatedDelivery => EstimatedDeliveryTime?.ToString("dd/MM/yyyy HH:mm") ?? "--";
    public string ShortId => Id.Substring(0, 8).ToUpper();
    public string StatusDisplayName => Status switch
    {
        OrderStatus.Pending => "Aguardando confirmação",
        OrderStatus.Confirmed => "Confirmado pela pizzaria",
        OrderStatus.Preparing => "Em preparação",
        OrderStatus.Baking => "No forno",
        OrderStatus.Ready => "Pronto para retirada/entrega",
        OrderStatus.OutForDelivery => "Saiu para entrega",
        OrderStatus.Delivered => "Entregue",
        OrderStatus.Cancelled => "Cancelado",
        _ => Status.ToString()
    };
}