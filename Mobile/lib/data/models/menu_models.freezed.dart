// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryDto {

 int get id; String get name; String get displayName; int get sortOrder;
/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryDtoCopyWith<CategoryDto> get copyWith => _$CategoryDtoCopyWithImpl<CategoryDto>(this as CategoryDto, _$identity);

  /// Serializes this CategoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CategoryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CategoryDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.displayName,_this.sortOrder);
}

@override
String toString() {
  final _this = this as CategoryDto;
  return 'CategoryDto(id: ${_this.id}, name: ${_this.name}, displayName: ${_this.displayName}, sortOrder: ${_this.sortOrder})';
}


}

/// @nodoc
abstract mixin class $CategoryDtoCopyWith<$Res>  {
  factory $CategoryDtoCopyWith(CategoryDto value, $Res Function(CategoryDto) _then) = _$CategoryDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String displayName, int sortOrder
});




}
/// @nodoc
class _$CategoryDtoCopyWithImpl<$Res>
    implements $CategoryDtoCopyWith<$Res> {
  _$CategoryDtoCopyWithImpl(this._self, this._then);

  final CategoryDto _self;
  final $Res Function(CategoryDto) _then;

/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? displayName = null,Object? sortOrder = null,}) {
  return _then(CategoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryDto].
extension CategoryDtoPatterns on CategoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryDto value)  $default,){
final _that = this;
switch (_that) {
case _CategoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String displayName,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
return $default(_that.id,_that.name,_that.displayName,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String displayName,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _CategoryDto():
return $default(_that.id,_that.name,_that.displayName,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String displayName,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
return $default(_that.id,_that.name,_that.displayName,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryDto implements CategoryDto {
  const _CategoryDto({required this.id, required this.name, required this.displayName, required this.sortOrder});
  factory _CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);

@override final  int id;
@override final  String name;
@override final  String displayName;
@override final  int sortOrder;

/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryDtoCopyWith<_CategoryDto> get copyWith => __$CategoryDtoCopyWithImpl<_CategoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,displayName,sortOrder);
}

@override
String toString() {
    return 'CategoryDto(id: $id, name: $name, displayName: $displayName, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$CategoryDtoCopyWith<$Res> implements $CategoryDtoCopyWith<$Res> {
  factory _$CategoryDtoCopyWith(_CategoryDto value, $Res Function(_CategoryDto) _then) = __$CategoryDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String displayName, int sortOrder
});




}
/// @nodoc
class __$CategoryDtoCopyWithImpl<$Res>
    implements _$CategoryDtoCopyWith<$Res> {
  __$CategoryDtoCopyWithImpl(this._self, this._then);

  final _CategoryDto _self;
  final $Res Function(_CategoryDto) _then;

/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? displayName = null,Object? sortOrder = null,}) {
  return _then(_CategoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CustomizationChoiceDto {

 String get id; String get name; double get additionalPrice; int get sortOrder;
/// Create a copy of CustomizationChoiceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomizationChoiceDtoCopyWith<CustomizationChoiceDto> get copyWith => _$CustomizationChoiceDtoCopyWithImpl<CustomizationChoiceDto>(this as CustomizationChoiceDto, _$identity);

  /// Serializes this CustomizationChoiceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CustomizationChoiceDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomizationChoiceDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.additionalPrice, _this.additionalPrice) || other.additionalPrice == _this.additionalPrice)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CustomizationChoiceDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.additionalPrice,_this.sortOrder);
}

@override
String toString() {
  final _this = this as CustomizationChoiceDto;
  return 'CustomizationChoiceDto(id: ${_this.id}, name: ${_this.name}, additionalPrice: ${_this.additionalPrice}, sortOrder: ${_this.sortOrder})';
}


}

/// @nodoc
abstract mixin class $CustomizationChoiceDtoCopyWith<$Res>  {
  factory $CustomizationChoiceDtoCopyWith(CustomizationChoiceDto value, $Res Function(CustomizationChoiceDto) _then) = _$CustomizationChoiceDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, double additionalPrice, int sortOrder
});




}
/// @nodoc
class _$CustomizationChoiceDtoCopyWithImpl<$Res>
    implements $CustomizationChoiceDtoCopyWith<$Res> {
  _$CustomizationChoiceDtoCopyWithImpl(this._self, this._then);

  final CustomizationChoiceDto _self;
  final $Res Function(CustomizationChoiceDto) _then;

/// Create a copy of CustomizationChoiceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? additionalPrice = null,Object? sortOrder = null,}) {
  return _then(CustomizationChoiceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,additionalPrice: null == additionalPrice ? _self.additionalPrice : additionalPrice // ignore: cast_nullable_to_non_nullable
as double,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomizationChoiceDto].
extension CustomizationChoiceDtoPatterns on CustomizationChoiceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomizationChoiceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomizationChoiceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomizationChoiceDto value)  $default,){
final _that = this;
switch (_that) {
case _CustomizationChoiceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomizationChoiceDto value)?  $default,){
final _that = this;
switch (_that) {
case _CustomizationChoiceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  double additionalPrice,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomizationChoiceDto() when $default != null:
return $default(_that.id,_that.name,_that.additionalPrice,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  double additionalPrice,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _CustomizationChoiceDto():
return $default(_that.id,_that.name,_that.additionalPrice,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  double additionalPrice,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _CustomizationChoiceDto() when $default != null:
return $default(_that.id,_that.name,_that.additionalPrice,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomizationChoiceDto implements CustomizationChoiceDto {
  const _CustomizationChoiceDto({required this.id, required this.name, required this.additionalPrice, required this.sortOrder});
  factory _CustomizationChoiceDto.fromJson(Map<String, dynamic> json) => _$CustomizationChoiceDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  double additionalPrice;
@override final  int sortOrder;

/// Create a copy of CustomizationChoiceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomizationChoiceDtoCopyWith<_CustomizationChoiceDto> get copyWith => __$CustomizationChoiceDtoCopyWithImpl<_CustomizationChoiceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomizationChoiceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomizationChoiceDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.additionalPrice, additionalPrice) || other.additionalPrice == additionalPrice)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,additionalPrice,sortOrder);
}

@override
String toString() {
    return 'CustomizationChoiceDto(id: $id, name: $name, additionalPrice: $additionalPrice, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$CustomizationChoiceDtoCopyWith<$Res> implements $CustomizationChoiceDtoCopyWith<$Res> {
  factory _$CustomizationChoiceDtoCopyWith(_CustomizationChoiceDto value, $Res Function(_CustomizationChoiceDto) _then) = __$CustomizationChoiceDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double additionalPrice, int sortOrder
});




}
/// @nodoc
class __$CustomizationChoiceDtoCopyWithImpl<$Res>
    implements _$CustomizationChoiceDtoCopyWith<$Res> {
  __$CustomizationChoiceDtoCopyWithImpl(this._self, this._then);

  final _CustomizationChoiceDto _self;
  final $Res Function(_CustomizationChoiceDto) _then;

/// Create a copy of CustomizationChoiceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? additionalPrice = null,Object? sortOrder = null,}) {
  return _then(_CustomizationChoiceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,additionalPrice: null == additionalPrice ? _self.additionalPrice : additionalPrice // ignore: cast_nullable_to_non_nullable
as double,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CustomizationOptionDto {

 String get id; String get name; bool get isRequired; bool get allowMultiple; int get sortOrder; List<CustomizationChoiceDto> get choices;
/// Create a copy of CustomizationOptionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomizationOptionDtoCopyWith<CustomizationOptionDto> get copyWith => _$CustomizationOptionDtoCopyWithImpl<CustomizationOptionDto>(this as CustomizationOptionDto, _$identity);

  /// Serializes this CustomizationOptionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CustomizationOptionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomizationOptionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.isRequired, _this.isRequired) || other.isRequired == _this.isRequired)&&(identical(other.allowMultiple, _this.allowMultiple) || other.allowMultiple == _this.allowMultiple)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&const DeepCollectionEquality().equals(other.choices, _this.choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CustomizationOptionDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.isRequired,_this.allowMultiple,_this.sortOrder,const DeepCollectionEquality().hash(_this.choices));
}

@override
String toString() {
  final _this = this as CustomizationOptionDto;
  return 'CustomizationOptionDto(id: ${_this.id}, name: ${_this.name}, isRequired: ${_this.isRequired}, allowMultiple: ${_this.allowMultiple}, sortOrder: ${_this.sortOrder}, choices: ${_this.choices})';
}


}

/// @nodoc
abstract mixin class $CustomizationOptionDtoCopyWith<$Res>  {
  factory $CustomizationOptionDtoCopyWith(CustomizationOptionDto value, $Res Function(CustomizationOptionDto) _then) = _$CustomizationOptionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool isRequired, bool allowMultiple, int sortOrder, List<CustomizationChoiceDto> choices
});




}
/// @nodoc
class _$CustomizationOptionDtoCopyWithImpl<$Res>
    implements $CustomizationOptionDtoCopyWith<$Res> {
  _$CustomizationOptionDtoCopyWithImpl(this._self, this._then);

  final CustomizationOptionDto _self;
  final $Res Function(CustomizationOptionDto) _then;

/// Create a copy of CustomizationOptionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isRequired = null,Object? allowMultiple = null,Object? sortOrder = null,Object? choices = null,}) {
  return _then(CustomizationOptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,allowMultiple: null == allowMultiple ? _self.allowMultiple : allowMultiple // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<CustomizationChoiceDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomizationOptionDto].
extension CustomizationOptionDtoPatterns on CustomizationOptionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomizationOptionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomizationOptionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomizationOptionDto value)  $default,){
final _that = this;
switch (_that) {
case _CustomizationOptionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomizationOptionDto value)?  $default,){
final _that = this;
switch (_that) {
case _CustomizationOptionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool isRequired,  bool allowMultiple,  int sortOrder,  List<CustomizationChoiceDto> choices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomizationOptionDto() when $default != null:
return $default(_that.id,_that.name,_that.isRequired,_that.allowMultiple,_that.sortOrder,_that.choices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool isRequired,  bool allowMultiple,  int sortOrder,  List<CustomizationChoiceDto> choices)  $default,) {final _that = this;
switch (_that) {
case _CustomizationOptionDto():
return $default(_that.id,_that.name,_that.isRequired,_that.allowMultiple,_that.sortOrder,_that.choices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool isRequired,  bool allowMultiple,  int sortOrder,  List<CustomizationChoiceDto> choices)?  $default,) {final _that = this;
switch (_that) {
case _CustomizationOptionDto() when $default != null:
return $default(_that.id,_that.name,_that.isRequired,_that.allowMultiple,_that.sortOrder,_that.choices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomizationOptionDto implements CustomizationOptionDto {
  const _CustomizationOptionDto({required this.id, required this.name, required this.isRequired, required this.allowMultiple, required this.sortOrder,  List<CustomizationChoiceDto> choices = const []}): _choices = choices;
  factory _CustomizationOptionDto.fromJson(Map<String, dynamic> json) => _$CustomizationOptionDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  bool isRequired;
@override final  bool allowMultiple;
@override final  int sortOrder;
 final  List<CustomizationChoiceDto> _choices;
@override@JsonKey() List<CustomizationChoiceDto> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}


/// Create a copy of CustomizationOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomizationOptionDtoCopyWith<_CustomizationOptionDto> get copyWith => __$CustomizationOptionDtoCopyWithImpl<_CustomizationOptionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomizationOptionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomizationOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.allowMultiple, allowMultiple) || other.allowMultiple == allowMultiple)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other.choices, _choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,isRequired,allowMultiple,sortOrder,const DeepCollectionEquality().hash(_choices));
}

@override
String toString() {
    return 'CustomizationOptionDto(id: $id, name: $name, isRequired: $isRequired, allowMultiple: $allowMultiple, sortOrder: $sortOrder, choices: $choices)';
}


}

/// @nodoc
abstract mixin class _$CustomizationOptionDtoCopyWith<$Res> implements $CustomizationOptionDtoCopyWith<$Res> {
  factory _$CustomizationOptionDtoCopyWith(_CustomizationOptionDto value, $Res Function(_CustomizationOptionDto) _then) = __$CustomizationOptionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool isRequired, bool allowMultiple, int sortOrder, List<CustomizationChoiceDto> choices
});




}
/// @nodoc
class __$CustomizationOptionDtoCopyWithImpl<$Res>
    implements _$CustomizationOptionDtoCopyWith<$Res> {
  __$CustomizationOptionDtoCopyWithImpl(this._self, this._then);

  final _CustomizationOptionDto _self;
  final $Res Function(_CustomizationOptionDto) _then;

/// Create a copy of CustomizationOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isRequired = null,Object? allowMultiple = null,Object? sortOrder = null,Object? choices = null,}) {
  return _then(_CustomizationOptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,allowMultiple: null == allowMultiple ? _self.allowMultiple : allowMultiple // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<CustomizationChoiceDto>,
  ));
}


}


/// @nodoc
mixin _$ProductDto {

 String get id; String get name; String get description; String get imageUrl; double get price; int get categoryId; String get categoryName; String get categoryDisplayName; int get prepTimeMinutes; bool get isAvailable; List<CustomizationOptionDto> get customizationOptions;
/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDtoCopyWith<ProductDto> get copyWith => _$ProductDtoCopyWithImpl<ProductDto>(this as ProductDto, _$identity);

  /// Serializes this ProductDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProductDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.categoryName, _this.categoryName) || other.categoryName == _this.categoryName)&&(identical(other.categoryDisplayName, _this.categoryDisplayName) || other.categoryDisplayName == _this.categoryDisplayName)&&(identical(other.prepTimeMinutes, _this.prepTimeMinutes) || other.prepTimeMinutes == _this.prepTimeMinutes)&&(identical(other.isAvailable, _this.isAvailable) || other.isAvailable == _this.isAvailable)&&const DeepCollectionEquality().equals(other.customizationOptions, _this.customizationOptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProductDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.imageUrl,_this.price,_this.categoryId,_this.categoryName,_this.categoryDisplayName,_this.prepTimeMinutes,_this.isAvailable,const DeepCollectionEquality().hash(_this.customizationOptions));
}

@override
String toString() {
  final _this = this as ProductDto;
  return 'ProductDto(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, imageUrl: ${_this.imageUrl}, price: ${_this.price}, categoryId: ${_this.categoryId}, categoryName: ${_this.categoryName}, categoryDisplayName: ${_this.categoryDisplayName}, prepTimeMinutes: ${_this.prepTimeMinutes}, isAvailable: ${_this.isAvailable}, customizationOptions: ${_this.customizationOptions})';
}


}

