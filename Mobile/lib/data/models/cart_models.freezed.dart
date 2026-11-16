// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
      final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CartItemDto _$CartItemDtoFromJson(Map<String, dynamic> json) {
  return _CartItemDto.fromJson(json);
}

/// @nodoc
mixin _$CartItemDto {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get selectedCustomizationsJson => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  ProductDto get product => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartItemDtoCopyWith<CartItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemDtoCopyWith<$Res> {
  factory $CartItemDtoCopyWith(
          CartItemDto value, $Res Function(CartItemDto) then) =
      _$CartItemDtoCopyWithImpl<$Res, CartItemDto>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String productId,
      int quantity,
      String selectedCustomizationsJson,
      String? notes,
      DateTime createdAt,
      ProductDto product});

  $ProductDtoCopyWith<$Res> get product;
}

/// @nodoc
class _$CartItemDtoCopyWithImpl<$Res, $Val extends CartItemDto>
    implements $CartItemDtoCopyWith<$Res> {
  _$CartItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
      $Val _value;
  // ignore: unused_field
      $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? selectedCustomizationsJson = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? product = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCustomizationsJson: null == selectedCustomizationsJson
          ? _value.selectedCustomizationsJson
          : selectedCustomizationsJson // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductDto,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductDtoCopyWith<$Res> get product {
    return $ProductDtoCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CartItemDtoImplCopyWith<$Res>
    implements $CartItemDtoCopyWith<$Res> {
  factory _$$CartItemDtoImplCopyWith(
          _$CartItemDtoImpl value, $Res Function(_$CartItemDtoImpl) then) =
      __$$CartItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String productId,
      int quantity,
      String selectedCustomizationsJson,
      String? notes,
      DateTime createdAt,
      ProductDto product});

  @override
  $ProductDtoCopyWith<$Res> get product;
}

/// @nodoc
class __$$CartItemDtoImplCopyWithImpl<$Res>
    extends _$CartItemDtoCopyWithImpl<$Res, _$CartItemDtoImpl>
    implements _$$CartItemDtoImplCopyWith<$Res> {
  __$$CartItemDtoImplCopyWithImpl(
      _$CartItemDtoImpl _value, $Res Function(_$CartItemDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? selectedCustomizationsJson = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? product = null,
  }) {
    return _then(_$CartItemDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCustomizationsJson: null == selectedCustomizationsJson
          ? _value.selectedCustomizationsJson
          : selectedCustomizationsJson // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductDto,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartItemDtoImpl implements _CartItemDto {
  const _$CartItemDtoImpl(
      {required this.id,
      required this.userId,
      required this.productId,
      required this.quantity,
      required this.selectedCustomizationsJson,
      this.notes,
      required this.createdAt,
      required this.product});

  factory _$CartItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartItemDtoImplFromJson(json);

  @override
      final String id;
  @override
      final String userId;
  @override
  final String productId;
  @override
  final int quantity;
  @override
  final String selectedCustomizationsJson;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final ProductDto product;

  @override
  String toString() {
    return 'CartItemDto(id: $id, userId: $userId, productId: $productId, quantity: $quantity, selectedCustomizationsJson: $selectedCustomizationsJson, notes: $notes, createdAt: $createdAt, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.selectedCustomizationsJson,
                    selectedCustomizationsJson) ||
                other.selectedCustomizationsJson ==
                    selectedCustomizationsJson) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, productId, quantity,
      selectedCustomizationsJson, notes, createdAt, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemDtoImplCopyWith<_$CartItemDtoImpl> get copyWith =>
      __$$CartItemDtoImplCopyWithImpl<_$CartItemDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartItemDtoImplToJson(
      this,
    );
  }
}

abstract class _CartItemDto implements CartItemDto {
  const factory _CartItemDto(
      {required String id,
      required String userId,
      required String productId,
      required int quantity,
      required String selectedCustomizationsJson,
      String? notes,
      required DateTime createdAt,
      required ProductDto product}) = _$CartItemDtoImpl;

  factory _CartItemDto.fromJson(Map<String, dynamic> json) =
      _$CartItemDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get productId;
  @override
  int get quantity;
  @override
  String get selectedCustomizationsJson;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  ProductDto get product;
  @override
  @JsonKey(ignore: true)
  _$$CartItemDtoImplCopyWith<_$CartItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) {
  return _CartResponse.fromJson(json);
}

/// @nodoc
mixin _$CartResponse {
  List<CartItemDto> get items => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartResponseCopyWith<CartResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartResponseCopyWith<$Res> {
  factory $CartResponseCopyWith(
          CartResponse value, $Res Function(CartResponse) then) =
      _$CartResponseCopyWithImpl<$Res, CartResponse>;
  @useResult
  $Res call({List<CartItemDto> items, double subtotal});
}

/// @nodoc
class _$CartResponseCopyWithImpl<$Res, $Val extends CartResponse>
    implements $CartResponseCopyWith<$Res> {
  _$CartResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
      $Val _value;
  // ignore: unused_field
      $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? subtotal = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CartItemDto>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartResponseImplCopyWith<$Res>
    implements $CartResponseCopyWith<$Res> {
  factory _$$CartResponseImplCopyWith(
          _$CartResponseImpl value, $Res Function(_$CartResponseImpl) then) =
      __$$CartResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CartItemDto> items, double subtotal});
}

