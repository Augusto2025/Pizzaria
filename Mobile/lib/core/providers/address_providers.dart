import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza/data/repositories/address_repository.dart';
import 'package:pizza/data/models/address_models.dart';

final _getIt = GetIt.instance;

/// Provider do AddressRepository
final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  return _getIt<AddressRepository>();
});

/// Provider da lista de endereços
final addressesProvider = FutureProvider<List<AddressDto>>((ref) async {
  final repository = ref.watch(addressRepositoryProvider);
  return await repository.getAddresses();
});

/// Provider de endereço específico
final addressProvider = FutureProvider.family<AddressDto, String>((ref, id) async {
  final repository = ref.watch(addressRepositoryProvider);
  return await repository.getAddress(id);
});

/// Notifier para operações de endereços
final addressNotifierProvider = StateNotifierProvider<AddressNotifier, AsyncValue<void>>((ref) {
  return AddressNotifier(ref.watch(addressRepositoryProvider), ref);
});

class AddressNotifier extends StateNotifier<AsyncValue<void>> {
  final AddressRepository _addressRepository;
  final Ref _ref;

  AddressNotifier(this._addressRepository, this._ref) : super(const AsyncValue.data(null));

  Future<AddressDto> createAddress(CreateAddressRequest request) async {
    state = const AsyncValue.loading();
    try {
      final address = await _addressRepository.createAddress(request);
      _ref.invalidate(addressesProvider);
      state = const AsyncValue.data(null);
      return address;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<AddressDto> updateAddress(String id, UpdateAddressRequest request) async {
    state = const AsyncValue.loading();
    try {
      final address = await _addressRepository.updateAddress(id, request);
      _ref.invalidate(addressesProvider);
      state = const AsyncValue.data(null);
      return address;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteAddress(String id) async {
    state = const AsyncValue.loading();
    try {
      await _addressRepository.deleteAddress(id);
      _ref.invalidate(addressesProvider);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> setDefaultAddress(String id) async {
    state = const AsyncValue.loading();
    try {
      await _addressRepository.setDefaultAddress(id);
      _ref.invalidate(addressesProvider);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}