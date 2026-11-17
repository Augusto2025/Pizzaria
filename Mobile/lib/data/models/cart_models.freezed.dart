// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartItemDto {

 String get id; String get userId; String get productId; int get quantity; String get selectedCustomizationsJson; String? get notes; DateTime get createdAt; ProductDto get product;
/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemDtoCopyWith<CartItemDto> get copyWith => _$CartItemDtoCopyWithImpl<CartItemDto>(this as CartItemDto, _$identity);

  /// Serializes this CartItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CartItemDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.selectedCustomizationsJson, _this.selectedCustomizationsJson) || other.selectedCustomizationsJson == _this.selectedCustomizationsJson)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.product, _this.product) || other.product == _this.product));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CartItemDto;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.productId,_this.quantity,_this.selectedCustomizationsJson,_this.notes,_this.createdAt,_this.product);
}

@override
String toString() {
  final _this = this as CartItemDto;
  return 'CartItemDto(id: ${_this.id}, userId: ${_this.userId}, productId: ${_this.productId}, quantity: ${_this.quantity}, selectedCustomizationsJson: ${_this.selectedCustomizationsJson}, notes: ${_this.notes}, createdAt: ${_this.createdAt}, product: ${_this.product})';
}


}

/// @nodoc
abstract mixin class $CartItemDtoCopyWith<$Res>  {
  factory $CartItemDtoCopyWith(CartItemDto value, $Res Function(CartItemDto) _then) = _$CartItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String productId, int quantity, String selectedCustomizationsJson, String? notes, DateTime createdAt, ProductDto product
});


$ProductDtoCopyWith<$Res> get product;

}
/// @nodoc
class _$CartItemDtoCopyWithImpl<$Res>
    implements $CartItemDtoCopyWith<$Res> {
  _$CartItemDtoCopyWithImpl(this._self, this._then);

  final CartItemDto _self;
  final $Res Function(CartItemDto) _then;

/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? productId = null,Object? quantity = null,Object? selectedCustomizationsJson = null,Object? notes = freezed,Object? createdAt = null,Object? product = null,}) {
  return _then(CartItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedCustomizationsJson: null == selectedCustomizationsJson ? _self.selectedCustomizationsJson : selectedCustomizationsJson // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductDto,
  ));
}
/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDtoCopyWith<$Res> get product {
  
  return $ProductDtoCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}


/// Adds pattern-matching-related methods to [CartItemDto].
extension CartItemDtoPatterns on CartItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItemDto value)  $default,){
final _that = this;
switch (_that) {
case _CartItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String productId,  int quantity,  String selectedCustomizationsJson,  String? notes,  DateTime createdAt,  ProductDto product)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
return $default(_that.id,_that.userId,_that.productId,_that.quantity,_that.selectedCustomizationsJson,_that.notes,_that.createdAt,_that.product);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String productId,  int quantity,  String selectedCustomizationsJson,  String? notes,  DateTime createdAt,  ProductDto product)  $default,) {final _that = this;
switch (_that) {
case _CartItemDto():
return $default(_that.id,_that.userId,_that.productId,_that.quantity,_that.selectedCustomizationsJson,_that.notes,_that.createdAt,_that.product);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String productId,  int quantity,  String selectedCustomizationsJson,  String? notes,  DateTime createdAt,  ProductDto product)?  $default,) {final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
return $default(_that.id,_that.userId,_that.productId,_that.quantity,_that.selectedCustomizationsJson,_that.notes,_that.createdAt,_that.product);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartItemDto implements CartItemDto {
  const _CartItemDto({required this.id, required this.userId, required this.productId, required this.quantity, required this.selectedCustomizationsJson, this.notes, required this.createdAt, required this.product});
  factory _CartItemDto.fromJson(Map<String, dynamic> json) => _$CartItemDtoFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String productId;
@override final  int quantity;
@override final  String selectedCustomizationsJson;
@override final  String? notes;
@override final  DateTime createdAt;
@override final  ProductDto product;

/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemDtoCopyWith<_CartItemDto> get copyWith => __$CartItemDtoCopyWithImpl<_CartItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.selectedCustomizationsJson, selectedCustomizationsJson) || other.selectedCustomizationsJson == selectedCustomizationsJson)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.product, product) || other.product == product));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,productId,quantity,selectedCustomizationsJson,notes,createdAt,product);
}

@override
String toString() {
    return 'CartItemDto(id: $id, userId: $userId, productId: $productId, quantity: $quantity, selectedCustomizationsJson: $selectedCustomizationsJson, notes: $notes, createdAt: $createdAt, product: $product)';
}


}

