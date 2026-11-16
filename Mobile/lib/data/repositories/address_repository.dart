import 'package:pizza/data/models/address_models.dart';
import 'package:pizza/data/sources/api/api_service.dart';

/// Repositório de endereços
class AddressRepository {
  final ApiService _apiService;

  AddressRepository(this._apiService);

  Future<List<AddressDto>> getAddresses() async {
    return await _apiService.getAddresses();
  }

  Future<AddressDto> getAddress(String id) async {
    return await _apiService.getAddress(id);
  }

  Future<AddressDto> createAddress(CreateAddressRequest request) async {
    return await _apiService.createAddress(request);
  }

  Future<AddressDto> updateAddress(String id, UpdateAddressRequest request) async {
    return await _apiService.updateAddress(id, request);
  }

  Future<void> deleteAddress(String id) async {
    return await _apiService.deleteAddress(id);
  }

  Future<void> setDefaultAddress(String id) async {
    return await _apiService.setDefaultAddress(id);
  }
}