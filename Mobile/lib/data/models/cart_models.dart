import 'package:freezed_annotation/freezed_annotation.dart';
import 'menu_models.dart';

part 'cart_models.freezed.dart';
part 'cart_models.g.dart';

@freezed
abstract class CartItemDto with _$CartItemDto {
  const factory CartItemDto({
    required String id,
    required String userId,
    required String productId,
    required int quantity,
    required String selectedCustomizationsJson,
    String? notes,
    required DateTime createdAt,
    required ProductDto product,
  }) = _CartItemDto;

  factory CartItemDto.fromJson(Map<String, dynamic> json) => _$CartItemDtoFromJson(json);
}

@freezed
abstract class CartResponse with _$CartResponse {
  const factory CartResponse({
    @Default([]) List<CartItemDto> items,
    required double subtotal,
  }) = _CartResponse;

  factory CartResponse.fromJson(Map<String, dynamic> json) => _$CartResponseFromJson(json);
}

@freezed
abstract class AddCartItemRequest with _$AddCartItemRequest {
  const factory AddCartItemRequest({
    required String productId,
    required int quantity,
    Map<String, String>? selectedCustomizations,
    String? notes,
  }) = _AddCartItemRequest;

  factory AddCartItemRequest.fromJson(Map<String, dynamic> json) => _$AddCartItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddCartItemRequestToJson(this);
}

@freezed
abstract class UpdateCartItemRequest with _$UpdateCartItemRequest {
  const factory UpdateCartItemRequest({
    required int quantity,
    Map<String, String>? selectedCustomizations,
    String? notes,
  }) = _UpdateCartItemRequest;

  factory UpdateCartItemRequest.fromJson(Map<String, dynamic> json) => _$UpdateCartItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCartItemRequestToJson(this);
}