/// @nodoc
abstract mixin class $ProductDtoCopyWith<$Res>  {
  factory $ProductDtoCopyWith(ProductDto value, $Res Function(ProductDto) _then) = _$ProductDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String imageUrl, double price, int categoryId, String categoryName, String categoryDisplayName, int prepTimeMinutes, bool isAvailable, List<CustomizationOptionDto> customizationOptions
});




}
/// @nodoc
class _$ProductDtoCopyWithImpl<$Res>
    implements $ProductDtoCopyWith<$Res> {
  _$ProductDtoCopyWithImpl(this._self, this._then);

  final ProductDto _self;
  final $Res Function(ProductDto) _then;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? imageUrl = null,Object? price = null,Object? categoryId = null,Object? categoryName = null,Object? categoryDisplayName = null,Object? prepTimeMinutes = null,Object? isAvailable = null,Object? customizationOptions = null,}) {
  return _then(ProductDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryDisplayName: null == categoryDisplayName ? _self.categoryDisplayName : categoryDisplayName // ignore: cast_nullable_to_non_nullable
as String,prepTimeMinutes: null == prepTimeMinutes ? _self.prepTimeMinutes : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,customizationOptions: null == customizationOptions ? _self.customizationOptions : customizationOptions // ignore: cast_nullable_to_non_nullable
as List<CustomizationOptionDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDto].
extension ProductDtoPatterns on ProductDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDto value)  $default,){
final _that = this;
switch (_that) {
case _ProductDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String imageUrl,  double price,  int categoryId,  String categoryName,  String categoryDisplayName,  int prepTimeMinutes,  bool isAvailable,  List<CustomizationOptionDto> customizationOptions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.imageUrl,_that.price,_that.categoryId,_that.categoryName,_that.categoryDisplayName,_that.prepTimeMinutes,_that.isAvailable,_that.customizationOptions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String imageUrl,  double price,  int categoryId,  String categoryName,  String categoryDisplayName,  int prepTimeMinutes,  bool isAvailable,  List<CustomizationOptionDto> customizationOptions)  $default,) {final _that = this;
switch (_that) {
case _ProductDto():
return $default(_that.id,_that.name,_that.description,_that.imageUrl,_that.price,_that.categoryId,_that.categoryName,_that.categoryDisplayName,_that.prepTimeMinutes,_that.isAvailable,_that.customizationOptions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String imageUrl,  double price,  int categoryId,  String categoryName,  String categoryDisplayName,  int prepTimeMinutes,  bool isAvailable,  List<CustomizationOptionDto> customizationOptions)?  $default,) {final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.imageUrl,_that.price,_that.categoryId,_that.categoryName,_that.categoryDisplayName,_that.prepTimeMinutes,_that.isAvailable,_that.customizationOptions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductDto implements ProductDto {
  const _ProductDto({required this.id, required this.name, required this.description, required this.imageUrl, required this.price, required this.categoryId, required this.categoryName, required this.categoryDisplayName, required this.prepTimeMinutes, required this.isAvailable,  List<CustomizationOptionDto> customizationOptions = const []}): _customizationOptions = customizationOptions;
  factory _ProductDto.fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String imageUrl;
@override final  double price;
@override final  int categoryId;
@override final  String categoryName;
@override final  String categoryDisplayName;
@override final  int prepTimeMinutes;
@override final  bool isAvailable;
 final  List<CustomizationOptionDto> _customizationOptions;
@override@JsonKey() List<CustomizationOptionDto> get customizationOptions {
  if (_customizationOptions is EqualUnmodifiableListView) return _customizationOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customizationOptions);
}


/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDtoCopyWith<_ProductDto> get copyWith => __$ProductDtoCopyWithImpl<_ProductDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.price, price) || other.price == price)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryDisplayName, categoryDisplayName) || other.categoryDisplayName == categoryDisplayName)&&(identical(other.prepTimeMinutes, prepTimeMinutes) || other.prepTimeMinutes == prepTimeMinutes)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&const DeepCollectionEquality().equals(other.customizationOptions, _customizationOptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,imageUrl,price,categoryId,categoryName,categoryDisplayName,prepTimeMinutes,isAvailable,const DeepCollectionEquality().hash(_customizationOptions));
}

