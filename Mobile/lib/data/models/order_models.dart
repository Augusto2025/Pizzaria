import 'package:freezed_annotation/freezed_annotation.dart';
import 'address_models.dart';

part 'order_models.freezed.dart';
part 'order_models.g.dart';

@freezed
abstract class OrderStatusDto with _$OrderStatusDto {
  const factory OrderStatusDto({
    required int value,
    required String label,
    required String color,
  }) = _OrderStatusDto;

  factory OrderStatusDto.fromJson(Map<String, dynamic> json) => _$OrderStatusDtoFromJson(json);
}

@freezed
abstract class StatusTimelineDto with _$StatusTimelineDto {
  const factory StatusTimelineDto({
    required int id,
    required OrderStatusDto status,
    required DateTime timestamp,
    required String note,
  }) = _StatusTimelineDto;

  factory StatusTimelineDto.fromJson(Map<String, dynamic> json) => _$StatusTimelineDtoFromJson(json);
}

@freezed
abstract class OrderItemDto with _$OrderItemDto {
  const factory OrderItemDto({
    required String id,
    required String productId,
    required String productName,
    required String productImageUrl,
    required int quantity,
    required double unitPrice,
    required Map<String, String> customizations,
    String? notes,
    required double totalPrice,
  }) = _OrderItemDto;

  factory OrderItemDto.fromJson(Map<String, dynamic> json) => _$OrderItemDtoFromJson(json);
}

@freezed
abstract class OrderDto with _$OrderDto {
  const factory OrderDto({
    required String id,
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
    required List<StatusTimelineDto> timeline,
  }) = _OrderDto;

  factory OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);
}

@freezed
abstract class OrdersResponse with _$OrdersResponse {
  const factory OrdersResponse({
    required List<OrderDto> orders,
  }) = _OrdersResponse;

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => _$OrdersResponseFromJson(json);
}

@freezed
abstract class CreateOrderRequest with _$CreateOrderRequest {
  const factory CreateOrderRequest({
    required String deliveryAddressId,
    required int paymentMethod,
    String? notes,
  }) = _CreateOrderRequest;

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) => _$CreateOrderRequestFromJson(json);
}