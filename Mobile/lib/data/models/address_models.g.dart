// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddressDto _$AddressDtoFromJson(Map<String, dynamic> json) => _AddressDto(
  id: json['id'] as String,
  label: json['label'] as String,
  street: json['street'] as String,
  number: json['number'] as String,
  complement: json['complement'] as String,
  neighborhood: json['neighborhood'] as String,
  city: json['city'] as String,
  state: json['state'] as String,
  zipCode: json['zipCode'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  isDefault: json['isDefault'] as bool,
);

Map<String, dynamic> _$AddressDtoToJson(_AddressDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'street': instance.street,
      'number': instance.number,
      'complement': instance.complement,
      'neighborhood': instance.neighborhood,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isDefault': instance.isDefault,
    };

_AddressesResponse _$AddressesResponseFromJson(Map<String, dynamic> json) =>
    _AddressesResponse(
      addresses:
          (json['addresses'] as List<dynamic>?)
              ?.map((e) => AddressDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AddressesResponseToJson(_AddressesResponse instance) =>
    <String, dynamic>{'addresses': instance.addresses};

_CreateAddressRequest _$CreateAddressRequestFromJson(
  Map<String, dynamic> json,
) => _CreateAddressRequest(
  label: json['label'] as String,
  street: json['street'] as String,
  number: json['number'] as String,
  complement: json['complement'] as String?,
  neighborhood: json['neighborhood'] as String,
  city: json['city'] as String,
  state: json['state'] as String,
  zipCode: json['zipCode'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  isDefault: json['isDefault'] as bool,
);

Map<String, dynamic> _$CreateAddressRequestToJson(
  _CreateAddressRequest instance,
) => <String, dynamic>{
  'label': instance.label,
  'street': instance.street,
  'number': instance.number,
  'complement': instance.complement,
  'neighborhood': instance.neighborhood,
  'city': instance.city,
  'state': instance.state,
  'zipCode': instance.zipCode,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'isDefault': instance.isDefault,
};

_UpdateAddressRequest _$UpdateAddressRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateAddressRequest(
  id: json['id'] as String,
  label: json['label'] as String?,
  street: json['street'] as String?,
  number: json['number'] as String?,
  complement: json['complement'] as String?,
  neighborhood: json['neighborhood'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  zipCode: json['zipCode'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isDefault: json['isDefault'] as bool?,
);

Map<String, dynamic> _$UpdateAddressRequestToJson(
  _UpdateAddressRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'street': instance.street,
  'number': instance.number,
  'complement': instance.complement,
  'neighborhood': instance.neighborhood,
  'city': instance.city,
  'state': instance.state,
  'zipCode': instance.zipCode,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'isDefault': instance.isDefault,
};
