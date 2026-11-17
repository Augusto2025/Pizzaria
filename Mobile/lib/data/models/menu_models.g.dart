// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) => _CategoryDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  displayName: json['displayName'] as String,
  sortOrder: (json['sortOrder'] as num).toInt(),
);

Map<String, dynamic> _$CategoryDtoToJson(_CategoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
      'sortOrder': instance.sortOrder,
    };

_CustomizationChoiceDto _$CustomizationChoiceDtoFromJson(
  Map<String, dynamic> json,
) => _CustomizationChoiceDto(
  id: json['id'] as String,
  name: json['name'] as String,
  additionalPrice: (json['additionalPrice'] as num).toDouble(),
  sortOrder: (json['sortOrder'] as num).toInt(),
);

Map<String, dynamic> _$CustomizationChoiceDtoToJson(
  _CustomizationChoiceDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'additionalPrice': instance.additionalPrice,
  'sortOrder': instance.sortOrder,
};

_CustomizationOptionDto _$CustomizationOptionDtoFromJson(
  Map<String, dynamic> json,
) => _CustomizationOptionDto(
  id: json['id'] as String,
  name: json['name'] as String,
  isRequired: json['isRequired'] as bool,
  allowMultiple: json['allowMultiple'] as bool,
  sortOrder: (json['sortOrder'] as num).toInt(),
  choices:
      (json['choices'] as List<dynamic>?)
          ?.map(
            (e) => CustomizationChoiceDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$CustomizationOptionDtoToJson(
  _CustomizationOptionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'isRequired': instance.isRequired,
  'allowMultiple': instance.allowMultiple,
  'sortOrder': instance.sortOrder,
  'choices': instance.choices,
};

_ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => _ProductDto(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  imageUrl: json['imageUrl'] as String,
  price: (json['price'] as num).toDouble(),
  categoryId: (json['categoryId'] as num).toInt(),
  categoryName: json['categoryName'] as String,
  categoryDisplayName: json['categoryDisplayName'] as String,
  prepTimeMinutes: (json['prepTimeMinutes'] as num).toInt(),
  isAvailable: json['isAvailable'] as bool,
  customizationOptions:
      (json['customizationOptions'] as List<dynamic>?)
          ?.map(
            (e) => CustomizationOptionDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$ProductDtoToJson(_ProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'categoryDisplayName': instance.categoryDisplayName,
      'prepTimeMinutes': instance.prepTimeMinutes,
      'isAvailable': instance.isAvailable,
      'customizationOptions': instance.customizationOptions,
    };

_MenuResponse _$MenuResponseFromJson(Map<String, dynamic> json) =>
    _MenuResponse(
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MenuResponseToJson(_MenuResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'products': instance.products,
    };
