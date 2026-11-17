// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderStatusDto {

 int get value; String get label; String get color;
/// Create a copy of OrderStatusDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderStatusDtoCopyWith<OrderStatusDto> get copyWith => _$OrderStatusDtoCopyWithImpl<OrderStatusDto>(this as OrderStatusDto, _$identity);

  /// Serializes this OrderStatusDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrderStatusDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderStatusDto&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.color, _this.color) || other.color == _this.color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrderStatusDto;
  return Object.hash(runtimeType,_this.value,_this.label,_this.color);
}

@override
String toString() {
  final _this = this as OrderStatusDto;
  return 'OrderStatusDto(value: ${_this.value}, label: ${_this.label}, color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $OrderStatusDtoCopyWith<$Res>  {
  factory $OrderStatusDtoCopyWith(OrderStatusDto value, $Res Function(OrderStatusDto) _then) = _$OrderStatusDtoCopyWithImpl;
@useResult
$Res call({
 int value, String label, String color
});




}
/// @nodoc
class _$OrderStatusDtoCopyWithImpl<$Res>
    implements $OrderStatusDtoCopyWith<$Res> {
  _$OrderStatusDtoCopyWithImpl(this._self, this._then);

  final OrderStatusDto _self;
  final $Res Function(OrderStatusDto) _then;

/// Create a copy of OrderStatusDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? label = null,Object? color = null,}) {
  return _then(OrderStatusDto(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderStatusDto].
extension OrderStatusDtoPatterns on OrderStatusDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderStatusDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderStatusDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderStatusDto value)  $default,){
final _that = this;
switch (_that) {
case _OrderStatusDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderStatusDto value)?  $default,){
final _that = this;
switch (_that) {
case _OrderStatusDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int value,  String label,  String color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderStatusDto() when $default != null:
return $default(_that.value,_that.label,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int value,  String label,  String color)  $default,) {final _that = this;
switch (_that) {
case _OrderStatusDto():
return $default(_that.value,_that.label,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int value,  String label,  String color)?  $default,) {final _that = this;
switch (_that) {
case _OrderStatusDto() when $default != null:
return $default(_that.value,_that.label,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderStatusDto implements OrderStatusDto {
  const _OrderStatusDto({required this.value, required this.label, required this.color});
  factory _OrderStatusDto.fromJson(Map<String, dynamic> json) => _$OrderStatusDtoFromJson(json);

@override final  int value;
@override final  String label;
@override final  String color;

/// Create a copy of OrderStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderStatusDtoCopyWith<_OrderStatusDto> get copyWith => __$OrderStatusDtoCopyWithImpl<_OrderStatusDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderStatusDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderStatusDto&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,value,label,color);
}

@override
String toString() {
    return 'OrderStatusDto(value: $value, label: $label, color: $color)';
}


}

/// @nodoc
abstract mixin class _$OrderStatusDtoCopyWith<$Res> implements $OrderStatusDtoCopyWith<$Res> {
  factory _$OrderStatusDtoCopyWith(_OrderStatusDto value, $Res Function(_OrderStatusDto) _then) = __$OrderStatusDtoCopyWithImpl;
@override @useResult
$Res call({
 int value, String label, String color
});




}
/// @nodoc
class __$OrderStatusDtoCopyWithImpl<$Res>
    implements _$OrderStatusDtoCopyWith<$Res> {
  __$OrderStatusDtoCopyWithImpl(this._self, this._then);

  final _OrderStatusDto _self;
  final $Res Function(_OrderStatusDto) _then;

/// Create a copy of OrderStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? label = null,Object? color = null,}) {
  return _then(_OrderStatusDto(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StatusTimelineDto {

 int get id; OrderStatusDto get status; DateTime get timestamp; String get note;
/// Create a copy of StatusTimelineDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusTimelineDtoCopyWith<StatusTimelineDto> get copyWith => _$StatusTimelineDtoCopyWithImpl<StatusTimelineDto>(this as StatusTimelineDto, _$identity);

  /// Serializes this StatusTimelineDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StatusTimelineDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusTimelineDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp)&&(identical(other.note, _this.note) || other.note == _this.note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StatusTimelineDto;
  return Object.hash(runtimeType,_this.id,_this.status,_this.timestamp,_this.note);
}

@override
String toString() {
  final _this = this as StatusTimelineDto;
  return 'StatusTimelineDto(id: ${_this.id}, status: ${_this.status}, timestamp: ${_this.timestamp}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $StatusTimelineDtoCopyWith<$Res>  {
  factory $StatusTimelineDtoCopyWith(StatusTimelineDto value, $Res Function(StatusTimelineDto) _then) = _$StatusTimelineDtoCopyWithImpl;
@useResult
$Res call({
 int id, OrderStatusDto status, DateTime timestamp, String note
});


$OrderStatusDtoCopyWith<$Res> get status;

}
/// @nodoc
class _$StatusTimelineDtoCopyWithImpl<$Res>
    implements $StatusTimelineDtoCopyWith<$Res> {
  _$StatusTimelineDtoCopyWithImpl(this._self, this._then);

  final StatusTimelineDto _self;
  final $Res Function(StatusTimelineDto) _then;

/// Create a copy of StatusTimelineDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? timestamp = null,Object? note = null,}) {
  return _then(StatusTimelineDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatusDto,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of StatusTimelineDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderStatusDtoCopyWith<$Res> get status {
  
  return $OrderStatusDtoCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [StatusTimelineDto].
extension StatusTimelineDtoPatterns on StatusTimelineDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatusTimelineDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatusTimelineDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatusTimelineDto value)  $default,){
final _that = this;
switch (_that) {
case _StatusTimelineDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatusTimelineDto value)?  $default,){
final _that = this;
switch (_that) {
case _StatusTimelineDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  OrderStatusDto status,  DateTime timestamp,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatusTimelineDto() when $default != null:
return $default(_that.id,_that.status,_that.timestamp,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  OrderStatusDto status,  DateTime timestamp,  String note)  $default,) {final _that = this;
switch (_that) {
case _StatusTimelineDto():
return $default(_that.id,_that.status,_that.timestamp,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  OrderStatusDto status,  DateTime timestamp,  String note)?  $default,) {final _that = this;
switch (_that) {
case _StatusTimelineDto() when $default != null:
return $default(_that.id,_that.status,_that.timestamp,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatusTimelineDto implements StatusTimelineDto {
  const _StatusTimelineDto({required this.id, required this.status, required this.timestamp, required this.note});
  factory _StatusTimelineDto.fromJson(Map<String, dynamic> json) => _$StatusTimelineDtoFromJson(json);

@override final  int id;
@override final  OrderStatusDto status;
@override final  DateTime timestamp;
@override final  String note;

/// Create a copy of StatusTimelineDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusTimelineDtoCopyWith<_StatusTimelineDto> get copyWith => __$StatusTimelineDtoCopyWithImpl<_StatusTimelineDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatusTimelineDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusTimelineDto&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,status,timestamp,note);
}

@override
String toString() {
    return 'StatusTimelineDto(id: $id, status: $status, timestamp: $timestamp, note: $note)';
}


}

/// @nodoc
abstract mixin class _$StatusTimelineDtoCopyWith<$Res> implements $StatusTimelineDtoCopyWith<$Res> {
  factory _$StatusTimelineDtoCopyWith(_StatusTimelineDto value, $Res Function(_StatusTimelineDto) _then) = __$StatusTimelineDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, OrderStatusDto status, DateTime timestamp, String note
});


@override $OrderStatusDtoCopyWith<$Res> get status;

}
/// @nodoc
class __$StatusTimelineDtoCopyWithImpl<$Res>
    implements _$StatusTimelineDtoCopyWith<$Res> {
  __$StatusTimelineDtoCopyWithImpl(this._self, this._then);

  final _StatusTimelineDto _self;
  final $Res Function(_StatusTimelineDto) _then;

/// Create a copy of StatusTimelineDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? timestamp = null,Object? note = null,}) {
  return _then(_StatusTimelineDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatusDto,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of StatusTimelineDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderStatusDtoCopyWith<$Res> get status {
  
  return $OrderStatusDtoCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// @nodoc
mixin _$OrderItemDto {

 String get id; String get productId; String get productName; String get productImageUrl; int get quantity; double get unitPrice; Map<String, String> get customizations; String? get notes; double get totalPrice;
/// Create a copy of OrderItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemDtoCopyWith<OrderItemDto> get copyWith => _$OrderItemDtoCopyWithImpl<OrderItemDto>(this as OrderItemDto, _$identity);

  /// Serializes this OrderItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrderItemDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItemDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.productName, _this.productName) || other.productName == _this.productName)&&(identical(other.productImageUrl, _this.productImageUrl) || other.productImageUrl == _this.productImageUrl)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.unitPrice, _this.unitPrice) || other.unitPrice == _this.unitPrice)&&const DeepCollectionEquality().equals(other.customizations, _this.customizations)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.totalPrice, _this.totalPrice) || other.totalPrice == _this.totalPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrderItemDto;
  return Object.hash(runtimeType,_this.id,_this.productId,_this.productName,_this.productImageUrl,_this.quantity,_this.unitPrice,const DeepCollectionEquality().hash(_this.customizations),_this.notes,_this.totalPrice);
}

@override
String toString() {
  final _this = this as OrderItemDto;
  return 'OrderItemDto(id: ${_this.id}, productId: ${_this.productId}, productName: ${_this.productName}, productImageUrl: ${_this.productImageUrl}, quantity: ${_this.quantity}, unitPrice: ${_this.unitPrice}, customizations: ${_this.customizations}, notes: ${_this.notes}, totalPrice: ${_this.totalPrice})';
}


}

/// @nodoc
abstract mixin class $OrderItemDtoCopyWith<$Res>  {
  factory $OrderItemDtoCopyWith(OrderItemDto value, $Res Function(OrderItemDto) _then) = _$OrderItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String productId, String productName, String productImageUrl, int quantity, double unitPrice, Map<String, String> customizations, String? notes, double totalPrice
});




}
/// @nodoc
class _$OrderItemDtoCopyWithImpl<$Res>
    implements $OrderItemDtoCopyWith<$Res> {
  _$OrderItemDtoCopyWithImpl(this._self, this._then);

  final OrderItemDto _self;
  final $Res Function(OrderItemDto) _then;

/// Create a copy of OrderItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? productName = null,Object? productImageUrl = null,Object? quantity = null,Object? unitPrice = null,Object? customizations = null,Object? notes = freezed,Object? totalPrice = null,}) {
  return _then(OrderItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productImageUrl: null == productImageUrl ? _self.productImageUrl : productImageUrl // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,customizations: null == customizations ? _self.customizations : customizations // ignore: cast_nullable_to_non_nullable
as Map<String, String>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderItemDto].
extension OrderItemDtoPatterns on OrderItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderItemDto value)  $default,){
final _that = this;
switch (_that) {
case _OrderItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _OrderItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String productId,  String productName,  String productImageUrl,  int quantity,  double unitPrice,  Map<String, String> customizations,  String? notes,  double totalPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderItemDto() when $default != null:
return $default(_that.id,_that.productId,_that.productName,_that.productImageUrl,_that.quantity,_that.unitPrice,_that.customizations,_that.notes,_that.totalPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String productId,  String productName,  String productImageUrl,  int quantity,  double unitPrice,  Map<String, String> customizations,  String? notes,  double totalPrice)  $default,) {final _that = this;
switch (_that) {
case _OrderItemDto():
return $default(_that.id,_that.productId,_that.productName,_that.productImageUrl,_that.quantity,_that.unitPrice,_that.customizations,_that.notes,_that.totalPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String productId,  String productName,  String productImageUrl,  int quantity,  double unitPrice,  Map<String, String> customizations,  String? notes,  double totalPrice)?  $default,) {final _that = this;
switch (_that) {
case _OrderItemDto() when $default != null:
return $default(_that.id,_that.productId,_that.productName,_that.productImageUrl,_that.quantity,_that.unitPrice,_that.customizations,_that.notes,_that.totalPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderItemDto implements OrderItemDto {
  const _OrderItemDto({required this.id, required this.productId, required this.productName, required this.productImageUrl, required this.quantity, required this.unitPrice, required  Map<String, String> customizations, this.notes, required this.totalPrice}): _customizations = customizations;
  factory _OrderItemDto.fromJson(Map<String, dynamic> json) => _$OrderItemDtoFromJson(json);

@override final  String id;
@override final  String productId;
@override final  String productName;
@override final  String productImageUrl;
@override final  int quantity;
@override final  double unitPrice;
 final  Map<String, String> _customizations;
@override Map<String, String> get customizations {
  if (_customizations is EqualUnmodifiableMapView) return _customizations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_customizations);
}

@override final  String? notes;
@override final  double totalPrice;

/// Create a copy of OrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemDtoCopyWith<_OrderItemDto> get copyWith => __$OrderItemDtoCopyWithImpl<_OrderItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productImageUrl, productImageUrl) || other.productImageUrl == productImageUrl)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&const DeepCollectionEquality().equals(other.customizations, _customizations)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,productId,productName,productImageUrl,quantity,unitPrice,const DeepCollectionEquality().hash(_customizations),notes,totalPrice);
}

@override
String toString() {
    return 'OrderItemDto(id: $id, productId: $productId, productName: $productName, productImageUrl: $productImageUrl, quantity: $quantity, unitPrice: $unitPrice, customizations: $customizations, notes: $notes, totalPrice: $totalPrice)';
}


}

/// @nodoc
abstract mixin class _$OrderItemDtoCopyWith<$Res> implements $OrderItemDtoCopyWith<$Res> {
  factory _$OrderItemDtoCopyWith(_OrderItemDto value, $Res Function(_OrderItemDto) _then) = __$OrderItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, String productName, String productImageUrl, int quantity, double unitPrice, Map<String, String> customizations, String? notes, double totalPrice
});




}
/// @nodoc
class __$OrderItemDtoCopyWithImpl<$Res>
    implements _$OrderItemDtoCopyWith<$Res> {
  __$OrderItemDtoCopyWithImpl(this._self, this._then);

  final _OrderItemDto _self;
  final $Res Function(_OrderItemDto) _then;

/// Create a copy of OrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? productName = null,Object? productImageUrl = null,Object? quantity = null,Object? unitPrice = null,Object? customizations = null,Object? notes = freezed,Object? totalPrice = null,}) {
  return _then(_OrderItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productImageUrl: null == productImageUrl ? _self.productImageUrl : productImageUrl // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,customizations: null == customizations ? _self._customizations : customizations // ignore: cast_nullable_to_non_nullable
as Map<String, String>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$OrderDto {

 String get id; String get userId; DateTime get createdAt; OrderStatusDto get status; AddressDto get deliveryAddress; int get paymentMethod; double get subtotal; double get deliveryFee; double get total; String? get notes; DateTime? get estimatedDeliveryTime; List<OrderItemDto> get items; List<StatusTimelineDto> get timeline;
/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDtoCopyWith<OrderDto> get copyWith => _$OrderDtoCopyWithImpl<OrderDto>(this as OrderDto, _$identity);

  /// Serializes this OrderDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrderDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.deliveryAddress, _this.deliveryAddress) || other.deliveryAddress == _this.deliveryAddress)&&(identical(other.paymentMethod, _this.paymentMethod) || other.paymentMethod == _this.paymentMethod)&&(identical(other.subtotal, _this.subtotal) || other.subtotal == _this.subtotal)&&(identical(other.deliveryFee, _this.deliveryFee) || other.deliveryFee == _this.deliveryFee)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.estimatedDeliveryTime, _this.estimatedDeliveryTime) || other.estimatedDeliveryTime == _this.estimatedDeliveryTime)&&const DeepCollectionEquality().equals(other.items, _this.items)&&const DeepCollectionEquality().equals(other.timeline, _this.timeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrderDto;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.createdAt,_this.status,_this.deliveryAddress,_this.paymentMethod,_this.subtotal,_this.deliveryFee,_this.total,_this.notes,_this.estimatedDeliveryTime,const DeepCollectionEquality().hash(_this.items),const DeepCollectionEquality().hash(_this.timeline));
}

@override
String toString() {
  final _this = this as OrderDto;
  return 'OrderDto(id: ${_this.id}, userId: ${_this.userId}, createdAt: ${_this.createdAt}, status: ${_this.status}, deliveryAddress: ${_this.deliveryAddress}, paymentMethod: ${_this.paymentMethod}, subtotal: ${_this.subtotal}, deliveryFee: ${_this.deliveryFee}, total: ${_this.total}, notes: ${_this.notes}, estimatedDeliveryTime: ${_this.estimatedDeliveryTime}, items: ${_this.items}, timeline: ${_this.timeline})';
}


}

/// @nodoc
abstract mixin class $OrderDtoCopyWith<$Res>  {
  factory $OrderDtoCopyWith(OrderDto value, $Res Function(OrderDto) _then) = _$OrderDtoCopyWithImpl;
@useResult
$Res call({
 String id, String userId, DateTime createdAt, OrderStatusDto status, AddressDto deliveryAddress, int paymentMethod, double subtotal, double deliveryFee, double total, String? notes, DateTime? estimatedDeliveryTime, List<OrderItemDto> items, List<StatusTimelineDto> timeline
});


$OrderStatusDtoCopyWith<$Res> get status;$AddressDtoCopyWith<$Res> get deliveryAddress;

}
/// @nodoc
class _$OrderDtoCopyWithImpl<$Res>
    implements $OrderDtoCopyWith<$Res> {
  _$OrderDtoCopyWithImpl(this._self, this._then);

  final OrderDto _self;
  final $Res Function(OrderDto) _then;

/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? createdAt = null,Object? status = null,Object? deliveryAddress = null,Object? paymentMethod = null,Object? subtotal = null,Object? deliveryFee = null,Object? total = null,Object? notes = freezed,Object? estimatedDeliveryTime = freezed,Object? items = null,Object? timeline = null,}) {
  return _then(OrderDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatusDto,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as AddressDto,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as int,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,estimatedDeliveryTime: freezed == estimatedDeliveryTime ? _self.estimatedDeliveryTime : estimatedDeliveryTime // ignore: cast_nullable_to_non_nullable
as DateTime?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItemDto>,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<StatusTimelineDto>,
  ));
}
/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderStatusDtoCopyWith<$Res> get status {
  
  return $OrderStatusDtoCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressDtoCopyWith<$Res> get deliveryAddress {
  
  return $AddressDtoCopyWith<$Res>(_self.deliveryAddress, (value) {
    return _then(_self.copyWith(deliveryAddress: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderDto].
extension OrderDtoPatterns on OrderDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderDto value)  $default,){
final _that = this;
switch (_that) {
case _OrderDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderDto value)?  $default,){
final _that = this;
switch (_that) {
case _OrderDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime createdAt,  OrderStatusDto status,  AddressDto deliveryAddress,  int paymentMethod,  double subtotal,  double deliveryFee,  double total,  String? notes,  DateTime? estimatedDeliveryTime,  List<OrderItemDto> items,  List<StatusTimelineDto> timeline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderDto() when $default != null:
return $default(_that.id,_that.userId,_that.createdAt,_that.status,_that.deliveryAddress,_that.paymentMethod,_that.subtotal,_that.deliveryFee,_that.total,_that.notes,_that.estimatedDeliveryTime,_that.items,_that.timeline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime createdAt,  OrderStatusDto status,  AddressDto deliveryAddress,  int paymentMethod,  double subtotal,  double deliveryFee,  double total,  String? notes,  DateTime? estimatedDeliveryTime,  List<OrderItemDto> items,  List<StatusTimelineDto> timeline)  $default,) {final _that = this;
switch (_that) {
case _OrderDto():
return $default(_that.id,_that.userId,_that.createdAt,_that.status,_that.deliveryAddress,_that.paymentMethod,_that.subtotal,_that.deliveryFee,_that.total,_that.notes,_that.estimatedDeliveryTime,_that.items,_that.timeline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  DateTime createdAt,  OrderStatusDto status,  AddressDto deliveryAddress,  int paymentMethod,  double subtotal,  double deliveryFee,  double total,  String? notes,  DateTime? estimatedDeliveryTime,  List<OrderItemDto> items,  List<StatusTimelineDto> timeline)?  $default,) {final _that = this;
switch (_that) {
case _OrderDto() when $default != null:
return $default(_that.id,_that.userId,_that.createdAt,_that.status,_that.deliveryAddress,_that.paymentMethod,_that.subtotal,_that.deliveryFee,_that.total,_that.notes,_that.estimatedDeliveryTime,_that.items,_that.timeline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderDto implements OrderDto {
  const _OrderDto({required this.id, required this.userId, required this.createdAt, required this.status, required this.deliveryAddress, required this.paymentMethod, required this.subtotal, required this.deliveryFee, required this.total, this.notes, this.estimatedDeliveryTime, required  List<OrderItemDto> items, required  List<StatusTimelineDto> timeline}): _items = items,_timeline = timeline;
  factory _OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);

@override final  String id;
@override final  String userId;
@override final  DateTime createdAt;
@override final  OrderStatusDto status;
@override final  AddressDto deliveryAddress;
@override final  int paymentMethod;
@override final  double subtotal;
@override final  double deliveryFee;
@override final  double total;
@override final  String? notes;
@override final  DateTime? estimatedDeliveryTime;
 final  List<OrderItemDto> _items;
@override List<OrderItemDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<StatusTimelineDto> _timeline;
@override List<StatusTimelineDto> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}


/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderDtoCopyWith<_OrderDto> get copyWith => __$OrderDtoCopyWithImpl<_OrderDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.total, total) || other.total == total)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.estimatedDeliveryTime, estimatedDeliveryTime) || other.estimatedDeliveryTime == estimatedDeliveryTime)&&const DeepCollectionEquality().equals(other.items, _items)&&const DeepCollectionEquality().equals(other.timeline, _timeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,createdAt,status,deliveryAddress,paymentMethod,subtotal,deliveryFee,total,notes,estimatedDeliveryTime,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_timeline));
}

@override
String toString() {
    return 'OrderDto(id: $id, userId: $userId, createdAt: $createdAt, status: $status, deliveryAddress: $deliveryAddress, paymentMethod: $paymentMethod, subtotal: $subtotal, deliveryFee: $deliveryFee, total: $total, notes: $notes, estimatedDeliveryTime: $estimatedDeliveryTime, items: $items, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class _$OrderDtoCopyWith<$Res> implements $OrderDtoCopyWith<$Res> {
  factory _$OrderDtoCopyWith(_OrderDto value, $Res Function(_OrderDto) _then) = __$OrderDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, DateTime createdAt, OrderStatusDto status, AddressDto deliveryAddress, int paymentMethod, double subtotal, double deliveryFee, double total, String? notes, DateTime? estimatedDeliveryTime, List<OrderItemDto> items, List<StatusTimelineDto> timeline
});


@override $OrderStatusDtoCopyWith<$Res> get status;@override $AddressDtoCopyWith<$Res> get deliveryAddress;

}
/// @nodoc
class __$OrderDtoCopyWithImpl<$Res>
    implements _$OrderDtoCopyWith<$Res> {
  __$OrderDtoCopyWithImpl(this._self, this._then);

  final _OrderDto _self;
  final $Res Function(_OrderDto) _then;

/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? createdAt = null,Object? status = null,Object? deliveryAddress = null,Object? paymentMethod = null,Object? subtotal = null,Object? deliveryFee = null,Object? total = null,Object? notes = freezed,Object? estimatedDeliveryTime = freezed,Object? items = null,Object? timeline = null,}) {
  return _then(_OrderDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatusDto,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as AddressDto,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as int,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,estimatedDeliveryTime: freezed == estimatedDeliveryTime ? _self.estimatedDeliveryTime : estimatedDeliveryTime // ignore: cast_nullable_to_non_nullable
as DateTime?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItemDto>,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<StatusTimelineDto>,
  ));
}

/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderStatusDtoCopyWith<$Res> get status {
  
  return $OrderStatusDtoCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressDtoCopyWith<$Res> get deliveryAddress {
  
  return $AddressDtoCopyWith<$Res>(_self.deliveryAddress, (value) {
    return _then(_self.copyWith(deliveryAddress: value));
  });
}
}


/// @nodoc
mixin _$OrdersResponse {

 List<OrderDto> get orders;
/// Create a copy of OrdersResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrdersResponseCopyWith<OrdersResponse> get copyWith => _$OrdersResponseCopyWithImpl<OrdersResponse>(this as OrdersResponse, _$identity);

  /// Serializes this OrdersResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrdersResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersResponse&&const DeepCollectionEquality().equals(other.orders, _this.orders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrdersResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.orders));
}

@override
String toString() {
  final _this = this as OrdersResponse;
  return 'OrdersResponse(orders: ${_this.orders})';
}


}

/// @nodoc
abstract mixin class $OrdersResponseCopyWith<$Res>  {
  factory $OrdersResponseCopyWith(OrdersResponse value, $Res Function(OrdersResponse) _then) = _$OrdersResponseCopyWithImpl;
@useResult
$Res call({
 List<OrderDto> orders
});




}
/// @nodoc
class _$OrdersResponseCopyWithImpl<$Res>
    implements $OrdersResponseCopyWith<$Res> {
  _$OrdersResponseCopyWithImpl(this._self, this._then);

  final OrdersResponse _self;
  final $Res Function(OrdersResponse) _then;

/// Create a copy of OrdersResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orders = null,}) {
  return _then(OrdersResponse(
orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [OrdersResponse].
extension OrdersResponsePatterns on OrdersResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrdersResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrdersResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrdersResponse value)  $default,){
final _that = this;
switch (_that) {
case _OrdersResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrdersResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OrdersResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OrderDto> orders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrdersResponse() when $default != null:
return $default(_that.orders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OrderDto> orders)  $default,) {final _that = this;
switch (_that) {
case _OrdersResponse():
return $default(_that.orders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OrderDto> orders)?  $default,) {final _that = this;
switch (_that) {
case _OrdersResponse() when $default != null:
return $default(_that.orders);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrdersResponse implements OrdersResponse {
  const _OrdersResponse({required  List<OrderDto> orders}): _orders = orders;
  factory _OrdersResponse.fromJson(Map<String, dynamic> json) => _$OrdersResponseFromJson(json);

 final  List<OrderDto> _orders;
@override List<OrderDto> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}


/// Create a copy of OrdersResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrdersResponseCopyWith<_OrdersResponse> get copyWith => __$OrdersResponseCopyWithImpl<_OrdersResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrdersResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrdersResponse&&const DeepCollectionEquality().equals(other.orders, _orders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders));
}

@override
String toString() {
    return 'OrdersResponse(orders: $orders)';
}


}

/// @nodoc
abstract mixin class _$OrdersResponseCopyWith<$Res> implements $OrdersResponseCopyWith<$Res> {
  factory _$OrdersResponseCopyWith(_OrdersResponse value, $Res Function(_OrdersResponse) _then) = __$OrdersResponseCopyWithImpl;
@override @useResult
$Res call({
 List<OrderDto> orders
});




}
/// @nodoc
class __$OrdersResponseCopyWithImpl<$Res>
    implements _$OrdersResponseCopyWith<$Res> {
  __$OrdersResponseCopyWithImpl(this._self, this._then);

  final _OrdersResponse _self;
  final $Res Function(_OrdersResponse) _then;

/// Create a copy of OrdersResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orders = null,}) {
  return _then(_OrdersResponse(
orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderDto>,
  ));
}


}


/// @nodoc
mixin _$CreateOrderRequest {

 String get deliveryAddressId; int get paymentMethod; String? get notes;
/// Create a copy of CreateOrderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateOrderRequestCopyWith<CreateOrderRequest> get copyWith => _$CreateOrderRequestCopyWithImpl<CreateOrderRequest>(this as CreateOrderRequest, _$identity);

  /// Serializes this CreateOrderRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateOrderRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateOrderRequest&&(identical(other.deliveryAddressId, _this.deliveryAddressId) || other.deliveryAddressId == _this.deliveryAddressId)&&(identical(other.paymentMethod, _this.paymentMethod) || other.paymentMethod == _this.paymentMethod)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateOrderRequest;
  return Object.hash(runtimeType,_this.deliveryAddressId,_this.paymentMethod,_this.notes);
}

@override
String toString() {
  final _this = this as CreateOrderRequest;
  return 'CreateOrderRequest(deliveryAddressId: ${_this.deliveryAddressId}, paymentMethod: ${_this.paymentMethod}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $CreateOrderRequestCopyWith<$Res>  {
  factory $CreateOrderRequestCopyWith(CreateOrderRequest value, $Res Function(CreateOrderRequest) _then) = _$CreateOrderRequestCopyWithImpl;
@useResult
$Res call({
 String deliveryAddressId, int paymentMethod, String? notes
});




}
/// @nodoc
class _$CreateOrderRequestCopyWithImpl<$Res>
    implements $CreateOrderRequestCopyWith<$Res> {
  _$CreateOrderRequestCopyWithImpl(this._self, this._then);

  final CreateOrderRequest _self;
  final $Res Function(CreateOrderRequest) _then;

/// Create a copy of CreateOrderRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deliveryAddressId = null,Object? paymentMethod = null,Object? notes = freezed,}) {
  return _then(CreateOrderRequest(
deliveryAddressId: null == deliveryAddressId ? _self.deliveryAddressId : deliveryAddressId // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateOrderRequest].
extension CreateOrderRequestPatterns on CreateOrderRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateOrderRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateOrderRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateOrderRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateOrderRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateOrderRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateOrderRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deliveryAddressId,  int paymentMethod,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateOrderRequest() when $default != null:
return $default(_that.deliveryAddressId,_that.paymentMethod,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deliveryAddressId,  int paymentMethod,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _CreateOrderRequest():
return $default(_that.deliveryAddressId,_that.paymentMethod,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deliveryAddressId,  int paymentMethod,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _CreateOrderRequest() when $default != null:
return $default(_that.deliveryAddressId,_that.paymentMethod,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateOrderRequest implements CreateOrderRequest {
  const _CreateOrderRequest({required this.deliveryAddressId, required this.paymentMethod, this.notes});
  factory _CreateOrderRequest.fromJson(Map<String, dynamic> json) => _$CreateOrderRequestFromJson(json);

@override final  String deliveryAddressId;
@override final  int paymentMethod;
@override final  String? notes;

/// Create a copy of CreateOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateOrderRequestCopyWith<_CreateOrderRequest> get copyWith => __$CreateOrderRequestCopyWithImpl<_CreateOrderRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateOrderRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateOrderRequest&&(identical(other.deliveryAddressId, deliveryAddressId) || other.deliveryAddressId == deliveryAddressId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,deliveryAddressId,paymentMethod,notes);
}

@override
String toString() {
    return 'CreateOrderRequest(deliveryAddressId: $deliveryAddressId, paymentMethod: $paymentMethod, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$CreateOrderRequestCopyWith<$Res> implements $CreateOrderRequestCopyWith<$Res> {
  factory _$CreateOrderRequestCopyWith(_CreateOrderRequest value, $Res Function(_CreateOrderRequest) _then) = __$CreateOrderRequestCopyWithImpl;
@override @useResult
$Res call({
 String deliveryAddressId, int paymentMethod, String? notes
});




}
/// @nodoc
class __$CreateOrderRequestCopyWithImpl<$Res>
    implements _$CreateOrderRequestCopyWith<$Res> {
  __$CreateOrderRequestCopyWithImpl(this._self, this._then);

  final _CreateOrderRequest _self;
  final $Res Function(_CreateOrderRequest) _then;

/// Create a copy of CreateOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deliveryAddressId = null,Object? paymentMethod = null,Object? notes = freezed,}) {
  return _then(_CreateOrderRequest(
deliveryAddressId: null == deliveryAddressId ? _self.deliveryAddressId : deliveryAddressId // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
