// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderStatusDto _$OrderStatusDtoFromJson(Map<String, dynamic> json) {
  return _OrderStatusDto.fromJson(json);
}

/// @nodoc
mixin _$OrderStatusDto {
  int get value => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderStatusDtoCopyWith<OrderStatusDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusDtoCopyWith<$Res> {
  factory $OrderStatusDtoCopyWith(
          OrderStatusDto value, $Res Function(OrderStatusDto) then) =
      _$OrderStatusDtoCopyWithImpl<$Res, OrderStatusDto>;
  @useResult
  $Res call({int value, String label, String color});
}

/// @nodoc
class _$OrderStatusDtoCopyWithImpl<$Res, $Val extends OrderStatusDto>
    implements $OrderStatusDtoCopyWith<$Res> {
  _$OrderStatusDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? label = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderStatusDtoImplCopyWith<$Res>
    implements $OrderStatusDtoCopyWith<$Res> {
  factory _$$OrderStatusDtoImplCopyWith(_$OrderStatusDtoImpl value,
          $Res Function(_$OrderStatusDtoImpl) then) =
      __$$OrderStatusDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, String label, String color});
}

/// @nodoc
class __$$OrderStatusDtoImplCopyWithImpl<$Res>
    extends _$OrderStatusDtoCopyWithImpl<$Res, _$OrderStatusDtoImpl>
    implements _$$OrderStatusDtoImplCopyWith<$Res> {
  __$$OrderStatusDtoImplCopyWithImpl(
      _$OrderStatusDtoImpl _value, $Res Function(_$OrderStatusDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? label = null,
    Object? color = null,
  }) {
    return _then(_$OrderStatusDtoImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderStatusDtoImpl implements _OrderStatusDto {
  const _$OrderStatusDtoImpl(
      {required this.value, required this.label, required this.color});

  factory _$OrderStatusDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderStatusDtoImplFromJson(json);

  @override
  final int value;
  @override
  final String label;
  @override
  final String color;

  @override
  String toString() {
    return 'OrderStatusDto(value: $value, label: $label, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStatusDtoImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, label, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusDtoImplCopyWith<_$OrderStatusDtoImpl> get copyWith =>
      __$$OrderStatusDtoImplCopyWithImpl<_$OrderStatusDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderStatusDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderStatusDto implements OrderStatusDto {
  const factory _OrderStatusDto(
      {required int value,
      required String label,
      required String color}) = _$OrderStatusDtoImpl;

  factory _OrderStatusDto.fromJson(Map<String, dynamic> json) =
      _$OrderStatusDtoImpl.fromJson;

  @override
  int get value;
  @override
  String get label;
  @override
  String get color;
  @override
  @JsonKey(ignore: true)
  _$$OrderStatusDtoImplCopyWith<_$OrderStatusDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusTimelineDto _$StatusTimelineDtoFromJson(Map<String, dynamic> json) {
  return _StatusTimelineDto.fromJson(json);
}

/// @nodoc
mixin _$StatusTimelineDto {
  int get id => throw _privateConstructorUsedError;
  OrderStatusDto get status => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatusTimelineDtoCopyWith<StatusTimelineDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusTimelineDtoCopyWith<$Res> {
  factory $StatusTimelineDtoCopyWith(
          StatusTimelineDto value, $Res Function(StatusTimelineDto) then) =
      _$StatusTimelineDtoCopyWithImpl<$Res, StatusTimelineDto>;
  @useResult
  $Res call({int id, OrderStatusDto status, DateTime timestamp, String note});

  $OrderStatusDtoCopyWith<$Res> get status;
}

/// @nodoc
class _$StatusTimelineDtoCopyWithImpl<$Res, $Val extends StatusTimelineDto>
    implements $StatusTimelineDtoCopyWith<$Res> {
  _$StatusTimelineDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? timestamp = null,
    Object? note = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatusDto,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderStatusDtoCopyWith<$Res> get status {
    return $OrderStatusDtoCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StatusTimelineDtoImplCopyWith<$Res>
    implements $StatusTimelineDtoCopyWith<$Res> {
  factory _$$StatusTimelineDtoImplCopyWith(_$StatusTimelineDtoImpl value,
          $Res Function(_$StatusTimelineDtoImpl) then) =
      __$$StatusTimelineDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, OrderStatusDto status, DateTime timestamp, String note});

  @override
  $OrderStatusDtoCopyWith<$Res> get status;
}

/// @nodoc
class __$$StatusTimelineDtoImplCopyWithImpl<$Res>
    extends _$StatusTimelineDtoCopyWithImpl<$Res, _$StatusTimelineDtoImpl>
    implements _$$StatusTimelineDtoImplCopyWith<$Res> {
  __$$StatusTimelineDtoImplCopyWithImpl(_$StatusTimelineDtoImpl _value,
      $Res Function(_$StatusTimelineDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? timestamp = null,
    Object? note = null,
  }) {
    return _then(_$StatusTimelineDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatusDto,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusTimelineDtoImpl implements _StatusTimelineDto {
  const _$StatusTimelineDtoImpl(
      {required this.id,
      required this.status,
      required this.timestamp,
      required this.note});

  factory _$StatusTimelineDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusTimelineDtoImplFromJson(json);

  @override
  final int id;
  @override
  final OrderStatusDto status;
  @override
  final DateTime timestamp;
  @override
  final String note;

  @override
  String toString() {
    return 'StatusTimelineDto(id: $id, status: $status, timestamp: $timestamp, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusTimelineDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, status, timestamp, note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusTimelineDtoImplCopyWith<_$StatusTimelineDtoImpl> get copyWith =>
      __$$StatusTimelineDtoImplCopyWithImpl<_$StatusTimelineDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusTimelineDtoImplToJson(
      this,
    );
  }
}

abstract class _StatusTimelineDto implements StatusTimelineDto {
  const factory _StatusTimelineDto(
      {required int id,
      required OrderStatusDto status,
      required DateTime timestamp,
      required String note}) = _$StatusTimelineDtoImpl;

  factory _StatusTimelineDto.fromJson(Map<String, dynamic> json) =
      _$StatusTimelineDtoImpl.fromJson;

  @override
  int get id;
  @override
  OrderStatusDto get status;
  @override
  DateTime get timestamp;
  @override
  String get note;
  @override
  @JsonKey(ignore: true)
  _$$StatusTimelineDtoImplCopyWith<_$StatusTimelineDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderItemDto _$OrderItemDtoFromJson(Map<String, dynamic> json) {
  return _OrderItemDto.fromJson(json);
}

/// @nodoc
mixin _$OrderItemDto {
  String get id => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  String get productImageUrl => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  Map<String, String> get customizations => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderItemDtoCopyWith<OrderItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemDtoCopyWith<$Res> {
  factory $OrderItemDtoCopyWith(
          OrderItemDto value, $Res Function(OrderItemDto) then) =
      _$OrderItemDtoCopyWithImpl<$Res, OrderItemDto>;
  @useResult
  $Res call(
      {String id,
      String productId,
      String productName,
      String productImageUrl,
      int quantity,
      double unitPrice,
      Map<String, String> customizations,
      String? notes,
      double totalPrice});
}

/// @nodoc
class _$OrderItemDtoCopyWithImpl<$Res, $Val extends OrderItemDto>
    implements $OrderItemDtoCopyWith<$Res> {
  _$OrderItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? productName = null,
    Object? productImageUrl = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? customizations = null,
    Object? notes = freezed,
    Object? totalPrice = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productImageUrl: null == productImageUrl
          ? _value.productImageUrl
          : productImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      customizations: null == customizations
          ? _value.customizations
          : customizations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderItemDtoImplCopyWith<$Res>
    implements $OrderItemDtoCopyWith<$Res> {
  factory _$$OrderItemDtoImplCopyWith(
          _$OrderItemDtoImpl value, $Res Function(_$OrderItemDtoImpl) then) =
      __$$OrderItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String productId,
      String productName,
      String productImageUrl,
      int quantity,
      double unitPrice,
      Map<String, String> customizations,
      String? notes,
      double totalPrice});
}

/// @nodoc
class __$$OrderItemDtoImplCopyWithImpl<$Res>
    extends _$OrderItemDtoCopyWithImpl<$Res, _$OrderItemDtoImpl>
    implements _$$OrderItemDtoImplCopyWith<$Res> {
  __$$OrderItemDtoImplCopyWithImpl(
      _$OrderItemDtoImpl _value, $Res Function(_$OrderItemDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? productName = null,
    Object? productImageUrl = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? customizations = null,
    Object? notes = freezed,
    Object? totalPrice = null,
  }) {
    return _then(_$OrderItemDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productImageUrl: null == productImageUrl
          ? _value.productImageUrl
          : productImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      customizations: null == customizations
          ? _value._customizations
          : customizations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemDtoImpl implements _OrderItemDto {
  const _$OrderItemDtoImpl(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.productImageUrl,
      required this.quantity,
      required this.unitPrice,
      required Map<String, String> customizations,
      this.notes,
      required this.totalPrice})
      : _customizations = customizations;

  factory _$OrderItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String productId;
  @override
  final String productName;
  @override
  final String productImageUrl;
  @override
  final int quantity;
  @override
  final double unitPrice;
  final Map<String, String> _customizations;
  @override
  Map<String, String> get customizations {
    if (_customizations is EqualUnmodifiableMapView) return _customizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customizations);
  }

  @override
  final String? notes;
  @override
  final double totalPrice;

  @override
  String toString() {
    return 'OrderItemDto(id: $id, productId: $productId, productName: $productName, productImageUrl: $productImageUrl, quantity: $quantity, unitPrice: $unitPrice, customizations: $customizations, notes: $notes, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productImageUrl, productImageUrl) ||
                other.productImageUrl == productImageUrl) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            const DeepCollectionEquality()
                .equals(other._customizations, _customizations) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      productId,
      productName,
      productImageUrl,
      quantity,
      unitPrice,
      const DeepCollectionEquality().hash(_customizations),
      notes,
      totalPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemDtoImplCopyWith<_$OrderItemDtoImpl> get copyWith =>
      __$$OrderItemDtoImplCopyWithImpl<_$OrderItemDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderItemDto implements OrderItemDto {
  const factory _OrderItemDto(
      {required String id,
      required String productId,
      required String productName,
      required String productImageUrl,
      required int quantity,
      required double unitPrice,
      required Map<String, String> customizations,
      String? notes,
      required double totalPrice}) = _$OrderItemDtoImpl;

  factory _OrderItemDto.fromJson(Map<String, dynamic> json) =
      _$OrderItemDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get productId;
  @override
  String get productName;
  @override
  String get productImageUrl;
  @override
  int get quantity;
  @override
  double get unitPrice;
  @override
  Map<String, String> get customizations;
  @override
  String? get notes;
  @override
  double get totalPrice;
  @override
  @JsonKey(ignore: true)
  _$$OrderItemDtoImplCopyWith<_$OrderItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) {
  return _OrderDto.fromJson(json);
}

/// @nodoc
mixin _$OrderDto {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  OrderStatusDto get status => throw _privateConstructorUsedError;
  AddressDto get deliveryAddress => throw _privateConstructorUsedError;
  int get paymentMethod => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;
  double get deliveryFee => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get estimatedDeliveryTime => throw _privateConstructorUsedError;
  List<OrderItemDto> get items => throw _privateConstructorUsedError;
  List<StatusTimelineDto> get timeline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderDtoCopyWith<OrderDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDtoCopyWith<$Res> {
  factory $OrderDtoCopyWith(OrderDto value, $Res Function(OrderDto) then) =
      _$OrderDtoCopyWithImpl<$Res, OrderDto>;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime createdAt,
      OrderStatusDto status,
      AddressDto deliveryAddress,
      int paymentMethod,
      double subtotal,
      double deliveryFee,
      double total,
      String? notes,
      DateTime? estimatedDeliveryTime,
      List<OrderItemDto> items,
      List<StatusTimelineDto> timeline});

  $OrderStatusDtoCopyWith<$Res> get status;
  $AddressDtoCopyWith<$Res> get deliveryAddress;
}

/// @nodoc
class _$OrderDtoCopyWithImpl<$Res, $Val extends OrderDto>
    implements $OrderDtoCopyWith<$Res> {
  _$OrderDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? status = null,
    Object? deliveryAddress = null,
    Object? paymentMethod = null,
    Object? subtotal = null,
    Object? deliveryFee = null,
    Object? total = null,
    Object? notes = freezed,
    Object? estimatedDeliveryTime = freezed,
    Object? items = null,
    Object? timeline = null,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatusDto,
      deliveryAddress: null == deliveryAddress
          ? _value.deliveryAddress
          : deliveryAddress // ignore: cast_nullable_to_non_nullable
              as AddressDto,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as int,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      deliveryFee: null == deliveryFee
          ? _value.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedDeliveryTime: freezed == estimatedDeliveryTime
          ? _value.estimatedDeliveryTime
          : estimatedDeliveryTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItemDto>,
      timeline: null == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as List<StatusTimelineDto>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderStatusDtoCopyWith<$Res> get status {
    return $OrderStatusDtoCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressDtoCopyWith<$Res> get deliveryAddress {
    return $AddressDtoCopyWith<$Res>(_value.deliveryAddress, (value) {
      return _then(_value.copyWith(deliveryAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderDtoImplCopyWith<$Res>
    implements $OrderDtoCopyWith<$Res> {
  factory _$$OrderDtoImplCopyWith(
          _$OrderDtoImpl value, $Res Function(_$OrderDtoImpl) then) =
      __$$OrderDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime createdAt,
      OrderStatusDto status,
      AddressDto deliveryAddress,
      int paymentMethod,
      double subtotal,
      double deliveryFee,
      double total,
      String? notes,
      DateTime? estimatedDeliveryTime,
      List<OrderItemDto> items,
      List<StatusTimelineDto> timeline});

  @override
  $OrderStatusDtoCopyWith<$Res> get status;
  @override
  $AddressDtoCopyWith<$Res> get deliveryAddress;
}

/// @nodoc
class __$$OrderDtoImplCopyWithImpl<$Res>
    extends _$OrderDtoCopyWithImpl<$Res, _$OrderDtoImpl>
    implements _$$OrderDtoImplCopyWith<$Res> {
  __$$OrderDtoImplCopyWithImpl(
      _$OrderDtoImpl _value, $Res Function(_$OrderDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? status = null,
    Object? deliveryAddress = null,
    Object? paymentMethod = null,
    Object? subtotal = null,
    Object? deliveryFee = null,
    Object? total = null,
    Object? notes = freezed,
    Object? estimatedDeliveryTime = freezed,
    Object? items = null,
    Object? timeline = null,
  }) {
    return _then(_$OrderDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatusDto,
      deliveryAddress: null == deliveryAddress
          ? _value.deliveryAddress
          : deliveryAddress // ignore: cast_nullable_to_non_nullable
              as AddressDto,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as int,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      deliveryFee: null == deliveryFee
          ? _value.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedDeliveryTime: freezed == estimatedDeliveryTime
          ? _value.estimatedDeliveryTime
          : estimatedDeliveryTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItemDto>,
      timeline: null == timeline
          ? _value._timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as List<StatusTimelineDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderDtoImpl implements _OrderDto {
  const _$OrderDtoImpl(
      {required this.id,
      required this.userId,
      required this.createdAt,
      required this.status,
      required this.deliveryAddress,
      required this.paymentMethod,
      required this.subtotal,
      required this.deliveryFee,
      required this.total,
      this.notes,
      this.estimatedDeliveryTime,
      required List<OrderItemDto> items,
      required List<StatusTimelineDto> timeline})
      : _items = items,
        _timeline = timeline;

  factory _$OrderDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime createdAt;
  @override
  final OrderStatusDto status;
  @override
  final AddressDto deliveryAddress;
  @override
  final int paymentMethod;
  @override
  final double subtotal;
  @override
  final double deliveryFee;
  @override
  final double total;
  @override
  final String? notes;
  @override
  final DateTime? estimatedDeliveryTime;
  final List<OrderItemDto> _items;
  @override
  List<OrderItemDto> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<StatusTimelineDto> _timeline;
  @override
  List<StatusTimelineDto> get timeline {
    if (_timeline is EqualUnmodifiableListView) return _timeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeline);
  }

  @override
  String toString() {
    return 'OrderDto(id: $id, userId: $userId, createdAt: $createdAt, status: $status, deliveryAddress: $deliveryAddress, paymentMethod: $paymentMethod, subtotal: $subtotal, deliveryFee: $deliveryFee, total: $total, notes: $notes, estimatedDeliveryTime: $estimatedDeliveryTime, items: $items, timeline: $timeline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.deliveryAddress, deliveryAddress) ||
                other.deliveryAddress == deliveryAddress) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.estimatedDeliveryTime, estimatedDeliveryTime) ||
                other.estimatedDeliveryTime == estimatedDeliveryTime) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other._timeline, _timeline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      createdAt,
      status,
      deliveryAddress,
      paymentMethod,
      subtotal,
      deliveryFee,
      total,
      notes,
      estimatedDeliveryTime,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_timeline));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDtoImplCopyWith<_$OrderDtoImpl> get copyWith =>
      __$$OrderDtoImplCopyWithImpl<_$OrderDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderDto implements OrderDto {
  const factory _OrderDto(
      {required String id,
      required String userId,
      required DateTime createdAt,
      required OrderStatusDto status,
      required AddressDto deliveryAddress,
      required int paymentMethod,
      required double subtotal,
      required double deliveryFee,
      required double total,
      String? notes,
      DateTime? estimatedDeliveryTime,
      required List<OrderItemDto> items,
      required List<StatusTimelineDto> timeline}) = _$OrderDtoImpl;

  factory _OrderDto.fromJson(Map<String, dynamic> json) =
      _$OrderDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  DateTime get createdAt;
  @override
  OrderStatusDto get status;
  @override
  AddressDto get deliveryAddress;
  @override
  int get paymentMethod;
  @override
  double get subtotal;
  @override
  double get deliveryFee;
  @override
  double get total;
  @override
  String? get notes;
  @override
  DateTime? get estimatedDeliveryTime;
  @override
  List<OrderItemDto> get items;
  @override
  List<StatusTimelineDto> get timeline;
  @override
  @JsonKey(ignore: true)
  _$$OrderDtoImplCopyWith<_$OrderDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrdersResponse _$OrdersResponseFromJson(Map<String, dynamic> json) {
  return _OrdersResponse.fromJson(json);
}

/// @nodoc
mixin _$OrdersResponse {
  List<OrderDto> get orders => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrdersResponseCopyWith<OrdersResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersResponseCopyWith<$Res> {
  factory $OrdersResponseCopyWith(
          OrdersResponse value, $Res Function(OrdersResponse) then) =
      _$OrdersResponseCopyWithImpl<$Res, OrdersResponse>;
  @useResult
  $Res call({List<OrderDto> orders});
}

/// @nodoc
class _$OrdersResponseCopyWithImpl<$Res, $Val extends OrdersResponse>
    implements $OrdersResponseCopyWith<$Res> {
  _$OrdersResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_value.copyWith(
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderDto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrdersResponseImplCopyWith<$Res>
    implements $OrdersResponseCopyWith<$Res> {
  factory _$$OrdersResponseImplCopyWith(_$OrdersResponseImpl value,
          $Res Function(_$OrdersResponseImpl) then) =
      __$$OrdersResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OrderDto> orders});
}

/// @nodoc
class __$$OrdersResponseImplCopyWithImpl<$Res>
    extends _$OrdersResponseCopyWithImpl<$Res, _$OrdersResponseImpl>
    implements _$$OrdersResponseImplCopyWith<$Res> {
  __$$OrdersResponseImplCopyWithImpl(
      _$OrdersResponseImpl _value, $Res Function(_$OrdersResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_$OrdersResponseImpl(
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrdersResponseImpl implements _OrdersResponse {
  const _$OrdersResponseImpl({required List<OrderDto> orders})
      : _orders = orders;

  factory _$OrdersResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrdersResponseImplFromJson(json);

  final List<OrderDto> _orders;
  @override
  List<OrderDto> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  String toString() {
    return 'OrdersResponse(orders: $orders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersResponseImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersResponseImplCopyWith<_$OrdersResponseImpl> get copyWith =>
      __$$OrdersResponseImplCopyWithImpl<_$OrdersResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrdersResponseImplToJson(
      this,
    );
  }
}

abstract class _OrdersResponse implements OrdersResponse {
  const factory _OrdersResponse({required List<OrderDto> orders}) =
      _$OrdersResponseImpl;

  factory _OrdersResponse.fromJson(Map<String, dynamic> json) =
      _$OrdersResponseImpl.fromJson;

  @override
  List<OrderDto> get orders;
  @override
  @JsonKey(ignore: true)
  _$$OrdersResponseImplCopyWith<_$OrdersResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateOrderRequest _$CreateOrderRequestFromJson(Map<String, dynamic> json) {
  return _CreateOrderRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateOrderRequest {
  String get deliveryAddressId => throw _privateConstructorUsedError;
  int get paymentMethod => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateOrderRequestCopyWith<CreateOrderRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateOrderRequestCopyWith<$Res> {
  factory $CreateOrderRequestCopyWith(
          CreateOrderRequest value, $Res Function(CreateOrderRequest) then) =
      _$CreateOrderRequestCopyWithImpl<$Res, CreateOrderRequest>;
  @useResult
  $Res call({String deliveryAddressId, int paymentMethod, String? notes});
}

/// @nodoc
class _$CreateOrderRequestCopyWithImpl<$Res, $Val extends CreateOrderRequest>
    implements $CreateOrderRequestCopyWith<$Res> {
  _$CreateOrderRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deliveryAddressId = null,
    Object? paymentMethod = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      deliveryAddressId: null == deliveryAddressId
          ? _value.deliveryAddressId
          : deliveryAddressId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateOrderRequestImplCopyWith<$Res>
    implements $CreateOrderRequestCopyWith<$Res> {
  factory _$$CreateOrderRequestImplCopyWith(_$CreateOrderRequestImpl value,
          $Res Function(_$CreateOrderRequestImpl) then) =
      __$$CreateOrderRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String deliveryAddressId, int paymentMethod, String? notes});
}

/// @nodoc
class __$$CreateOrderRequestImplCopyWithImpl<$Res>
    extends _$CreateOrderRequestCopyWithImpl<$Res, _$CreateOrderRequestImpl>
    implements _$$CreateOrderRequestImplCopyWith<$Res> {
  __$$CreateOrderRequestImplCopyWithImpl(_$CreateOrderRequestImpl _value,
      $Res Function(_$CreateOrderRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deliveryAddressId = null,
    Object? paymentMethod = null,
    Object? notes = freezed,
  }) {
    return _then(_$CreateOrderRequestImpl(
      deliveryAddressId: null == deliveryAddressId
          ? _value.deliveryAddressId
          : deliveryAddressId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateOrderRequestImpl implements _CreateOrderRequest {
  const _$CreateOrderRequestImpl(
      {required this.deliveryAddressId,
      required this.paymentMethod,
      this.notes});

  factory _$CreateOrderRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateOrderRequestImplFromJson(json);

  @override
  final String deliveryAddressId;
  @override
  final int paymentMethod;
  @override
  final String? notes;

  @override
  String toString() {
    return 'CreateOrderRequest(deliveryAddressId: $deliveryAddressId, paymentMethod: $paymentMethod, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateOrderRequestImpl &&
            (identical(other.deliveryAddressId, deliveryAddressId) ||
                other.deliveryAddressId == deliveryAddressId) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, deliveryAddressId, paymentMethod, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateOrderRequestImplCopyWith<_$CreateOrderRequestImpl> get copyWith =>
      __$$CreateOrderRequestImplCopyWithImpl<_$CreateOrderRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateOrderRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateOrderRequest implements CreateOrderRequest {
  const factory _CreateOrderRequest(
      {required String deliveryAddressId,
      required int paymentMethod,
      String? notes}) = _$CreateOrderRequestImpl;

  factory _CreateOrderRequest.fromJson(Map<String, dynamic> json) =
      _$CreateOrderRequestImpl.fromJson;

  @override
  String get deliveryAddressId;
  @override
  int get paymentMethod;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$CreateOrderRequestImplCopyWith<_$CreateOrderRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
