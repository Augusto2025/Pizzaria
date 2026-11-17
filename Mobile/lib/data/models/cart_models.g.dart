// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItemDto _$CartItemDtoFromJson(Map<String, dynamic> json) => _CartItemDto(
  id: json['id'] as String,
  userId: json['userId'] as String,
  productId: json['productId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  selectedCustomizationsJson: json['selectedCustomizationsJson'] as String,
  notes: json['notes'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  product: ProductDto.fromJson(json['product'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CartItemDtoToJson(_CartItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'selectedCustomizationsJson': instance.selectedCustomizationsJson,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'product': instance.product,
    };

_CartResponse _$CartResponseFromJson(Map<String, dynamic> json) =>
    _CartResponse(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      subtotal: (json['subtotal'] as num).toDouble(),
    );

Map<String, dynamic> _$CartResponseToJson(_CartResponse instance) =>
    <String, dynamic>{'items': instance.items, 'subtotal': instance.subtotal};

_AddCartItemRequest _$AddCartItemRequestFromJson(Map<String, dynamic> json) =>
    _AddCartItemRequest(
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      selectedCustomizations:
          (json['selectedCustomizations'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AddCartItemRequestToJson(_AddCartItemRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'selectedCustomizations': instance.selectedCustomizations,
      'notes': instance.notes,
    };

_UpdateCartItemRequest _$UpdateCartItemRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateCartItemRequest(
  quantity: (json['quantity'] as num).toInt(),
  selectedCustomizations:
      (json['selectedCustomizations'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$UpdateCartItemRequestToJson(
  _UpdateCartItemRequest instance,
) => <String, dynamic>{
  'quantity': instance.quantity,
  'selectedCustomizations': instance.selectedCustomizations,
  'notes': instance.notes,
};
