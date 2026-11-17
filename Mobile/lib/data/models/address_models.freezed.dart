// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddressDto {

 String get id; String get label; String get street; String get number; String get complement; String get neighborhood; String get city; String get state; String get zipCode; double get latitude; double get longitude; bool get isDefault;
/// Create a copy of AddressDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressDtoCopyWith<AddressDto> get copyWith => _$AddressDtoCopyWithImpl<AddressDto>(this as AddressDto, _$identity);

  /// Serializes this AddressDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AddressDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.street, _this.street) || other.street == _this.street)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.complement, _this.complement) || other.complement == _this.complement)&&(identical(other.neighborhood, _this.neighborhood) || other.neighborhood == _this.neighborhood)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.zipCode, _this.zipCode) || other.zipCode == _this.zipCode)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.isDefault, _this.isDefault) || other.isDefault == _this.isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AddressDto;
  return Object.hash(runtimeType,_this.id,_this.label,_this.street,_this.number,_this.complement,_this.neighborhood,_this.city,_this.state,_this.zipCode,_this.latitude,_this.longitude,_this.isDefault);
}

@override
String toString() {
  final _this = this as AddressDto;
  return 'AddressDto(id: ${_this.id}, label: ${_this.label}, street: ${_this.street}, number: ${_this.number}, complement: ${_this.complement}, neighborhood: ${_this.neighborhood}, city: ${_this.city}, state: ${_this.state}, zipCode: ${_this.zipCode}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, isDefault: ${_this.isDefault})';
}


}

