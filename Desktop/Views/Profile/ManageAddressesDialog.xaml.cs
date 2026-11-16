namespace PizzariaDesktop.Views.Profile;

using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using Microsoft.Extensions.DependencyInjection;
using PizzariaDesktop.Models;
using PizzariaDesktop.Data.Repositories;
using PizzariaDesktop.Services;

public partial class ManageAddressesDialog : Window
{
    private readonly User _currentUser;
    private readonly IAddressRepository _addressRepository;
    private readonly IServiceScope _serviceScope;
    private ObservableCollection<Address> _addresses = new();
    private bool _isEditing = false;
    private Address? _editingAddress = null;

    public ManageAddressesDialog(User currentUser)
    {
        try
        {
            InitializeComponent();
            _currentUser = currentUser ?? throw new ArgumentNullException(nameof(currentUser));

            // Create a scope to resolve Scoped services (repositories, DbContext)
            _serviceScope = App.Services.CreateScope();
            _addressRepository = _serviceScope.ServiceProvider.GetRequiredService<IAddressRepository>();

            LoadAddresses();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Erro no construtor ManageAddressesDialog: {ex.Message}");
            System.Diagnostics.Debug.WriteLine($"StackTrace: {ex.StackTrace}");
            if (ex.InnerException != null)
            {
                System.Diagnostics.Debug.WriteLine($"Inner Exception: {ex.InnerException.Message}");
                System.Diagnostics.Debug.WriteLine($"Inner StackTrace: {ex.InnerException.StackTrace}");
            }
            throw;
        }
    }

    protected override void OnClosed(EventArgs e)
    {
        base.OnClosed(e);
        // Dispose the scope when dialog closes
        _serviceScope?.Dispose();
    }

    private async void LoadAddresses()
    {
        if (_addressRepository == null) return;

        try
        {
            var addresses = await _addressRepository.GetByUserIdAsync(_currentUser.Id);
            _addresses.Clear();
            foreach (var addr in addresses)
            {
                _addresses.Add(addr);
            }
            UpdateAddressesUI();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Erro ao carregar endereços: {ex.Message}");
        }
    }

    private void UpdateAddressesUI()
    {
        AddressesList.ItemsSource = _addresses;

        if (_addresses.Count == 0)
        {
            AddressesList.Visibility = Visibility.Collapsed;
            EmptyState.Visibility = Visibility.Visible;
        }
        else
        {
            AddressesList.Visibility = Visibility.Visible;
            EmptyState.Visibility = Visibility.Collapsed;
        }
    }

    private void AddAddressButton_Click(object sender, RoutedEventArgs e)
    {
        ShowAddAddressForm();
    }

    private void ShowAddAddressForm(Address? addressToEdit = null)
    {
        _isEditing = addressToEdit != null;
        _editingAddress = addressToEdit;

        if (_isEditing)
        {
            LabelTextBox.Text = addressToEdit.Label;
            NumberTextBox.Text = addressToEdit.Number;
            StreetTextBox.Text = addressToEdit.Street;
            ComplementTextBox.Text = addressToEdit.Complement;
            NeighborhoodTextBox.Text = addressToEdit.Neighborhood;
            ZipCodeTextBox.Text = addressToEdit.ZipCode;
            CityTextBox.Text = addressToEdit.City;
            StateTextBox.Text = addressToEdit.State;
            IsDefaultCheckBox.IsChecked = addressToEdit.IsDefault;
            SaveAddressButton.Content = CreateButtonContent("💾", "Atualizar Endereço");
        }
        else
        {
            ClearForm();
            SaveAddressButton.Content = CreateButtonContent("💾", "Salvar Endereço");
        }

        AddressesList.Visibility = Visibility.Collapsed;
        EmptyState.Visibility = Visibility.Collapsed;
        AddAddressForm.Visibility = Visibility.Visible;
        AddAddressButton.Visibility = Visibility.Collapsed;
    }

    private void HideAddAddressForm()
    {
        AddAddressForm.Visibility = Visibility.Collapsed;
        AddAddressButton.Visibility = Visibility.Visible;
        UpdateAddressesUI();
        ClearForm();
        _isEditing = false;
        _editingAddress = null;
    }

    private void ClearForm()
    {
        LabelTextBox.Text = "";
        NumberTextBox.Text = "";
        StreetTextBox.Text = "";
        ComplementTextBox.Text = "";
        NeighborhoodTextBox.Text = "";
        ZipCodeTextBox.Text = "";
        CityTextBox.Text = "";
        StateTextBox.Text = "";
        IsDefaultCheckBox.IsChecked = false;
    }

