// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    _LoginResponse(
      token: json['token'] as String,
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(_LoginResponse instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user};

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };

_RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    _RegisterResponse(
      token: json['token'] as String,
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseToJson(_RegisterResponse instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user};

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  addresses: (json['addresses'] as List<dynamic>)
      .map((e) => AddressDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'createdAt': instance.createdAt.toIso8601String(),
  'addresses': instance.addresses,
};

_UserStatsDto _$UserStatsDtoFromJson(Map<String, dynamic> json) =>
    _UserStatsDto(
      totalOrders: (json['totalOrders'] as num).toInt(),
      deliveredOrders: (json['deliveredOrders'] as num).toInt(),
      totalSpent: (json['totalSpent'] as num).toDouble(),
    );

Map<String, dynamic> _$UserStatsDtoToJson(_UserStatsDto instance) =>
    <String, dynamic>{
      'totalOrders': instance.totalOrders,
      'deliveredOrders': instance.deliveredOrders,
      'totalSpent': instance.totalSpent,
    };

_UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateProfileRequest(
  userId: json['userId'] as String,
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  currentPassword: json['currentPassword'] as String?,
  newPassword: json['newPassword'] as String?,
  confirmNewPassword: json['confirmNewPassword'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  _UpdateProfileRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'name': instance.name,
  'phone': instance.phone,
  'currentPassword': instance.currentPassword,
  'newPassword': instance.newPassword,
  'confirmNewPassword': instance.confirmNewPassword,
};
