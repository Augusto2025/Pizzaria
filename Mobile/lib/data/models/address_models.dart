import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_models.freezed.dart';
part 'address_models.g.dart';

@freezed
abstract class AddressDto with _$AddressDto {
  const factory AddressDto({
    required String id,
    required String label,
    required String street,
    required String number,
    required String complement,
    required String neighborhood,
    required String city,
    required String state,
    required String zipCode,
    required double latitude,
    required double longitude,
    required bool isDefault,
  }) = _AddressDto;

  factory AddressDto.fromJson(Map<String, dynamic> json) => _$AddressDtoFromJson(json);
}

@freezed
abstract class AddressesResponse with _$AddressesResponse {
  const factory AddressesResponse({
    @Default([]) List<AddressDto> addresses,
  }) = _AddressesResponse;

  factory AddressesResponse.fromJson(Map<String, dynamic> json) => _$AddressesResponseFromJson(json);
}

@freezed
abstract class CreateAddressRequest with _$CreateAddressRequest {
  const factory CreateAddressRequest({
    required String label,
    required String street,
    required String number,
    String? complement,
    required String neighborhood,
    required String city,
    required String state,
    required String zipCode,
    required double latitude,
    required double longitude,
    required bool isDefault,
  }) = _CreateAddressRequest;

  factory CreateAddressRequest.fromJson(Map<String, dynamic> json) => _$CreateAddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAddressRequestToJson(this);
}

@freezed
abstract class UpdateAddressRequest with _$UpdateAddressRequest {
  const factory UpdateAddressRequest({
    String? label,
    String? street,
    String? number,
    String? complement,
    String? neighborhood,
    String? city,
    String? state,
    String? zipCode,
    double? latitude,
    double? longitude,
    bool? isDefault,
  }) = _UpdateAddressRequest;

  factory UpdateAddressRequest.fromJson(Map<String, dynamic> json) => _$UpdateAddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAddressRequestToJson(this);
}