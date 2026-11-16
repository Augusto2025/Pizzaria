namespace PizzariaDesktop.ViewModels;

using System.Collections.ObjectModel;
using System.Windows.Input;
using System.Windows;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data;
using PizzariaDesktop.Data.Repositories;
using PizzariaDesktop.Views.Profile;

public class ProfileViewModel : BaseViewModel
{
    private readonly MainViewModel _mainViewModel;
    private string _name;
    private string _email;
    private string _phone;

    public ProfileViewModel(MainViewModel mainViewModel)
    {
        _mainViewModel = mainViewModel;
        var user = _mainViewModel.CurrentUser ?? MockData.CurrentUser;
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

    public int TotalOrders => _mainViewModel.UserOrders.Count;
    public int DeliveredOrders => _mainViewModel.UserOrders.Count(o => o.Status == OrderStatus.Delivered);
    public double TotalSpent => _mainViewModel.UserOrders.Where(o => o.Status == OrderStatus.Delivered).Sum(o => o.Total);

    public string FormattedTotalSpent => $"R$ {TotalSpent:F2}";

    public ICommand GoToHomeCommand { get; }
    public ICommand GoToOrdersCommand { get; }
    public ICommand GoToMenuCommand { get; }
    public ICommand LogoutCommand { get; }
    public ICommand EditProfileCommand { get; }
    public ICommand ManageAddressesCommand { get; }
    public ICommand ManagePaymentMethodsCommand { get; }
    public ICommand SettingsCommand { get; }

    public void EditProfile()
    {
        if (CurrentUser == null) return;

        try
        {
            var dialog = new EditProfileDialog(CurrentUser);
            var result = dialog.ShowDialog();

            if (result == true)
            {
                // Reload user data from database to get updated info
                RefreshUserData();
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Erro ao abrir Editar Perfil: {ex.Message}");
            System.Diagnostics.Debug.WriteLine($"StackTrace: {ex.StackTrace}");
            if (ex.InnerException != null)
            {
                System.Diagnostics.Debug.WriteLine($"Inner Exception: {ex.InnerException.Message}");
                System.Diagnostics.Debug.WriteLine($"Inner StackTrace: {ex.InnerException.StackTrace}");
            }
            MessageBox.Show($"Erro ao abrir editor de perfil: {ex.Message}", "Erro",
                MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }

    private void RefreshUserData()
    {
        if (CurrentUser != null)
        {
            Name = CurrentUser.Name;
            Email = CurrentUser.Email;
            Phone = CurrentUser.Phone;
            Addresses.Clear();
            foreach (var addr in CurrentUser.Addresses)
            {
                Addresses.Add(addr);
            }
            OnPropertyChanged(nameof(TotalOrders));
            OnPropertyChanged(nameof(DeliveredOrders));
            OnPropertyChanged(nameof(TotalSpent));
            OnPropertyChanged(nameof(FormattedTotalSpent));
        }
    }

    public void ManageAddresses()
    {
        // TODO: Implement address management dialog
        MessageBox.Show("Gerenciamento de endereços será implementado em breve", "Em Desenvolvimento", MessageBoxButton.OK, MessageBoxImage.Information);
    }

    public void ManagePaymentMethods()
    {
        // TODO: Implement payment methods management
        MessageBox.Show("Gerenciamento de formas de pagamento será implementado em breve", "Em Desenvolvimento", MessageBoxButton.OK, MessageBoxImage.Information);
    }

    public void Settings()
    {
        // TODO: Implement settings dialog
        MessageBox.Show("Configurações serão implementadas em breve", "Em Desenvolvimento", MessageBoxButton.OK, MessageBoxImage.Information);
    }
}