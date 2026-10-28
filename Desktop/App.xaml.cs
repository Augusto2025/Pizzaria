using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;
using System.Windows.Media;
using PizzariaDesktop.Models;

namespace PizzariaDesktop
{
    public partial class App : Application
    {
    }

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

    public class OrderStatusToColorConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is OrderStatus status)
            {
                return status switch
                {
                    OrderStatus.Pending => "#FFC107",
                    OrderStatus.Confirmed => "#17A2B8",
                    OrderStatus.Preparing => "#17A2B8",
                    OrderStatus.Baking => "#FF6B35",
                    OrderStatus.Ready => "#28A745",
                    OrderStatus.OutForDelivery => "#6F42C1",
                    OrderStatus.Delivered => "#28A745",
                    OrderStatus.Cancelled => "#DC3545",
                    _ => "#666666"
                };
            }
            return "#666666";
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
            if (value is Product product)
            {
                return product.Category switch
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
                    _ => category.ToString()
                };
            }
            if (value is Product product)
            {
                return product.Category switch
                {
                    Category.Pizza => "Pizzas",
                    Category.Drink => "Bebidas",
                    Category.Dessert => "Sobremesas",
                    Category.Side => "Acompanhamentos",
                    _ => product.Category.ToString()
                };
            }
            return "";
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
            var current = value as Category?;
            var selected = parameter as Category?;

            if (current == selected)
                return (Color)ColorConverter.ConvertFromString("#FFFFF0EB");
            return (Color)ColorConverter.ConvertFromString("#FFFFFFFF");
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
            var current = value as Category?;
            var selected = parameter as Category?;

            if (current == selected)
                return (Color)ColorConverter.ConvertFromString("#FFFF6B35");
            return (Color)ColorConverter.ConvertFromString("#FFE0E0E0");
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
            var current = value as Category?;
            var selected = parameter as Category?;

            if (current == selected)
                return (Color)ColorConverter.ConvertFromString("#FFFF6B35");
            return (Color)ColorConverter.ConvertFromString("#FF666666");
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
            if (value is int count)
                return count == 0 ? Visibility.Visible : Visibility.Collapsed;
            return Visibility.Collapsed;
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
            var isSelected = value is true;
            var param = parameter as string;

            if (isSelected && param == "selected")
                return (Color)ColorConverter.ConvertFromString("#FFFFF0EB");
            return (Color)ColorConverter.ConvertFromString("#FFFFFFFF");
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}