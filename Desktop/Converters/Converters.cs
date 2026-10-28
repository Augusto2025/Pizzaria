namespace PizzariaDesktop.Converters;

using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;
using System.Windows.Media;
using PizzariaDesktop.Models;

public class BoolToVisibilityConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        return value is true ? Visibility.Visible : Visibility.Collapsed;
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        return value is Visibility.Visible;
    }
}

public class InverseBoolToVisibilityConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        return value is true ? Visibility.Collapsed : Visibility.Visible;
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        return value is Visibility.Collapsed;
    }
}

public class InverseBoolConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        return value is bool b ? !b : true;
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        return value is bool b ? !b : true;
    }
}

public class OrderStatusToColorConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        if (value is OrderStatus status)
        {
            return status switch
            {
                OrderStatus.Pending => new SolidColorBrush(Color.FromRgb(0xFF, 0xC1, 0x07)),       // Warning
                OrderStatus.Confirmed => new SolidColorBrush(Color.FromRgb(0x17, 0xA2, 0xB8)),      // Info
                OrderStatus.Preparing => new SolidColorBrush(Color.FromRgb(0x6F, 0x42, 0xC1)),      // Purple
                OrderStatus.Baking => new SolidColorBrush(Color.FromRgb(0xFD, 0x7E, 0x14)),         // Orange
                OrderStatus.Ready => new SolidColorBrush(Color.FromRgb(0x28, 0xA7, 0x45)),          // Success
                OrderStatus.OutForDelivery => new SolidColorBrush(Color.FromRgb(0x00, 0x7B, 0xFF)),  // Blue
                OrderStatus.Delivered => new SolidColorBrush(Color.FromRgb(0x28, 0xA7, 0x45)),      // Success
                OrderStatus.Cancelled => new SolidColorBrush(Color.FromRgb(0xDC, 0x35, 0x45)),      // Error
                _ => new SolidColorBrush(Color.FromRgb(0x66, 0x66, 0x66))
            };
        }
        return new SolidColorBrush(Color.FromRgb(0x66, 0x66, 0x66));
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}

public class CategoryToIconConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        if (value is Category category)
        {
            return category switch
            {
                Category.Pizza => "🍕",
                Category.Drink => "🥤",
                Category.Dessert => "🍰",
                Category.Side => "🍟",
                _ => "🍽️"
            };
        }
        return "🍽️";
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}

public class CategoryDisplayNameConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        if (value is Category category)
        {
            return category switch
            {
                Category.Pizza => "Pizzas",
                Category.Drink => "Bebidas",
                Category.Dessert => "Sobremesas",
                Category.Side => "Acompanhamentos",
                _ => "Outros"
            };
        }
        return "Outros";
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}

public class CategoryBackgroundConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        if (value is Category category && parameter is Category selectedCategory)
        {
            return category == selectedCategory
                ? new SolidColorBrush(Color.FromRgb(0xFF, 0x6B, 0x35))
                : new SolidColorBrush(Colors.Transparent);
        }
        return new SolidColorBrush(Colors.Transparent);
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}

public class CategoryBorderConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        if (value is Category category && parameter is Category selectedCategory)
        {
            return category == selectedCategory
                ? new SolidColorBrush(Color.FromRgb(0xFF, 0x6B, 0x35))
                : new SolidColorBrush(Color.FromRgb(0xE0, 0xE0, 0xE0));
        }
        return new SolidColorBrush(Color.FromRgb(0xE0, 0xE0, 0xE0));
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}

public class CategoryForegroundConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        if (value is Category category && parameter is Category selectedCategory)
        {
            return category == selectedCategory
                ? new SolidColorBrush(Colors.White)
                : new SolidColorBrush(Color.FromRgb(0xFF, 0x6B, 0x35));
        }
        return new SolidColorBrush(Color.FromRgb(0xFF, 0x6B, 0x35));
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}

public class BoolToBackgroundConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        if (value is bool isSelected)
        {
            if (parameter is string param && param == "selected")
            {
                return isSelected
                    ? new SolidColorBrush(Color.FromRgb(0xFF, 0xF0, 0xEB))
                    : new SolidColorBrush(Colors.White);
            }
            return isSelected
                ? new SolidColorBrush(Color.FromRgb(0xFF, 0xF0, 0xEB))
                : new SolidColorBrush(Colors.White);
        }
        return new SolidColorBrush(Colors.White);
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}

public class EmptyToVisibilityConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        if (value == null) return Visibility.Visible;

        if (value is string str) return string.IsNullOrEmpty(str) ? Visibility.Visible : Visibility.Collapsed;
        if (value is System.Collections.ICollection col) return col.Count == 0 ? Visibility.Visible : Visibility.Collapsed;
        if (value is int i) return i == 0 ? Visibility.Visible : Visibility.Collapsed;
        if (value is double d) return d == 0 ? Visibility.Visible : Visibility.Collapsed;

        return Visibility.Collapsed;
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}

public class CategoryBackgroundMultiConverter : IMultiValueConverter
{
    public object Convert(object[] values, Type targetType, object parameter, CultureInfo culture)
    {
        if (values.Length == 2 && values[0] is Category current && values[1] is Category selected)
        {
            return current == selected
                ? new SolidColorBrush(Color.FromRgb(0xFF, 0x6B, 0x35))
                : new SolidColorBrush(Colors.Transparent);
        }
        return new SolidColorBrush(Colors.Transparent);
    }

    public object[] ConvertBack(object value, Type[] targetTypes, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}

public class CategoryBorderMultiConverter : IMultiValueConverter
{
    public object Convert(object[] values, Type targetType, object parameter, CultureInfo culture)
    {
        if (values.Length == 2 && values[0] is Category current && values[1] is Category selected)
        {
            return current == selected
                ? new SolidColorBrush(Color.FromRgb(0xFF, 0x6B, 0x35))
                : new SolidColorBrush(Color.FromRgb(0xE0, 0xE0, 0xE0));
        }
        return new SolidColorBrush(Color.FromRgb(0xE0, 0xE0, 0xE0));
    }

    public object[] ConvertBack(object value, Type[] targetTypes, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}

public class CategoryForegroundMultiConverter : IMultiValueConverter
{
    public object Convert(object[] values, Type targetType, object parameter, CultureInfo culture)
    {
        if (values.Length == 2 && values[0] is Category current && values[1] is Category selected)
        {
            return current == selected
                ? new SolidColorBrush(Colors.White)
                : new SolidColorBrush(Color.FromRgb(0xFF, 0x6B, 0x35));
        }
        return new SolidColorBrush(Color.FromRgb(0xFF, 0x6B, 0x35));
    }

    public object[] ConvertBack(object value, Type[] targetTypes, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}