    private object CreateButtonContent(string icon, string text)
    {
        var panel = new StackPanel { Orientation = Orientation.Horizontal };
        panel.Children.Add(new TextBlock { Text = icon, FontSize = 16, Margin = new Thickness(0, 0, 8, 0), VerticalAlignment = VerticalAlignment.Center });
        panel.Children.Add(new TextBlock { Text = text, VerticalAlignment = VerticalAlignment.Center, FontWeight = FontWeights.SemiBold });
        return panel;
    }

    private async void SaveAddressButton_Click(object sender, RoutedEventArgs e)
    {;

        var label = LabelTextBox.Text?.Trim() ?? "";
        var number = NumberTextBox.Text?.Trim() ?? "";
        var street = StreetTextBox.Text?.Trim() ?? "";
        var complement = ComplementTextBox.Text?.Trim() ?? "";
        var neighborhood = NeighborhoodTextBox.Text?.Trim() ?? "";
        var zipCode = ZipCodeTextBox.Text?.Trim() ?? "";
        var city = CityTextBox.Text?.Trim() ?? "";
        var state = StateTextBox.Text?.Trim() ?? "";
        var isDefault = IsDefaultCheckBox.IsChecked == true;

        // Validation
        if (string.IsNullOrWhiteSpace(label) || string.IsNullOrWhiteSpace(street) ||
            string.IsNullOrWhiteSpace(neighborhood) || string.IsNullOrWhiteSpace(city) ||
            string.IsNullOrWhiteSpace(state) || string.IsNullOrWhiteSpace(zipCode))
        {
            MessageBox.Show("Preencha todos os campos obrigatórios", "Erro", MessageBoxButton.OK, MessageBoxImage.Warning);
            return;
        }

        try
        {
            if (_isEditing && _editingAddress != null)
            {
                // Update existing address
                _editingAddress.Label = label;
                _editingAddress.Number = number;
                _editingAddress.Street = street;
                _editingAddress.Complement = complement;
                _editingAddress.Neighborhood = neighborhood;
                _editingAddress.ZipCode = zipCode;
                _editingAddress.City = city;
                _editingAddress.State = state;
                _editingAddress.IsDefault = isDefault;

                var success = await _addressRepository.UpdateAsync(_editingAddress);
                if (success)
                {
                    // If this is set as default, update others
                    if (isDefault)
                    {
                        await _addressRepository.SetDefaultAsync(_currentUser.Id, _editingAddress.Id);
                    }
                }
            }
            else
            {
                // Create new address
                var newAddress = new Address
                {
                    Label = label,
                    Number = number,
                    Street = street,
                    Complement = complement,
                    Neighborhood = neighborhood,
                    ZipCode = zipCode,
                    City = city,
                    State = state,
                    IsDefault = isDefault
                };

                var createdAddress = await _addressRepository.CreateAsync(newAddress, _currentUser.Id);

                // If this is the first address or set as default, make it default
                if (_addresses.Count == 0 || isDefault)
                {
                    await _addressRepository.SetDefaultAsync(_currentUser.Id, createdAddress.Id);
                    createdAddress.IsDefault = true;
                }

                _addresses.Add(createdAddress);
            }

            // Update user's address list
            _currentUser.Addresses.Clear();
            foreach (var addr in _addresses)
            {
                _currentUser.Addresses.Add(addr);
            }

            HideAddAddressForm();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Erro ao salvar endereço: {ex.Message}");
            MessageBox.Show($"Erro ao salvar endereço: {ex.Message}", "Erro", MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }

    private void CancelAddButton_Click(object sender, RoutedEventArgs e)
    {
        HideAddAddressForm();
    }

    private void EditAddress_Click(object sender, RoutedEventArgs e)
    {
        if (sender is Button btn && btn.Tag is Address address)
        {
            ShowAddAddressForm(address);
        }
    }

    private async void DeleteAddress_Click(object sender, RoutedEventArgs e)
    {
        if (sender is Button btn && btn.Tag is Address address)
        {
            var result = MessageBox.Show(
                $"Tem certeza que deseja excluir o endereço \"{address.Label}\"?",
                "Confirmar Exclusão",
                MessageBoxButton.YesNo,
                MessageBoxImage.Question);

            if (result != MessageBoxResult.Yes) return;

            try
            {
                var success = await _addressRepository.DeleteAsync(address.Id);
                if (success)
                {
                    _addresses.Remove(address);
                    _currentUser.Addresses.Remove(address);
                    UpdateAddressesUI();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Erro ao excluir endereço: {ex.Message}");
                MessageBox.Show($"Erro ao excluir endereço: {ex.Message}", "Erro", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }

    private void CloseButton_Click(object sender, RoutedEventArgs e)
    {
        DialogResult = true;
        Close();
    }
}