// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartItemDtoImpl _$$CartItemDtoImplFromJson(Map<String, dynamic> json) =>
    _$CartItemDtoImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      selectedCustomizationsJson: json['selectedCustomizationsJson'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      product: ProductDto.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CartItemDtoImplToJson(_$CartItemDtoImpl instance) =>
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

_$CartResponseImpl _$$CartResponseImplFromJson(Map<String, dynamic> json) =>
    _$CartResponseImpl(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      subtotal: (json['subtotal'] as num).toDouble(),
    );

Map<String, dynamic> _$$CartResponseImplToJson(_$CartResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'subtotal': instance.subtotal,
    };

_$AddCartItemRequestImpl _$$AddCartItemRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AddCartItemRequestImpl(
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      selectedCustomizations:
          (json['selectedCustomizations'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$AddCartItemRequestImplToJson(
        _$AddCartItemRequestImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'selectedCustomizations': instance.selectedCustomizations,
      'notes': instance.notes,
    };

_$UpdateCartItemRequestImpl _$$UpdateCartItemRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateCartItemRequestImpl(
      quantity: (json['quantity'] as num).toInt(),
      selectedCustomizations:
          (json['selectedCustomizations'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$UpdateCartItemRequestImplToJson(
        _$UpdateCartItemRequestImpl instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'selectedCustomizations': instance.selectedCustomizations,
      'notes': instance.notes,
    };
