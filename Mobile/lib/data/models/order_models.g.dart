// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderStatusDto _$OrderStatusDtoFromJson(Map<String, dynamic> json) =>
    _OrderStatusDto(
      value: (json['value'] as num).toInt(),
      label: json['label'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$OrderStatusDtoToJson(_OrderStatusDto instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'color': instance.color,
    };

_StatusTimelineDto _$StatusTimelineDtoFromJson(Map<String, dynamic> json) =>
    _StatusTimelineDto(
      id: (json['id'] as num).toInt(),
      status: OrderStatusDto.fromJson(json['status'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
      note: json['note'] as String,
    );

Map<String, dynamic> _$StatusTimelineDtoToJson(_StatusTimelineDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'timestamp': instance.timestamp.toIso8601String(),
      'note': instance.note,
    };

_OrderItemDto _$OrderItemDtoFromJson(Map<String, dynamic> json) =>
    _OrderItemDto(
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

Map<String, dynamic> _$OrderItemDtoToJson(_OrderItemDto instance) =>
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

_OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => _OrderDto(
  id: json['id'] as String,
  userId: json['userId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  status: OrderStatusDto.fromJson(json['status'] as Map<String, dynamic>),
  deliveryAddress: AddressDto.fromJson(
    json['deliveryAddress'] as Map<String, dynamic>,
  ),
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

Map<String, dynamic> _$OrderDtoToJson(_OrderDto instance) => <String, dynamic>{
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
  'estimatedDeliveryTime': instance.estimatedDeliveryTime?.toIso8601String(),
  'items': instance.items,
  'timeline': instance.timeline,
};

_OrdersResponse _$OrdersResponseFromJson(Map<String, dynamic> json) =>
    _OrdersResponse(
      orders: (json['orders'] as List<dynamic>)
          .map((e) => OrderDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrdersResponseToJson(_OrdersResponse instance) =>
    <String, dynamic>{'orders': instance.orders};

_CreateOrderRequest _$CreateOrderRequestFromJson(Map<String, dynamic> json) =>
    _CreateOrderRequest(
      deliveryAddressId: json['deliveryAddressId'] as String,
      paymentMethod: (json['paymentMethod'] as num).toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CreateOrderRequestToJson(_CreateOrderRequest instance) =>
    <String, dynamic>{
      'deliveryAddressId': instance.deliveryAddressId,
      'paymentMethod': instance.paymentMethod,
      'notes': instance.notes,
    };
