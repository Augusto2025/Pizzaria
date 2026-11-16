import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_models.freezed.dart';
part 'menu_models.g.dart';

@freezed
abstract class CategoryDto with _$CategoryDto {
  const factory CategoryDto({
    required int id,
    required String name,
    required String displayName,
    required int sortOrder,
  }) = _CategoryDto;

  factory CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);
}

@freezed
abstract class CustomizationChoiceDto with _$CustomizationChoiceDto {
  const factory CustomizationChoiceDto({
    required String id,
    required String name,
    required double additionalPrice,
    required int sortOrder,
  }) = _CustomizationChoiceDto;

  factory CustomizationChoiceDto.fromJson(Map<String, dynamic> json) => _$CustomizationChoiceDtoFromJson(json);
}

@freezed
abstract class CustomizationOptionDto with _$CustomizationOptionDto {
  const factory CustomizationOptionDto({
    required String id,
    required String name,
    required bool isRequired,
    required bool allowMultiple,
    required int sortOrder,
    @Default([]) List<CustomizationChoiceDto> choices,
  }) = _CustomizationOptionDto;

  factory CustomizationOptionDto.fromJson(Map<String, dynamic> json) => _$CustomizationOptionDtoFromJson(json);
}

@freezed
abstract class ProductDto with _$ProductDto {
  const factory ProductDto({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required double price,
    required int categoryId,
    required String categoryName,
    required int prepTimeMinutes,
    required bool isAvailable,
    @Default([]) List<CustomizationOptionDto> customizationOptions,
  }) = _ProductDto;

  factory ProductDto.fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);
}

@freezed
abstract class MenuResponse with _$MenuResponse {
  const factory MenuResponse({
    @Default([]) List<CategoryDto> categories,
    @Default([]) List<ProductDto> products,
  }) = _MenuResponse;

  factory MenuResponse.fromJson(Map<String, dynamic> json) => _$MenuResponseFromJson(json);
}