namespace PizzariaDesktop.ViewModels;

using System.Collections.ObjectModel;
using System.Windows.Input;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data;

public class ProfileViewModel : BaseViewModel
{
    private readonly MainViewModel _mainViewModel;
    private string _name;
    private string _email;
    private string _phone;

    public ProfileViewModel(MainViewModel mainViewModel)
    {
        _mainViewModel = mainViewModel;
        var user = MockData.CurrentUser;
        _name = user.Name;
        _email = user.Email;
        _phone = user.Phone;
        Addresses = new ObservableCollection<Address>(user.Addresses);

        GoToHomeCommand = new RelayCommand(_ => _mainViewModel.NavigateToHome());
        GoToOrdersCommand = new RelayCommand(_ => _mainViewModel.NavigateToOrders());
        GoToMenuCommand = new RelayCommand(_ => _mainViewModel.NavigateToMenu());
        LogoutCommand = new RelayCommand(_ => _mainViewModel.Logout());
        EditProfileCommand = new RelayCommand(_ => EditProfile());
        ManageAddressesCommand = new RelayCommand(_ => ManageAddresses());
        ManagePaymentMethodsCommand = new RelayCommand(_ => ManagePaymentMethods());
        SettingsCommand = new RelayCommand(_ => Settings());
    }

    public User? CurrentUser => _mainViewModel.CurrentUser;

    public string Name
    {
        get => _name;
        set => SetProperty(ref _name, value);
    }

    public string Email
    {
        get => _email;
        set => SetProperty(ref _email, value);
    }

    public string Phone
    {
        get => _phone;
        set => SetProperty(ref _phone, value);
    }

    public ObservableCollection<Address> Addresses { get; }

    public int TotalOrders => MockData.Orders.Count;
    public int DeliveredOrders => MockData.Orders.Count(o => o.Status == OrderStatus.Delivered);
    public double TotalSpent => MockData.Orders.Where(o => o.Status == OrderStatus.Delivered).Sum(o => o.Total);

    public string FormattedTotalSpent => $"R$ {TotalSpent:F2}";

    public ICommand GoToHomeCommand { get; }
    public ICommand GoToOrdersCommand { get; }
    public ICommand GoToMenuCommand { get; }
    public ICommand LogoutCommand { get; }
    public ICommand EditProfileCommand { get; }
    public ICommand ManageAddressesCommand { get; }
    public ICommand ManagePaymentMethodsCommand { get; }
    public ICommand SettingsCommand { get; }

    public void EditProfile() { /* Demo only */ }
    public void ManageAddresses() { /* Demo only */ }
    public void ManagePaymentMethods() { /* Demo only */ }
    public void Settings() { /* Demo only */ }
}