/// @nodoc
abstract mixin class _$CartItemDtoCopyWith<$Res> implements $CartItemDtoCopyWith<$Res> {
  factory _$CartItemDtoCopyWith(_CartItemDto value, $Res Function(_CartItemDto) _then) = __$CartItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String productId, int quantity, String selectedCustomizationsJson, String? notes, DateTime createdAt, ProductDto product
});


@override $ProductDtoCopyWith<$Res> get product;

}
/// @nodoc
class __$CartItemDtoCopyWithImpl<$Res>
    implements _$CartItemDtoCopyWith<$Res> {
  __$CartItemDtoCopyWithImpl(this._self, this._then);

  final _CartItemDto _self;
  final $Res Function(_CartItemDto) _then;

/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? productId = null,Object? quantity = null,Object? selectedCustomizationsJson = null,Object? notes = freezed,Object? createdAt = null,Object? product = null,}) {
  return _then(_CartItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedCustomizationsJson: null == selectedCustomizationsJson ? _self.selectedCustomizationsJson : selectedCustomizationsJson // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductDto,
  ));
}

/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDtoCopyWith<$Res> get product {
  
  return $ProductDtoCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}


/// @nodoc
mixin _$CartResponse {

 List<CartItemDto> get items; double get subtotal;
/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartResponseCopyWith<CartResponse> get copyWith => _$CartResponseCopyWithImpl<CartResponse>(this as CartResponse, _$identity);

  /// Serializes this CartResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CartResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartResponse&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.subtotal, _this.subtotal) || other.subtotal == _this.subtotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CartResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.subtotal);
}

@override
String toString() {
  final _this = this as CartResponse;
  return 'CartResponse(items: ${_this.items}, subtotal: ${_this.subtotal})';
}


}

