// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressDtoImpl _$$AddressDtoImplFromJson(Map<String, dynamic> json) =>
    _$AddressDtoImpl(
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

Map<String, dynamic> _$$AddressDtoImplToJson(_$AddressDtoImpl instance) =>
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

_$AddressesResponseImpl _$$AddressesResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AddressesResponseImpl(
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => AddressDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AddressesResponseImplToJson(
        _$AddressesResponseImpl instance) =>
    <String, dynamic>{
      'addresses': instance.addresses,
    };

_$CreateAddressRequestImpl _$$CreateAddressRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateAddressRequestImpl(
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

Map<String, dynamic> _$$CreateAddressRequestImplToJson(
        _$CreateAddressRequestImpl instance) =>
    <String, dynamic>{
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

_$UpdateAddressRequestImpl _$$UpdateAddressRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateAddressRequestImpl(
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

Map<String, dynamic> _$$UpdateAddressRequestImplToJson(
        _$UpdateAddressRequestImpl instance) =>
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
