// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
      final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) {
  return _CategoryDto.fromJson(json);
}

/// @nodoc
mixin _$CategoryDto {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryDtoCopyWith<CategoryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryDtoCopyWith<$Res> {
  factory $CategoryDtoCopyWith(
          CategoryDto value, $Res Function(CategoryDto) then) =
      _$CategoryDtoCopyWithImpl<$Res, CategoryDto>;
  @useResult
  $Res call({int id, String name, String displayName, int sortOrder});
}

/// @nodoc
class _$CategoryDtoCopyWithImpl<$Res, $Val extends CategoryDto>
    implements $CategoryDtoCopyWith<$Res> {
  _$CategoryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
      $Val _value;
  // ignore: unused_field
      $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? displayName = null,
    Object? sortOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryDtoImplCopyWith<$Res>
    implements $CategoryDtoCopyWith<$Res> {
  factory _$$CategoryDtoImplCopyWith(
          _$CategoryDtoImpl value, $Res Function(_$CategoryDtoImpl) then) =
      __$$CategoryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String displayName, int sortOrder});
}

/// @nodoc
class __$$CategoryDtoImplCopyWithImpl<$Res>
    extends _$CategoryDtoCopyWithImpl<$Res, _$CategoryDtoImpl>
    implements _$$CategoryDtoImplCopyWith<$Res> {
  __$$CategoryDtoImplCopyWithImpl(
      _$CategoryDtoImpl _value, $Res Function(_$CategoryDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? displayName = null,
    Object? sortOrder = null,
  }) {
    return _then(_$CategoryDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryDtoImpl implements _CategoryDto {
  const _$CategoryDtoImpl(
      {required this.id,
      required this.name,
      required this.displayName,
      required this.sortOrder});

  factory _$CategoryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryDtoImplFromJson(json);

  @override
      final int id;
  @override
      final String name;
  @override
  final String displayName;
  @override
  final int sortOrder;

  @override
  String toString() {
    return 'CategoryDto(id: $id, name: $name, displayName: $displayName, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, displayName, sortOrder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryDtoImplCopyWith<_$CategoryDtoImpl> get copyWith =>
      __$$CategoryDtoImplCopyWithImpl<_$CategoryDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryDtoImplToJson(
      this,
    );
  }
}

abstract class _CategoryDto implements CategoryDto {
  const factory _CategoryDto(
      {required int id,
      required String name,
      required String displayName,
      required int sortOrder}) = _$CategoryDtoImpl;

  factory _CategoryDto.fromJson(Map<String, dynamic> json) =
      _$CategoryDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get displayName;
  @override
  int get sortOrder;
  @override
  @JsonKey(ignore: true)
  _$$CategoryDtoImplCopyWith<_$CategoryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomizationChoiceDto _$CustomizationChoiceDtoFromJson(
    Map<String, dynamic> json) {
  return _CustomizationChoiceDto.fromJson(json);
}

/// @nodoc
mixin _$CustomizationChoiceDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get additionalPrice => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomizationChoiceDtoCopyWith<CustomizationChoiceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomizationChoiceDtoCopyWith<$Res> {
  factory $CustomizationChoiceDtoCopyWith(CustomizationChoiceDto value,
          $Res Function(CustomizationChoiceDto) then) =
      _$CustomizationChoiceDtoCopyWithImpl<$Res, CustomizationChoiceDto>;
  @useResult
  $Res call({String id, String name, double additionalPrice, int sortOrder});
}

/// @nodoc
class _$CustomizationChoiceDtoCopyWithImpl<$Res,
        $Val extends CustomizationChoiceDto>
    implements $CustomizationChoiceDtoCopyWith<$Res> {
  _$CustomizationChoiceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
      $Val _value;
  // ignore: unused_field
      $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? additionalPrice = null,
    Object? sortOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      additionalPrice: null == additionalPrice
          ? _value.additionalPrice
          : additionalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomizationChoiceDtoImplCopyWith<$Res>
    implements $CustomizationChoiceDtoCopyWith<$Res> {
  factory _$$CustomizationChoiceDtoImplCopyWith(
          _$CustomizationChoiceDtoImpl value,
          $Res Function(_$CustomizationChoiceDtoImpl) then) =
      __$$CustomizationChoiceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, double additionalPrice, int sortOrder});
}

/// @nodoc
class __$$CustomizationChoiceDtoImplCopyWithImpl<$Res>
    extends _$CustomizationChoiceDtoCopyWithImpl<$Res,
        _$CustomizationChoiceDtoImpl>
    implements _$$CustomizationChoiceDtoImplCopyWith<$Res> {
  __$$CustomizationChoiceDtoImplCopyWithImpl(
      _$CustomizationChoiceDtoImpl _value,
      $Res Function(_$CustomizationChoiceDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? additionalPrice = null,
    Object? sortOrder = null,
  }) {
    return _then(_$CustomizationChoiceDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      additionalPrice: null == additionalPrice
          ? _value.additionalPrice
          : additionalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomizationChoiceDtoImpl implements _CustomizationChoiceDto {
  const _$CustomizationChoiceDtoImpl(
      {required this.id,
      required this.name,
      required this.additionalPrice,
      required this.sortOrder});

  factory _$CustomizationChoiceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomizationChoiceDtoImplFromJson(json);

  @override
      final String id;
  @override
      final String name;
  @override
  final double additionalPrice;
  @override
  final int sortOrder;

  @override
  String toString() {
    return 'CustomizationChoiceDto(id: $id, name: $name, additionalPrice: $additionalPrice, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomizationChoiceDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.additionalPrice, additionalPrice) ||
                other.additionalPrice == additionalPrice) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, additionalPrice, sortOrder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomizationChoiceDtoImplCopyWith<_$CustomizationChoiceDtoImpl>
      get copyWith => __$$CustomizationChoiceDtoImplCopyWithImpl<
          _$CustomizationChoiceDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomizationChoiceDtoImplToJson(
      this,
    );
  }
}

abstract class _CustomizationChoiceDto implements CustomizationChoiceDto {
  const factory _CustomizationChoiceDto(
      {required String id,
      required String name,
      required double additionalPrice,
      required int sortOrder}) = _$CustomizationChoiceDtoImpl;

  factory _CustomizationChoiceDto.fromJson(Map<String, dynamic> json) =
      _$CustomizationChoiceDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get additionalPrice;
  @override
  int get sortOrder;
  @override
  @JsonKey(ignore: true)
  _$$CustomizationChoiceDtoImplCopyWith<_$CustomizationChoiceDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CustomizationOptionDto _$CustomizationOptionDtoFromJson(
    Map<String, dynamic> json) {
  return _CustomizationOptionDto.fromJson(json);
}

/// @nodoc
mixin _$CustomizationOptionDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  bool get allowMultiple => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  List<CustomizationChoiceDto> get choices =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomizationOptionDtoCopyWith<CustomizationOptionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomizationOptionDtoCopyWith<$Res> {
  factory $CustomizationOptionDtoCopyWith(CustomizationOptionDto value,
          $Res Function(CustomizationOptionDto) then) =
      _$CustomizationOptionDtoCopyWithImpl<$Res, CustomizationOptionDto>;
  @useResult
  $Res call(
      {String id,
      String name,
      bool isRequired,
      bool allowMultiple,
      int sortOrder,
      List<CustomizationChoiceDto> choices});
}

/// @nodoc
class _$CustomizationOptionDtoCopyWithImpl<$Res,
        $Val extends CustomizationOptionDto>
    implements $CustomizationOptionDtoCopyWith<$Res> {
  _$CustomizationOptionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
      $Val _value;
  // ignore: unused_field
      $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isRequired = null,
    Object? allowMultiple = null,
    Object? sortOrder = null,
    Object? choices = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      allowMultiple: null == allowMultiple
          ? _value.allowMultiple
          : allowMultiple // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      choices: null == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<CustomizationChoiceDto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomizationOptionDtoImplCopyWith<$Res>
    implements $CustomizationOptionDtoCopyWith<$Res> {
  factory _$$CustomizationOptionDtoImplCopyWith(
          _$CustomizationOptionDtoImpl value,
          $Res Function(_$CustomizationOptionDtoImpl) then) =
      __$$CustomizationOptionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      bool isRequired,
      bool allowMultiple,
      int sortOrder,
      List<CustomizationChoiceDto> choices});
}

/// @nodoc
class __$$CustomizationOptionDtoImplCopyWithImpl<$Res>
    extends _$CustomizationOptionDtoCopyWithImpl<$Res,
        _$CustomizationOptionDtoImpl>
    implements _$$CustomizationOptionDtoImplCopyWith<$Res> {
  __$$CustomizationOptionDtoImplCopyWithImpl(
      _$CustomizationOptionDtoImpl _value,
      $Res Function(_$CustomizationOptionDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isRequired = null,
    Object? allowMultiple = null,
    Object? sortOrder = null,
    Object? choices = null,
  }) {
    return _then(_$CustomizationOptionDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      allowMultiple: null == allowMultiple
          ? _value.allowMultiple
          : allowMultiple // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      choices: null == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<CustomizationChoiceDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomizationOptionDtoImpl implements _CustomizationOptionDto {
  const _$CustomizationOptionDtoImpl(
      {required this.id,
      required this.name,
      required this.isRequired,
      required this.allowMultiple,
      required this.sortOrder,
      List<CustomizationChoiceDto> choices = const []})
      : _choices = choices;

  factory _$CustomizationOptionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomizationOptionDtoImplFromJson(json);

  @override
      final String id;
  @override
      final String name;
  @override
  final bool isRequired;
  @override
  final bool allowMultiple;
  @override
  final int sortOrder;
  final List<CustomizationChoiceDto> _choices;
  @override
  @JsonKey()
  List<CustomizationChoiceDto> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  @override
  String toString() {
    return 'CustomizationOptionDto(id: $id, name: $name, isRequired: $isRequired, allowMultiple: $allowMultiple, sortOrder: $sortOrder, choices: $choices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomizationOptionDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.allowMultiple, allowMultiple) ||
                other.allowMultiple == allowMultiple) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            const DeepCollectionEquality().equals(other._choices, _choices));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, isRequired,
      allowMultiple, sortOrder, const DeepCollectionEquality().hash(_choices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomizationOptionDtoImplCopyWith<_$CustomizationOptionDtoImpl>
      get copyWith => __$$CustomizationOptionDtoImplCopyWithImpl<
          _$CustomizationOptionDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomizationOptionDtoImplToJson(
      this,
    );
  }
}

abstract class _CustomizationOptionDto implements CustomizationOptionDto {
  const factory _CustomizationOptionDto(
          {required String id,
      required String name,
      required bool isRequired,
      required bool allowMultiple,
      required int sortOrder,
      List<CustomizationChoiceDto> choices}) =
      _$CustomizationOptionDtoImpl;

  factory _CustomizationOptionDto.fromJson(Map<String, dynamic> json) =
      _$CustomizationOptionDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get isRequired;
  @override
  bool get allowMultiple;
  @override
  int get sortOrder;
  @override
  List<CustomizationChoiceDto> get choices;
  @override
  @JsonKey(ignore: true)
  _$$CustomizationOptionDtoImplCopyWith<_$CustomizationOptionDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) {
  return _ProductDto.fromJson(json);
}

/// @nodoc
mixin _$ProductDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  int get prepTimeMinutes => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  List<CustomizationOptionDto> get customizationOptions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductDtoCopyWith<ProductDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDtoCopyWith<$Res> {
  factory $ProductDtoCopyWith(
          ProductDto value, $Res Function(ProductDto) then) =
      _$ProductDtoCopyWithImpl<$Res, ProductDto>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String imageUrl,
      double price,
      int categoryId,
      String categoryName,
      int prepTimeMinutes,
      bool isAvailable,
      List<CustomizationOptionDto> customizationOptions});
}

/// @nodoc
class _$ProductDtoCopyWithImpl<$Res, $Val extends ProductDto>
    implements $ProductDtoCopyWith<$Res> {
  _$ProductDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
      $Val _value;
  // ignore: unused_field
      $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? price = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? prepTimeMinutes = null,
    Object? isAvailable = null,
    Object? customizationOptions = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      prepTimeMinutes: null == prepTimeMinutes
          ? _value.prepTimeMinutes
          : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      customizationOptions: null == customizationOptions
          ? _value.customizationOptions
          : customizationOptions // ignore: cast_nullable_to_non_nullable
              as List<CustomizationOptionDto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductDtoImplCopyWith<$Res>
    implements $ProductDtoCopyWith<$Res> {
  factory _$$ProductDtoImplCopyWith(
          _$ProductDtoImpl value, $Res Function(_$ProductDtoImpl) then) =
      __$$ProductDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String imageUrl,
      double price,
      int categoryId,
      String categoryName,
      int prepTimeMinutes,
      bool isAvailable,
      List<CustomizationOptionDto> customizationOptions});
}

/// @nodoc
class __$$ProductDtoImplCopyWithImpl<$Res>
    extends _$ProductDtoCopyWithImpl<$Res, _$ProductDtoImpl>
    implements _$$ProductDtoImplCopyWith<$Res> {
  __$$ProductDtoImplCopyWithImpl(
      _$ProductDtoImpl _value, $Res Function(_$ProductDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? price = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? prepTimeMinutes = null,
    Object? isAvailable = null,
    Object? customizationOptions = null,
  }) {
    return _then(_$ProductDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      prepTimeMinutes: null == prepTimeMinutes
          ? _value.prepTimeMinutes
          : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      customizationOptions: null == customizationOptions
          ? _value._customizationOptions
          : customizationOptions // ignore: cast_nullable_to_non_nullable
              as List<CustomizationOptionDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductDtoImpl implements _ProductDto {
  const _$ProductDtoImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.price,
      required this.categoryId,
      required this.categoryName,
      required this.prepTimeMinutes,
      required this.isAvailable,
      List<CustomizationOptionDto> customizationOptions = const []})
      : _customizationOptions = customizationOptions;

  factory _$ProductDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductDtoImplFromJson(json);

  @override
      final String id;
  @override
      final String name;
  @override
  final String description;
  @override
  final String imageUrl;
  @override
  final double price;
  @override
  final int categoryId;
  @override
  final String categoryName;
  @override
  final int prepTimeMinutes;
  @override
  final bool isAvailable;
  final List<CustomizationOptionDto> _customizationOptions;
  @override
  @JsonKey()
  List<CustomizationOptionDto> get customizationOptions {
    if (_customizationOptions is EqualUnmodifiableListView)
      return _customizationOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customizationOptions);
  }

  @override
  String toString() {
    return 'ProductDto(id: $id, name: $name, description: $description, imageUrl: $imageUrl, price: $price, categoryId: $categoryId, categoryName: $categoryName, prepTimeMinutes: $prepTimeMinutes, isAvailable: $isAvailable, customizationOptions: $customizationOptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.prepTimeMinutes, prepTimeMinutes) ||
                other.prepTimeMinutes == prepTimeMinutes) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            const DeepCollectionEquality()
                .equals(other._customizationOptions, _customizationOptions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      imageUrl,
      price,
      categoryId,
      categoryName,
      prepTimeMinutes,
      isAvailable,
      const DeepCollectionEquality().hash(_customizationOptions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDtoImplCopyWith<_$ProductDtoImpl> get copyWith =>
      __$$ProductDtoImplCopyWithImpl<_$ProductDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductDtoImplToJson(
      this,
    );
  }
}

abstract class _ProductDto implements ProductDto {
  const factory _ProductDto(
          {required String id,
      required String name,
      required String description,
      required String imageUrl,
      required double price,
      required int categoryId,
      required String categoryName,
      required int prepTimeMinutes,
      required bool isAvailable,
      List<CustomizationOptionDto> customizationOptions}) =
      _$ProductDtoImpl;

  factory _ProductDto.fromJson(Map<String, dynamic> json) =
      _$ProductDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  double get price;
  @override
  int get categoryId;
  @override
  String get categoryName;
  @override
  int get prepTimeMinutes;
  @override
  bool get isAvailable;
  @override
  List<CustomizationOptionDto> get customizationOptions;
  @override
  @JsonKey(ignore: true)
  _$$ProductDtoImplCopyWith<_$ProductDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MenuResponse _$MenuResponseFromJson(Map<String, dynamic> json) {
  return _MenuResponse.fromJson(json);
}

/// @nodoc
mixin _$MenuResponse {
  List<CategoryDto> get categories => throw _privateConstructorUsedError;
  List<ProductDto> get products => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MenuResponseCopyWith<MenuResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuResponseCopyWith<$Res> {
  factory $MenuResponseCopyWith(
          MenuResponse value, $Res Function(MenuResponse) then) =
      _$MenuResponseCopyWithImpl<$Res, MenuResponse>;
  @useResult
  $Res call({List<CategoryDto> categories, List<ProductDto> products});
}

/// @nodoc
class _$MenuResponseCopyWithImpl<$Res, $Val extends MenuResponse>
    implements $MenuResponseCopyWith<$Res> {
  _$MenuResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
      $Val _value;
  // ignore: unused_field
      $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? products = null,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryDto>,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductDto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenuResponseImplCopyWith<$Res>
    implements $MenuResponseCopyWith<$Res> {
  factory _$$MenuResponseImplCopyWith(
          _$MenuResponseImpl value, $Res Function(_$MenuResponseImpl) then) =
      __$$MenuResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CategoryDto> categories, List<ProductDto> products});
}

/// @nodoc
class __$$MenuResponseImplCopyWithImpl<$Res>
    extends _$MenuResponseCopyWithImpl<$Res, _$MenuResponseImpl>
    implements _$$MenuResponseImplCopyWith<$Res> {
  __$$MenuResponseImplCopyWithImpl(
      _$MenuResponseImpl _value, $Res Function(_$MenuResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? products = null,
  }) {
    return _then(_$MenuResponseImpl(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryDto>,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuResponseImpl implements _MenuResponse {
  const _$MenuResponseImpl(
      {List<CategoryDto> categories = const [],
      List<ProductDto> products = const []})
      : _categories = categories,
        _products = products;

  factory _$MenuResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuResponseImplFromJson(json);
      final List<CategoryDto> _categories;
  @override
  @JsonKey()
  List<CategoryDto> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }
      final List<ProductDto> _products;
  @override
  @JsonKey()
  List<ProductDto> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'MenuResponse(categories: $categories, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuResponseImplCopyWith<_$MenuResponseImpl> get copyWith =>
      __$$MenuResponseImplCopyWithImpl<_$MenuResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuResponseImplToJson(
      this,
    );
  }
}

abstract class _MenuResponse implements MenuResponse {
  const factory _MenuResponse(
      {List<CategoryDto> categories,
      List<ProductDto> products}) = _$MenuResponseImpl;

  factory _MenuResponse.fromJson(Map<String, dynamic> json) =
      _$MenuResponseImpl.fromJson;

  @override
  List<CategoryDto> get categories;
  @override
  List<ProductDto> get products;
  @override
  @JsonKey(ignore: true)
  _$$MenuResponseImplCopyWith<_$MenuResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