@override
String toString() {
    return 'ProductDto(id: $id, name: $name, description: $description, imageUrl: $imageUrl, price: $price, categoryId: $categoryId, categoryName: $categoryName, categoryDisplayName: $categoryDisplayName, prepTimeMinutes: $prepTimeMinutes, isAvailable: $isAvailable, customizationOptions: $customizationOptions)';
}


}

/// @nodoc
abstract mixin class _$ProductDtoCopyWith<$Res> implements $ProductDtoCopyWith<$Res> {
  factory _$ProductDtoCopyWith(_ProductDto value, $Res Function(_ProductDto) _then) = __$ProductDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String imageUrl, double price, int categoryId, String categoryName, String categoryDisplayName, int prepTimeMinutes, bool isAvailable, List<CustomizationOptionDto> customizationOptions
});




}
/// @nodoc
class __$ProductDtoCopyWithImpl<$Res>
    implements _$ProductDtoCopyWith<$Res> {
  __$ProductDtoCopyWithImpl(this._self, this._then);

  final _ProductDto _self;
  final $Res Function(_ProductDto) _then;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? imageUrl = null,Object? price = null,Object? categoryId = null,Object? categoryName = null,Object? categoryDisplayName = null,Object? prepTimeMinutes = null,Object? isAvailable = null,Object? customizationOptions = null,}) {
  return _then(_ProductDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryDisplayName: null == categoryDisplayName ? _self.categoryDisplayName : categoryDisplayName // ignore: cast_nullable_to_non_nullable
as String,prepTimeMinutes: null == prepTimeMinutes ? _self.prepTimeMinutes : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,customizationOptions: null == customizationOptions ? _self._customizationOptions : customizationOptions // ignore: cast_nullable_to_non_nullable
as List<CustomizationOptionDto>,
  ));
}


}