/// @nodoc
class __$$CartResponseImplCopyWithImpl<$Res>
    extends _$CartResponseCopyWithImpl<$Res, _$CartResponseImpl>
    implements _$$CartResponseImplCopyWith<$Res> {
  __$$CartResponseImplCopyWithImpl(
      _$CartResponseImpl _value, $Res Function(_$CartResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? subtotal = null,
  }) {
    return _then(_$CartResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CartItemDto>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartResponseImpl implements _CartResponse {
  const _$CartResponseImpl(
      {List<CartItemDto> items = const [], required this.subtotal})
      : _items = items;

  factory _$CartResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartResponseImplFromJson(json);
      final List<CartItemDto> _items;
  @override
  @JsonKey()
  List<CartItemDto> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
      final double subtotal;

  @override
  String toString() {
    return 'CartResponse(items: $items, subtotal: $subtotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), subtotal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartResponseImplCopyWith<_$CartResponseImpl> get copyWith =>
      __$$CartResponseImplCopyWithImpl<_$CartResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartResponseImplToJson(
      this,
    );
  }
}

abstract class _CartResponse implements CartResponse {
  const factory _CartResponse(
      {List<CartItemDto> items,
      required double subtotal}) = _$CartResponseImpl;

  factory _CartResponse.fromJson(Map<String, dynamic> json) =
      _$CartResponseImpl.fromJson;

  @override
  List<CartItemDto> get items;
  @override
  double get subtotal;
  @override
  @JsonKey(ignore: true)
  _$$CartResponseImplCopyWith<_$CartResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddCartItemRequest _$AddCartItemRequestFromJson(Map<String, dynamic> json) {
  return _AddCartItemRequest.fromJson(json);
}

/// @nodoc
mixin _$AddCartItemRequest {
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  Map<String, String>? get selectedCustomizations =>
      throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddCartItemRequestCopyWith<AddCartItemRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddCartItemRequestCopyWith<$Res> {
  factory $AddCartItemRequestCopyWith(
          AddCartItemRequest value, $Res Function(AddCartItemRequest) then) =
      _$AddCartItemRequestCopyWithImpl<$Res, AddCartItemRequest>;
  @useResult
  $Res call(
      {String productId,
      int quantity,
      Map<String, String>? selectedCustomizations,
      String? notes});
}

/// @nodoc
class _$AddCartItemRequestCopyWithImpl<$Res, $Val extends AddCartItemRequest>
    implements $AddCartItemRequestCopyWith<$Res> {
  _$AddCartItemRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
      $Val _value;
  // ignore: unused_field
      $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? selectedCustomizations = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCustomizations: freezed == selectedCustomizations
          ? _value.selectedCustomizations
          : selectedCustomizations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddCartItemRequestImplCopyWith<$Res>
    implements $AddCartItemRequestCopyWith<$Res> {
  factory _$$AddCartItemRequestImplCopyWith(_$AddCartItemRequestImpl value,
          $Res Function(_$AddCartItemRequestImpl) then) =
      __$$AddCartItemRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productId,
      int quantity,
      Map<String, String>? selectedCustomizations,
      String? notes});
}

/// @nodoc
class __$$AddCartItemRequestImplCopyWithImpl<$Res>
    extends _$AddCartItemRequestCopyWithImpl<$Res, _$AddCartItemRequestImpl>
    implements _$$AddCartItemRequestImplCopyWith<$Res> {
  __$$AddCartItemRequestImplCopyWithImpl(_$AddCartItemRequestImpl _value,
      $Res Function(_$AddCartItemRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? selectedCustomizations = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$AddCartItemRequestImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCustomizations: freezed == selectedCustomizations
          ? _value._selectedCustomizations
          : selectedCustomizations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddCartItemRequestImpl implements _AddCartItemRequest {
  const _$AddCartItemRequestImpl(
      {required this.productId,
      required this.quantity,
      Map<String, String>? selectedCustomizations,
      this.notes})
      : _selectedCustomizations = selectedCustomizations;

  factory _$AddCartItemRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddCartItemRequestImplFromJson(json);

  @override
      final String productId;
  @override
      final int quantity;
  final Map<String, String>? _selectedCustomizations;
  @override
  Map<String, String>? get selectedCustomizations {
      final value = _selectedCustomizations;
    if (value == null) return null;
    if (_selectedCustomizations is EqualUnmodifiableMapView)
      return _selectedCustomizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
      final String? notes;

  @override
  String toString() {
    return 'AddCartItemRequest(productId: $productId, quantity: $quantity, selectedCustomizations: $selectedCustomizations, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCartItemRequestImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            const DeepCollectionEquality().equals(
                other._selectedCustomizations, _selectedCustomizations) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, productId, quantity,
      const DeepCollectionEquality().hash(_selectedCustomizations), notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCartItemRequestImplCopyWith<_$AddCartItemRequestImpl> get copyWith =>
      __$$AddCartItemRequestImplCopyWithImpl<_$AddCartItemRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddCartItemRequestImplToJson(
      this,
    );
  }
}

abstract class _AddCartItemRequest implements AddCartItemRequest {
  const factory _AddCartItemRequest(
      {required String productId,
      required int quantity,
      Map<String, String>? selectedCustomizations,
      String? notes}) = _$AddCartItemRequestImpl;

  factory _AddCartItemRequest.fromJson(Map<String, dynamic> json) =
      _$AddCartItemRequestImpl.fromJson;

  @override
  String get productId;
  @override
  int get quantity;
  @override
  Map<String, String>? get selectedCustomizations;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$AddCartItemRequestImplCopyWith<_$AddCartItemRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateCartItemRequest _$UpdateCartItemRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdateCartItemRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateCartItemRequest {
  int get quantity => throw _privateConstructorUsedError;
  Map<String, String>? get selectedCustomizations =>
      throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateCartItemRequestCopyWith<UpdateCartItemRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCartItemRequestCopyWith<$Res> {
  factory $UpdateCartItemRequestCopyWith(UpdateCartItemRequest value,
          $Res Function(UpdateCartItemRequest) then) =
      _$UpdateCartItemRequestCopyWithImpl<$Res, UpdateCartItemRequest>;
  @useResult
  $Res call(
      {int quantity,
      Map<String, String>? selectedCustomizations,
      String? notes});
}

/// @nodoc
class _$UpdateCartItemRequestCopyWithImpl<$Res,
        $Val extends UpdateCartItemRequest>
    implements $UpdateCartItemRequestCopyWith<$Res> {
  _$UpdateCartItemRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
      $Val _value;
  // ignore: unused_field
      $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? selectedCustomizations = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCustomizations: freezed == selectedCustomizations
          ? _value.selectedCustomizations
          : selectedCustomizations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateCartItemRequestImplCopyWith<$Res>
    implements $UpdateCartItemRequestCopyWith<$Res> {
  factory _$$UpdateCartItemRequestImplCopyWith(
          _$UpdateCartItemRequestImpl value,
          $Res Function(_$UpdateCartItemRequestImpl) then) =
      __$$UpdateCartItemRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int quantity,
      Map<String, String>? selectedCustomizations,
      String? notes});
}

/// @nodoc
class __$$UpdateCartItemRequestImplCopyWithImpl<$Res>
    extends _$UpdateCartItemRequestCopyWithImpl<$Res,
        _$UpdateCartItemRequestImpl>
    implements _$$UpdateCartItemRequestImplCopyWith<$Res> {
  __$$UpdateCartItemRequestImplCopyWithImpl(_$UpdateCartItemRequestImpl _value,
      $Res Function(_$UpdateCartItemRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? selectedCustomizations = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$UpdateCartItemRequestImpl(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCustomizations: freezed == selectedCustomizations
          ? _value._selectedCustomizations
          : selectedCustomizations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateCartItemRequestImpl implements _UpdateCartItemRequest {
  const _$UpdateCartItemRequestImpl(
      {required this.quantity,
      Map<String, String>? selectedCustomizations,
      this.notes})
      : _selectedCustomizations = selectedCustomizations;

  factory _$UpdateCartItemRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateCartItemRequestImplFromJson(json);

  @override
      final int quantity;
      final Map<String, String>? _selectedCustomizations;
  @override
  Map<String, String>? get selectedCustomizations {
      final value = _selectedCustomizations;
    if (value == null) return null;
    if (_selectedCustomizations is EqualUnmodifiableMapView)
      return _selectedCustomizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
      final String? notes;

  @override
  String toString() {
    return 'UpdateCartItemRequest(quantity: $quantity, selectedCustomizations: $selectedCustomizations, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCartItemRequestImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            const DeepCollectionEquality().equals(
                other._selectedCustomizations, _selectedCustomizations) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, quantity,
      const DeepCollectionEquality().hash(_selectedCustomizations), notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCartItemRequestImplCopyWith<_$UpdateCartItemRequestImpl>
      get copyWith => __$$UpdateCartItemRequestImplCopyWithImpl<
          _$UpdateCartItemRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateCartItemRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateCartItemRequest implements UpdateCartItemRequest {
  const factory _UpdateCartItemRequest(
      {required int quantity,
      Map<String, String>? selectedCustomizations,
      String? notes}) = _$UpdateCartItemRequestImpl;

  factory _UpdateCartItemRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateCartItemRequestImpl.fromJson;

  @override
  int get quantity;
  @override
  Map<String, String>? get selectedCustomizations;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$UpdateCartItemRequestImplCopyWith<_$UpdateCartItemRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