/// @nodoc
abstract mixin class $CartResponseCopyWith<$Res>  {
  factory $CartResponseCopyWith(CartResponse value, $Res Function(CartResponse) _then) = _$CartResponseCopyWithImpl;
@useResult
$Res call({
 List<CartItemDto> items, double subtotal
});




}
/// @nodoc
class _$CartResponseCopyWithImpl<$Res>
    implements $CartResponseCopyWith<$Res> {
  _$CartResponseCopyWithImpl(this._self, this._then);

  final CartResponse _self;
  final $Res Function(CartResponse) _then;

/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? subtotal = null,}) {
  return _then(CartResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemDto>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CartResponse].
extension CartResponsePatterns on CartResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartResponse value)  $default,){
final _that = this;
switch (_that) {
case _CartResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CartItemDto> items,  double subtotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
return $default(_that.items,_that.subtotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CartItemDto> items,  double subtotal)  $default,) {final _that = this;
switch (_that) {
case _CartResponse():
return $default(_that.items,_that.subtotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CartItemDto> items,  double subtotal)?  $default,) {final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
return $default(_that.items,_that.subtotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartResponse implements CartResponse {
  const _CartResponse({ List<CartItemDto> items = const [], required this.subtotal}): _items = items;
  factory _CartResponse.fromJson(Map<String, dynamic> json) => _$CartResponseFromJson(json);

 final  List<CartItemDto> _items;
@override@JsonKey() List<CartItemDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  double subtotal;

/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartResponseCopyWith<_CartResponse> get copyWith => __$CartResponseCopyWithImpl<_CartResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartResponse&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),subtotal);
}

@override
String toString() {
    return 'CartResponse(items: $items, subtotal: $subtotal)';
}


}

/// @nodoc
abstract mixin class _$CartResponseCopyWith<$Res> implements $CartResponseCopyWith<$Res> {
  factory _$CartResponseCopyWith(_CartResponse value, $Res Function(_CartResponse) _then) = __$CartResponseCopyWithImpl;
@override @useResult
$Res call({
 List<CartItemDto> items, double subtotal
});




}
/// @nodoc
class __$CartResponseCopyWithImpl<$Res>
    implements _$CartResponseCopyWith<$Res> {
  __$CartResponseCopyWithImpl(this._self, this._then);

  final _CartResponse _self;
  final $Res Function(_CartResponse) _then;

/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? subtotal = null,}) {
  return _then(_CartResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemDto>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$AddCartItemRequest {

 String get productId; int get quantity; Map<String, String>? get selectedCustomizations; String? get notes;
/// Create a copy of AddCartItemRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddCartItemRequestCopyWith<AddCartItemRequest> get copyWith => _$AddCartItemRequestCopyWithImpl<AddCartItemRequest>(this as AddCartItemRequest, _$identity);

  /// Serializes this AddCartItemRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AddCartItemRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddCartItemRequest&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&const DeepCollectionEquality().equals(other.selectedCustomizations, _this.selectedCustomizations)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AddCartItemRequest;
  return Object.hash(runtimeType,_this.productId,_this.quantity,const DeepCollectionEquality().hash(_this.selectedCustomizations),_this.notes);
}

@override
String toString() {
  final _this = this as AddCartItemRequest;
  return 'AddCartItemRequest(productId: ${_this.productId}, quantity: ${_this.quantity}, selectedCustomizations: ${_this.selectedCustomizations}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $AddCartItemRequestCopyWith<$Res>  {
  factory $AddCartItemRequestCopyWith(AddCartItemRequest value, $Res Function(AddCartItemRequest) _then) = _$AddCartItemRequestCopyWithImpl;
@useResult
$Res call({
 String productId, int quantity, Map<String, String>? selectedCustomizations, String? notes
});




}
/// @nodoc
class _$AddCartItemRequestCopyWithImpl<$Res>
    implements $AddCartItemRequestCopyWith<$Res> {
  _$AddCartItemRequestCopyWithImpl(this._self, this._then);

  final AddCartItemRequest _self;
  final $Res Function(AddCartItemRequest) _then;

/// Create a copy of AddCartItemRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? quantity = null,Object? selectedCustomizations = freezed,Object? notes = freezed,}) {
  return _then(AddCartItemRequest(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedCustomizations: freezed == selectedCustomizations ? _self.selectedCustomizations : selectedCustomizations // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddCartItemRequest].
extension AddCartItemRequestPatterns on AddCartItemRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddCartItemRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddCartItemRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddCartItemRequest value)  $default,){
final _that = this;
switch (_that) {
case _AddCartItemRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddCartItemRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AddCartItemRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  int quantity,  Map<String, String>? selectedCustomizations,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddCartItemRequest() when $default != null:
return $default(_that.productId,_that.quantity,_that.selectedCustomizations,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  int quantity,  Map<String, String>? selectedCustomizations,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _AddCartItemRequest():
return $default(_that.productId,_that.quantity,_that.selectedCustomizations,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  int quantity,  Map<String, String>? selectedCustomizations,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _AddCartItemRequest() when $default != null:
return $default(_that.productId,_that.quantity,_that.selectedCustomizations,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddCartItemRequest implements AddCartItemRequest {
  const _AddCartItemRequest({required this.productId, required this.quantity,  Map<String, String>? selectedCustomizations, this.notes}): _selectedCustomizations = selectedCustomizations;
  factory _AddCartItemRequest.fromJson(Map<String, dynamic> json) => _$AddCartItemRequestFromJson(json);

@override final  String productId;
@override final  int quantity;
 final  Map<String, String>? _selectedCustomizations;
@override Map<String, String>? get selectedCustomizations {
  final value = _selectedCustomizations;
  if (value == null) return null;
  if (_selectedCustomizations is EqualUnmodifiableMapView) return _selectedCustomizations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? notes;

/// Create a copy of AddCartItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddCartItemRequestCopyWith<_AddCartItemRequest> get copyWith => __$AddCartItemRequestCopyWithImpl<_AddCartItemRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddCartItemRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddCartItemRequest&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&const DeepCollectionEquality().equals(other.selectedCustomizations, _selectedCustomizations)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,productId,quantity,const DeepCollectionEquality().hash(_selectedCustomizations),notes);
}

@override
String toString() {
    return 'AddCartItemRequest(productId: $productId, quantity: $quantity, selectedCustomizations: $selectedCustomizations, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$AddCartItemRequestCopyWith<$Res> implements $AddCartItemRequestCopyWith<$Res> {
  factory _$AddCartItemRequestCopyWith(_AddCartItemRequest value, $Res Function(_AddCartItemRequest) _then) = __$AddCartItemRequestCopyWithImpl;
@override @useResult
$Res call({
 String productId, int quantity, Map<String, String>? selectedCustomizations, String? notes
});




}
/// @nodoc
class __$AddCartItemRequestCopyWithImpl<$Res>
    implements _$AddCartItemRequestCopyWith<$Res> {
  __$AddCartItemRequestCopyWithImpl(this._self, this._then);

  final _AddCartItemRequest _self;
  final $Res Function(_AddCartItemRequest) _then;

/// Create a copy of AddCartItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? quantity = null,Object? selectedCustomizations = freezed,Object? notes = freezed,}) {
  return _then(_AddCartItemRequest(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedCustomizations: freezed == selectedCustomizations ? _self._selectedCustomizations : selectedCustomizations // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UpdateCartItemRequest {

 int get quantity; Map<String, String>? get selectedCustomizations; String? get notes;
/// Create a copy of UpdateCartItemRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCartItemRequestCopyWith<UpdateCartItemRequest> get copyWith => _$UpdateCartItemRequestCopyWithImpl<UpdateCartItemRequest>(this as UpdateCartItemRequest, _$identity);

  /// Serializes this UpdateCartItemRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UpdateCartItemRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCartItemRequest&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&const DeepCollectionEquality().equals(other.selectedCustomizations, _this.selectedCustomizations)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UpdateCartItemRequest;
  return Object.hash(runtimeType,_this.quantity,const DeepCollectionEquality().hash(_this.selectedCustomizations),_this.notes);
}

@override
String toString() {
  final _this = this as UpdateCartItemRequest;
  return 'UpdateCartItemRequest(quantity: ${_this.quantity}, selectedCustomizations: ${_this.selectedCustomizations}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $UpdateCartItemRequestCopyWith<$Res>  {
  factory $UpdateCartItemRequestCopyWith(UpdateCartItemRequest value, $Res Function(UpdateCartItemRequest) _then) = _$UpdateCartItemRequestCopyWithImpl;
@useResult
$Res call({
 int quantity, Map<String, String>? selectedCustomizations, String? notes
});




}
/// @nodoc
class _$UpdateCartItemRequestCopyWithImpl<$Res>
    implements $UpdateCartItemRequestCopyWith<$Res> {
  _$UpdateCartItemRequestCopyWithImpl(this._self, this._then);

  final UpdateCartItemRequest _self;
  final $Res Function(UpdateCartItemRequest) _then;

/// Create a copy of UpdateCartItemRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quantity = null,Object? selectedCustomizations = freezed,Object? notes = freezed,}) {
  return _then(UpdateCartItemRequest(
quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedCustomizations: freezed == selectedCustomizations ? _self.selectedCustomizations : selectedCustomizations // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateCartItemRequest].
extension UpdateCartItemRequestPatterns on UpdateCartItemRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateCartItemRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateCartItemRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateCartItemRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateCartItemRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateCartItemRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateCartItemRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int quantity,  Map<String, String>? selectedCustomizations,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateCartItemRequest() when $default != null:
return $default(_that.quantity,_that.selectedCustomizations,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int quantity,  Map<String, String>? selectedCustomizations,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _UpdateCartItemRequest():
return $default(_that.quantity,_that.selectedCustomizations,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int quantity,  Map<String, String>? selectedCustomizations,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _UpdateCartItemRequest() when $default != null:
return $default(_that.quantity,_that.selectedCustomizations,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateCartItemRequest implements UpdateCartItemRequest {
  const _UpdateCartItemRequest({required this.quantity,  Map<String, String>? selectedCustomizations, this.notes}): _selectedCustomizations = selectedCustomizations;
  factory _UpdateCartItemRequest.fromJson(Map<String, dynamic> json) => _$UpdateCartItemRequestFromJson(json);

@override final  int quantity;
 final  Map<String, String>? _selectedCustomizations;
@override Map<String, String>? get selectedCustomizations {
  final value = _selectedCustomizations;
  if (value == null) return null;
  if (_selectedCustomizations is EqualUnmodifiableMapView) return _selectedCustomizations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? notes;

/// Create a copy of UpdateCartItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCartItemRequestCopyWith<_UpdateCartItemRequest> get copyWith => __$UpdateCartItemRequestCopyWithImpl<_UpdateCartItemRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateCartItemRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCartItemRequest&&(identical(other.quantity, quantity) || other.quantity == quantity)&&const DeepCollectionEquality().equals(other.selectedCustomizations, _selectedCustomizations)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,quantity,const DeepCollectionEquality().hash(_selectedCustomizations),notes);
}

@override
String toString() {
    return 'UpdateCartItemRequest(quantity: $quantity, selectedCustomizations: $selectedCustomizations, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$UpdateCartItemRequestCopyWith<$Res> implements $UpdateCartItemRequestCopyWith<$Res> {
  factory _$UpdateCartItemRequestCopyWith(_UpdateCartItemRequest value, $Res Function(_UpdateCartItemRequest) _then) = __$UpdateCartItemRequestCopyWithImpl;
@override @useResult
$Res call({
 int quantity, Map<String, String>? selectedCustomizations, String? notes
});




}
/// @nodoc
class __$UpdateCartItemRequestCopyWithImpl<$Res>
    implements _$UpdateCartItemRequestCopyWith<$Res> {
  __$UpdateCartItemRequestCopyWithImpl(this._self, this._then);

  final _UpdateCartItemRequest _self;
  final $Res Function(_UpdateCartItemRequest) _then;

/// Create a copy of UpdateCartItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quantity = null,Object? selectedCustomizations = freezed,Object? notes = freezed,}) {
  return _then(_UpdateCartItemRequest(
quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedCustomizations: freezed == selectedCustomizations ? _self._selectedCustomizations : selectedCustomizations // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