/// @nodoc
abstract mixin class $AddressDtoCopyWith<$Res>  {
  factory $AddressDtoCopyWith(AddressDto value, $Res Function(AddressDto) _then) = _$AddressDtoCopyWithImpl;
@useResult
$Res call({
 String id, String label, String street, String number, String complement, String neighborhood, String city, String state, String zipCode, double latitude, double longitude, bool isDefault
});




}
/// @nodoc
class _$AddressDtoCopyWithImpl<$Res>
    implements $AddressDtoCopyWith<$Res> {
  _$AddressDtoCopyWithImpl(this._self, this._then);

  final AddressDto _self;
  final $Res Function(AddressDto) _then;

/// Create a copy of AddressDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? street = null,Object? number = null,Object? complement = null,Object? neighborhood = null,Object? city = null,Object? state = null,Object? zipCode = null,Object? latitude = null,Object? longitude = null,Object? isDefault = null,}) {
  return _then(AddressDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,complement: null == complement ? _self.complement : complement // ignore: cast_nullable_to_non_nullable
as String,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,zipCode: null == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AddressDto].
extension AddressDtoPatterns on AddressDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddressDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddressDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddressDto value)  $default,){
final _that = this;
switch (_that) {
case _AddressDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddressDto value)?  $default,){
final _that = this;
switch (_that) {
case _AddressDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String street,  String number,  String complement,  String neighborhood,  String city,  String state,  String zipCode,  double latitude,  double longitude,  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressDto() when $default != null:
return $default(_that.id,_that.label,_that.street,_that.number,_that.complement,_that.neighborhood,_that.city,_that.state,_that.zipCode,_that.latitude,_that.longitude,_that.isDefault);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String street,  String number,  String complement,  String neighborhood,  String city,  String state,  String zipCode,  double latitude,  double longitude,  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _AddressDto():
return $default(_that.id,_that.label,_that.street,_that.number,_that.complement,_that.neighborhood,_that.city,_that.state,_that.zipCode,_that.latitude,_that.longitude,_that.isDefault);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String street,  String number,  String complement,  String neighborhood,  String city,  String state,  String zipCode,  double latitude,  double longitude,  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _AddressDto() when $default != null:
return $default(_that.id,_that.label,_that.street,_that.number,_that.complement,_that.neighborhood,_that.city,_that.state,_that.zipCode,_that.latitude,_that.longitude,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddressDto implements AddressDto {
  const _AddressDto({required this.id, required this.label, required this.street, required this.number, required this.complement, required this.neighborhood, required this.city, required this.state, required this.zipCode, required this.latitude, required this.longitude, required this.isDefault});
  factory _AddressDto.fromJson(Map<String, dynamic> json) => _$AddressDtoFromJson(json);

@override final  String id;
@override final  String label;
@override final  String street;
@override final  String number;
@override final  String complement;
@override final  String neighborhood;
@override final  String city;
@override final  String state;
@override final  String zipCode;
@override final  double latitude;
@override final  double longitude;
@override final  bool isDefault;

/// Create a copy of AddressDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressDtoCopyWith<_AddressDto> get copyWith => __$AddressDtoCopyWithImpl<_AddressDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressDto&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.street, street) || other.street == street)&&(identical(other.number, number) || other.number == number)&&(identical(other.complement, complement) || other.complement == complement)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,label,street,number,complement,neighborhood,city,state,zipCode,latitude,longitude,isDefault);
}

@override
String toString() {
    return 'AddressDto(id: $id, label: $label, street: $street, number: $number, complement: $complement, neighborhood: $neighborhood, city: $city, state: $state, zipCode: $zipCode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$AddressDtoCopyWith<$Res> implements $AddressDtoCopyWith<$Res> {
  factory _$AddressDtoCopyWith(_AddressDto value, $Res Function(_AddressDto) _then) = __$AddressDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String street, String number, String complement, String neighborhood, String city, String state, String zipCode, double latitude, double longitude, bool isDefault
});




}
/// @nodoc
class __$AddressDtoCopyWithImpl<$Res>
    implements _$AddressDtoCopyWith<$Res> {
  __$AddressDtoCopyWithImpl(this._self, this._then);

  final _AddressDto _self;
  final $Res Function(_AddressDto) _then;

/// Create a copy of AddressDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? street = null,Object? number = null,Object? complement = null,Object? neighborhood = null,Object? city = null,Object? state = null,Object? zipCode = null,Object? latitude = null,Object? longitude = null,Object? isDefault = null,}) {
  return _then(_AddressDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,complement: null == complement ? _self.complement : complement // ignore: cast_nullable_to_non_nullable
as String,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,zipCode: null == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AddressesResponse {

 List<AddressDto> get addresses;
/// Create a copy of AddressesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressesResponseCopyWith<AddressesResponse> get copyWith => _$AddressesResponseCopyWithImpl<AddressesResponse>(this as AddressesResponse, _$identity);

  /// Serializes this AddressesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AddressesResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesResponse&&const DeepCollectionEquality().equals(other.addresses, _this.addresses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AddressesResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.addresses));
}

@override
String toString() {
  final _this = this as AddressesResponse;
  return 'AddressesResponse(addresses: ${_this.addresses})';
}


}

/// @nodoc
abstract mixin class $AddressesResponseCopyWith<$Res>  {
  factory $AddressesResponseCopyWith(AddressesResponse value, $Res Function(AddressesResponse) _then) = _$AddressesResponseCopyWithImpl;
@useResult
$Res call({
 List<AddressDto> addresses
});




}
/// @nodoc
class _$AddressesResponseCopyWithImpl<$Res>
    implements $AddressesResponseCopyWith<$Res> {
  _$AddressesResponseCopyWithImpl(this._self, this._then);

  final AddressesResponse _self;
  final $Res Function(AddressesResponse) _then;

/// Create a copy of AddressesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? addresses = null,}) {
  return _then(AddressesResponse(
addresses: null == addresses ? _self.addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<AddressDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [AddressesResponse].
extension AddressesResponsePatterns on AddressesResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddressesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddressesResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddressesResponse value)  $default,){
final _that = this;
switch (_that) {
case _AddressesResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddressesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AddressesResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AddressDto> addresses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressesResponse() when $default != null:
return $default(_that.addresses);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AddressDto> addresses)  $default,) {final _that = this;
switch (_that) {
case _AddressesResponse():
return $default(_that.addresses);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AddressDto> addresses)?  $default,) {final _that = this;
switch (_that) {
case _AddressesResponse() when $default != null:
return $default(_that.addresses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddressesResponse implements AddressesResponse {
  const _AddressesResponse({ List<AddressDto> addresses = const []}): _addresses = addresses;
  factory _AddressesResponse.fromJson(Map<String, dynamic> json) => _$AddressesResponseFromJson(json);

 final  List<AddressDto> _addresses;
@override@JsonKey() List<AddressDto> get addresses {
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addresses);
}


/// Create a copy of AddressesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressesResponseCopyWith<_AddressesResponse> get copyWith => __$AddressesResponseCopyWithImpl<_AddressesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressesResponse&&const DeepCollectionEquality().equals(other.addresses, _addresses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_addresses));
}

@override
String toString() {
    return 'AddressesResponse(addresses: $addresses)';
}


}

/// @nodoc
abstract mixin class _$AddressesResponseCopyWith<$Res> implements $AddressesResponseCopyWith<$Res> {
  factory _$AddressesResponseCopyWith(_AddressesResponse value, $Res Function(_AddressesResponse) _then) = __$AddressesResponseCopyWithImpl;
@override @useResult
$Res call({
 List<AddressDto> addresses
});




}
/// @nodoc
class __$AddressesResponseCopyWithImpl<$Res>
    implements _$AddressesResponseCopyWith<$Res> {
  __$AddressesResponseCopyWithImpl(this._self, this._then);

  final _AddressesResponse _self;
  final $Res Function(_AddressesResponse) _then;

/// Create a copy of AddressesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? addresses = null,}) {
  return _then(_AddressesResponse(
addresses: null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<AddressDto>,
  ));
}


}


/// @nodoc
mixin _$CreateAddressRequest {

 String get label; String get street; String get number; String? get complement; String get neighborhood; String get city; String get state; String get zipCode; double get latitude; double get longitude; bool get isDefault;
/// Create a copy of CreateAddressRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateAddressRequestCopyWith<CreateAddressRequest> get copyWith => _$CreateAddressRequestCopyWithImpl<CreateAddressRequest>(this as CreateAddressRequest, _$identity);

  /// Serializes this CreateAddressRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateAddressRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateAddressRequest&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.street, _this.street) || other.street == _this.street)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.complement, _this.complement) || other.complement == _this.complement)&&(identical(other.neighborhood, _this.neighborhood) || other.neighborhood == _this.neighborhood)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.zipCode, _this.zipCode) || other.zipCode == _this.zipCode)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.isDefault, _this.isDefault) || other.isDefault == _this.isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateAddressRequest;
  return Object.hash(runtimeType,_this.label,_this.street,_this.number,_this.complement,_this.neighborhood,_this.city,_this.state,_this.zipCode,_this.latitude,_this.longitude,_this.isDefault);
}

@override
String toString() {
  final _this = this as CreateAddressRequest;
  return 'CreateAddressRequest(label: ${_this.label}, street: ${_this.street}, number: ${_this.number}, complement: ${_this.complement}, neighborhood: ${_this.neighborhood}, city: ${_this.city}, state: ${_this.state}, zipCode: ${_this.zipCode}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, isDefault: ${_this.isDefault})';
}


}

/// @nodoc
abstract mixin class $CreateAddressRequestCopyWith<$Res>  {
  factory $CreateAddressRequestCopyWith(CreateAddressRequest value, $Res Function(CreateAddressRequest) _then) = _$CreateAddressRequestCopyWithImpl;
@useResult
$Res call({
 String label, String street, String number, String? complement, String neighborhood, String city, String state, String zipCode, double latitude, double longitude, bool isDefault
});




}
/// @nodoc
class _$CreateAddressRequestCopyWithImpl<$Res>
    implements $CreateAddressRequestCopyWith<$Res> {
  _$CreateAddressRequestCopyWithImpl(this._self, this._then);

  final CreateAddressRequest _self;
  final $Res Function(CreateAddressRequest) _then;

/// Create a copy of CreateAddressRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? street = null,Object? number = null,Object? complement = freezed,Object? neighborhood = null,Object? city = null,Object? state = null,Object? zipCode = null,Object? latitude = null,Object? longitude = null,Object? isDefault = null,}) {
  return _then(CreateAddressRequest(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,complement: freezed == complement ? _self.complement : complement // ignore: cast_nullable_to_non_nullable
as String?,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,zipCode: null == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateAddressRequest].
extension CreateAddressRequestPatterns on CreateAddressRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateAddressRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateAddressRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateAddressRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateAddressRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateAddressRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateAddressRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String street,  String number,  String? complement,  String neighborhood,  String city,  String state,  String zipCode,  double latitude,  double longitude,  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateAddressRequest() when $default != null:
return $default(_that.label,_that.street,_that.number,_that.complement,_that.neighborhood,_that.city,_that.state,_that.zipCode,_that.latitude,_that.longitude,_that.isDefault);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String street,  String number,  String? complement,  String neighborhood,  String city,  String state,  String zipCode,  double latitude,  double longitude,  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _CreateAddressRequest():
return $default(_that.label,_that.street,_that.number,_that.complement,_that.neighborhood,_that.city,_that.state,_that.zipCode,_that.latitude,_that.longitude,_that.isDefault);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String street,  String number,  String? complement,  String neighborhood,  String city,  String state,  String zipCode,  double latitude,  double longitude,  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _CreateAddressRequest() when $default != null:
return $default(_that.label,_that.street,_that.number,_that.complement,_that.neighborhood,_that.city,_that.state,_that.zipCode,_that.latitude,_that.longitude,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateAddressRequest implements CreateAddressRequest {
  const _CreateAddressRequest({required this.label, required this.street, required this.number, this.complement, required this.neighborhood, required this.city, required this.state, required this.zipCode, required this.latitude, required this.longitude, required this.isDefault});
  factory _CreateAddressRequest.fromJson(Map<String, dynamic> json) => _$CreateAddressRequestFromJson(json);

@override final  String label;
@override final  String street;
@override final  String number;
@override final  String? complement;
@override final  String neighborhood;
@override final  String city;
@override final  String state;
@override final  String zipCode;
@override final  double latitude;
@override final  double longitude;
@override final  bool isDefault;

/// Create a copy of CreateAddressRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateAddressRequestCopyWith<_CreateAddressRequest> get copyWith => __$CreateAddressRequestCopyWithImpl<_CreateAddressRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateAddressRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateAddressRequest&&(identical(other.label, label) || other.label == label)&&(identical(other.street, street) || other.street == street)&&(identical(other.number, number) || other.number == number)&&(identical(other.complement, complement) || other.complement == complement)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,label,street,number,complement,neighborhood,city,state,zipCode,latitude,longitude,isDefault);
}

@override
String toString() {
    return 'CreateAddressRequest(label: $label, street: $street, number: $number, complement: $complement, neighborhood: $neighborhood, city: $city, state: $state, zipCode: $zipCode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$CreateAddressRequestCopyWith<$Res> implements $CreateAddressRequestCopyWith<$Res> {
  factory _$CreateAddressRequestCopyWith(_CreateAddressRequest value, $Res Function(_CreateAddressRequest) _then) = __$CreateAddressRequestCopyWithImpl;
@override @useResult
$Res call({
 String label, String street, String number, String? complement, String neighborhood, String city, String state, String zipCode, double latitude, double longitude, bool isDefault
});




}
/// @nodoc
class __$CreateAddressRequestCopyWithImpl<$Res>
    implements _$CreateAddressRequestCopyWith<$Res> {
  __$CreateAddressRequestCopyWithImpl(this._self, this._then);

  final _CreateAddressRequest _self;
  final $Res Function(_CreateAddressRequest) _then;

/// Create a copy of CreateAddressRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? street = null,Object? number = null,Object? complement = freezed,Object? neighborhood = null,Object? city = null,Object? state = null,Object? zipCode = null,Object? latitude = null,Object? longitude = null,Object? isDefault = null,}) {
  return _then(_CreateAddressRequest(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,complement: freezed == complement ? _self.complement : complement // ignore: cast_nullable_to_non_nullable
as String?,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,zipCode: null == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$UpdateAddressRequest {

 String get id; String? get label; String? get street; String? get number; String? get complement; String? get neighborhood; String? get city; String? get state; String? get zipCode; double? get latitude; double? get longitude; bool? get isDefault;
/// Create a copy of UpdateAddressRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateAddressRequestCopyWith<UpdateAddressRequest> get copyWith => _$UpdateAddressRequestCopyWithImpl<UpdateAddressRequest>(this as UpdateAddressRequest, _$identity);

  /// Serializes this UpdateAddressRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UpdateAddressRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateAddressRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.street, _this.street) || other.street == _this.street)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.complement, _this.complement) || other.complement == _this.complement)&&(identical(other.neighborhood, _this.neighborhood) || other.neighborhood == _this.neighborhood)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.zipCode, _this.zipCode) || other.zipCode == _this.zipCode)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.isDefault, _this.isDefault) || other.isDefault == _this.isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UpdateAddressRequest;
  return Object.hash(runtimeType,_this.id,_this.label,_this.street,_this.number,_this.complement,_this.neighborhood,_this.city,_this.state,_this.zipCode,_this.latitude,_this.longitude,_this.isDefault);
}

@override
String toString() {
  final _this = this as UpdateAddressRequest;
  return 'UpdateAddressRequest(id: ${_this.id}, label: ${_this.label}, street: ${_this.street}, number: ${_this.number}, complement: ${_this.complement}, neighborhood: ${_this.neighborhood}, city: ${_this.city}, state: ${_this.state}, zipCode: ${_this.zipCode}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, isDefault: ${_this.isDefault})';
}


}

/// @nodoc
abstract mixin class $UpdateAddressRequestCopyWith<$Res>  {
  factory $UpdateAddressRequestCopyWith(UpdateAddressRequest value, $Res Function(UpdateAddressRequest) _then) = _$UpdateAddressRequestCopyWithImpl;
@useResult
$Res call({
 String id, String? label, String? street, String? number, String? complement, String? neighborhood, String? city, String? state, String? zipCode, double? latitude, double? longitude, bool? isDefault
});




}
/// @nodoc
class _$UpdateAddressRequestCopyWithImpl<$Res>
    implements $UpdateAddressRequestCopyWith<$Res> {
  _$UpdateAddressRequestCopyWithImpl(this._self, this._then);

  final UpdateAddressRequest _self;
  final $Res Function(UpdateAddressRequest) _then;

/// Create a copy of UpdateAddressRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = freezed,Object? street = freezed,Object? number = freezed,Object? complement = freezed,Object? neighborhood = freezed,Object? city = freezed,Object? state = freezed,Object? zipCode = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isDefault = freezed,}) {
  return _then(UpdateAddressRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String?,complement: freezed == complement ? _self.complement : complement // ignore: cast_nullable_to_non_nullable
as String?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,zipCode: freezed == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateAddressRequest].
extension UpdateAddressRequestPatterns on UpdateAddressRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateAddressRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateAddressRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateAddressRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateAddressRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateAddressRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateAddressRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? label,  String? street,  String? number,  String? complement,  String? neighborhood,  String? city,  String? state,  String? zipCode,  double? latitude,  double? longitude,  bool? isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateAddressRequest() when $default != null:
return $default(_that.id,_that.label,_that.street,_that.number,_that.complement,_that.neighborhood,_that.city,_that.state,_that.zipCode,_that.latitude,_that.longitude,_that.isDefault);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? label,  String? street,  String? number,  String? complement,  String? neighborhood,  String? city,  String? state,  String? zipCode,  double? latitude,  double? longitude,  bool? isDefault)  $default,) {final _that = this;
switch (_that) {
case _UpdateAddressRequest():
return $default(_that.id,_that.label,_that.street,_that.number,_that.complement,_that.neighborhood,_that.city,_that.state,_that.zipCode,_that.latitude,_that.longitude,_that.isDefault);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? label,  String? street,  String? number,  String? complement,  String? neighborhood,  String? city,  String? state,  String? zipCode,  double? latitude,  double? longitude,  bool? isDefault)?  $default,) {final _that = this;
switch (_that) {
case _UpdateAddressRequest() when $default != null:
return $default(_that.id,_that.label,_that.street,_that.number,_that.complement,_that.neighborhood,_that.city,_that.state,_that.zipCode,_that.latitude,_that.longitude,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateAddressRequest implements UpdateAddressRequest {
  const _UpdateAddressRequest({required this.id, this.label, this.street, this.number, this.complement, this.neighborhood, this.city, this.state, this.zipCode, this.latitude, this.longitude, this.isDefault});
  factory _UpdateAddressRequest.fromJson(Map<String, dynamic> json) => _$UpdateAddressRequestFromJson(json);

@override final  String id;
@override final  String? label;
@override final  String? street;
@override final  String? number;
@override final  String? complement;
@override final  String? neighborhood;
@override final  String? city;
@override final  String? state;
@override final  String? zipCode;
@override final  double? latitude;
@override final  double? longitude;
@override final  bool? isDefault;

/// Create a copy of UpdateAddressRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateAddressRequestCopyWith<_UpdateAddressRequest> get copyWith => __$UpdateAddressRequestCopyWithImpl<_UpdateAddressRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateAddressRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateAddressRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.street, street) || other.street == street)&&(identical(other.number, number) || other.number == number)&&(identical(other.complement, complement) || other.complement == complement)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,label,street,number,complement,neighborhood,city,state,zipCode,latitude,longitude,isDefault);
}

@override
String toString() {
    return 'UpdateAddressRequest(id: $id, label: $label, street: $street, number: $number, complement: $complement, neighborhood: $neighborhood, city: $city, state: $state, zipCode: $zipCode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$UpdateAddressRequestCopyWith<$Res> implements $UpdateAddressRequestCopyWith<$Res> {
  factory _$UpdateAddressRequestCopyWith(_UpdateAddressRequest value, $Res Function(_UpdateAddressRequest) _then) = __$UpdateAddressRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String? label, String? street, String? number, String? complement, String? neighborhood, String? city, String? state, String? zipCode, double? latitude, double? longitude, bool? isDefault
});




}
/// @nodoc
class __$UpdateAddressRequestCopyWithImpl<$Res>
    implements _$UpdateAddressRequestCopyWith<$Res> {
  __$UpdateAddressRequestCopyWithImpl(this._self, this._then);

  final _UpdateAddressRequest _self;
  final $Res Function(_UpdateAddressRequest) _then;

/// Create a copy of UpdateAddressRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = freezed,Object? street = freezed,Object? number = freezed,Object? complement = freezed,Object? neighborhood = freezed,Object? city = freezed,Object? state = freezed,Object? zipCode = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isDefault = freezed,}) {
  return _then(_UpdateAddressRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String?,complement: freezed == complement ? _self.complement : complement // ignore: cast_nullable_to_non_nullable
as String?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,zipCode: freezed == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
