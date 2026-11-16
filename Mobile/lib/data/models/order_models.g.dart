// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderStatusDtoImpl _$$OrderStatusDtoImplFromJson(Map<String, dynamic> json) =>
    _$OrderStatusDtoImpl(
      value: (json['value'] as num).toInt(),
      label: json['label'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$$OrderStatusDtoImplToJson(
        _$OrderStatusDtoImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'color': instance.color,
    };

_$StatusTimelineDtoImpl _$$StatusTimelineDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusTimelineDtoImpl(
      id: (json['id'] as num).toInt(),
      status: OrderStatusDto.fromJson(json['status'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
      note: json['note'] as String,
    );

Map<String, dynamic> _$$StatusTimelineDtoImplToJson(
        _$StatusTimelineDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'timestamp': instance.timestamp.toIso8601String(),
      'note': instance.note,
    };

_$OrderItemDtoImpl _$$OrderItemDtoImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemDtoImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImageUrl: json['productImageUrl'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      customizations: Map<String, String>.from(json['customizations'] as Map),
      notes: json['notes'] as String?,
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$OrderItemDtoImplToJson(_$OrderItemDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'productImageUrl': instance.productImageUrl,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'customizations': instance.customizations,
      'notes': instance.notes,
      'totalPrice': instance.totalPrice,
    };

_$OrderDtoImpl _$$OrderDtoImplFromJson(Map<String, dynamic> json) =>
    _$OrderDtoImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: OrderStatusDto.fromJson(json['status'] as Map<String, dynamic>),
      deliveryAddress:
          AddressDto.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
      paymentMethod: (json['paymentMethod'] as num).toInt(),
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      notes: json['notes'] as String?,
      estimatedDeliveryTime: json['estimatedDeliveryTime'] == null
          ? null
          : DateTime.parse(json['estimatedDeliveryTime'] as String),
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeline: (json['timeline'] as List<dynamic>)
          .map((e) => StatusTimelineDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OrderDtoImplToJson(_$OrderDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': instance.status,
      'deliveryAddress': instance.deliveryAddress,
      'paymentMethod': instance.paymentMethod,
      'subtotal': instance.subtotal,
      'deliveryFee': instance.deliveryFee,
      'total': instance.total,
      'notes': instance.notes,
      'estimatedDeliveryTime':
          instance.estimatedDeliveryTime?.toIso8601String(),
      'items': instance.items,
      'timeline': instance.timeline,
    };

_$OrdersResponseImpl _$$OrdersResponseImplFromJson(Map<String, dynamic> json) =>
    _$OrdersResponseImpl(
      orders: (json['orders'] as List<dynamic>)
          .map((e) => OrderDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OrdersResponseImplToJson(
        _$OrdersResponseImpl instance) =>
    <String, dynamic>{
      'orders': instance.orders,
    };

_$CreateOrderRequestImpl _$$CreateOrderRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateOrderRequestImpl(
      deliveryAddressId: json['deliveryAddressId'] as String,
      paymentMethod: (json['paymentMethod'] as num).toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$CreateOrderRequestImplToJson(
        _$CreateOrderRequestImpl instance) =>
    <String, dynamic>{
      'deliveryAddressId': instance.deliveryAddressId,
      'paymentMethod': instance.paymentMethod,
      'notes': instance.notes,
    };