/// @nodoc
mixin _$MenuResponse {

 List<CategoryDto> get categories; List<ProductDto> get products;
/// Create a copy of MenuResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuResponseCopyWith<MenuResponse> get copyWith => _$MenuResponseCopyWithImpl<MenuResponse>(this as MenuResponse, _$identity);

  /// Serializes this MenuResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MenuResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuResponse&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.products, _this.products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MenuResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.products));
}

@override
String toString() {
  final _this = this as MenuResponse;
  return 'MenuResponse(categories: ${_this.categories}, products: ${_this.products})';
}


}

/// @nodoc
abstract mixin class $MenuResponseCopyWith<$Res>  {
  factory $MenuResponseCopyWith(MenuResponse value, $Res Function(MenuResponse) _then) = _$MenuResponseCopyWithImpl;
@useResult
$Res call({
 List<CategoryDto> categories, List<ProductDto> products
});




}
/// @nodoc
class _$MenuResponseCopyWithImpl<$Res>
    implements $MenuResponseCopyWith<$Res> {
  _$MenuResponseCopyWithImpl(this._self, this._then);

  final MenuResponse _self;
  final $Res Function(MenuResponse) _then;

/// Create a copy of MenuResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? products = null,}) {
  return _then(MenuResponse(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryDto>,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuResponse].
extension MenuResponsePatterns on MenuResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuResponse value)  $default,){
final _that = this;
switch (_that) {
case _MenuResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MenuResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CategoryDto> categories,  List<ProductDto> products)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuResponse() when $default != null:
return $default(_that.categories,_that.products);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CategoryDto> categories,  List<ProductDto> products)  $default,) {final _that = this;
switch (_that) {
case _MenuResponse():
return $default(_that.categories,_that.products);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CategoryDto> categories,  List<ProductDto> products)?  $default,) {final _that = this;
switch (_that) {
case _MenuResponse() when $default != null:
return $default(_that.categories,_that.products);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MenuResponse implements MenuResponse {
  const _MenuResponse({ List<CategoryDto> categories = const [],  List<ProductDto> products = const []}): _categories = categories,_products = products;
  factory _MenuResponse.fromJson(Map<String, dynamic> json) => _$MenuResponseFromJson(json);

 final  List<CategoryDto> _categories;
@override@JsonKey() List<CategoryDto> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<ProductDto> _products;
@override@JsonKey() List<ProductDto> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}


/// Create a copy of MenuResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuResponseCopyWith<_MenuResponse> get copyWith => __$MenuResponseCopyWithImpl<_MenuResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MenuResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuResponse&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.products, _products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_products));
}

@override
String toString() {
    return 'MenuResponse(categories: $categories, products: $products)';
}


}

/// @nodoc
abstract mixin class _$MenuResponseCopyWith<$Res> implements $MenuResponseCopyWith<$Res> {
  factory _$MenuResponseCopyWith(_MenuResponse value, $Res Function(_MenuResponse) _then) = __$MenuResponseCopyWithImpl;
@override @useResult
$Res call({
 List<CategoryDto> categories, List<ProductDto> products
});




}
/// @nodoc
class __$MenuResponseCopyWithImpl<$Res>
    implements _$MenuResponseCopyWith<$Res> {
  __$MenuResponseCopyWithImpl(this._self, this._then);

  final _MenuResponse _self;
  final $Res Function(_MenuResponse) _then;

/// Create a copy of MenuResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? products = null,}) {
  return _then(_MenuResponse(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryDto>,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDto>,
  ));
}


}

// dart format on
