// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryDtoImpl _$$CategoryDtoImplFromJson(Map<String, dynamic> json) =>
    _$CategoryDtoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      sortOrder: (json['sortOrder'] as num).toInt(),
    );

Map<String, dynamic> _$$CategoryDtoImplToJson(_$CategoryDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
      'sortOrder': instance.sortOrder,
    };

_$CustomizationChoiceDtoImpl _$$CustomizationChoiceDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomizationChoiceDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      additionalPrice: (json['additionalPrice'] as num).toDouble(),
      sortOrder: (json['sortOrder'] as num).toInt(),
    );

Map<String, dynamic> _$$CustomizationChoiceDtoImplToJson(
        _$CustomizationChoiceDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'additionalPrice': instance.additionalPrice,
      'sortOrder': instance.sortOrder,
    };

_$CustomizationOptionDtoImpl _$$CustomizationOptionDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomizationOptionDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      isRequired: json['isRequired'] as bool,
      allowMultiple: json['allowMultiple'] as bool,
      sortOrder: (json['sortOrder'] as num).toInt(),
      choices: (json['choices'] as List<dynamic>?)
              ?.map((e) =>
                  CustomizationChoiceDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CustomizationOptionDtoImplToJson(
        _$CustomizationOptionDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isRequired': instance.isRequired,
      'allowMultiple': instance.allowMultiple,
      'sortOrder': instance.sortOrder,
      'choices': instance.choices,
    };

_$ProductDtoImpl _$$ProductDtoImplFromJson(Map<String, dynamic> json) =>
    _$ProductDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      categoryId: (json['categoryId'] as num).toInt(),
      categoryName: json['categoryName'] as String,
      prepTimeMinutes: (json['prepTimeMinutes'] as num).toInt(),
      isAvailable: json['isAvailable'] as bool,
      customizationOptions: (json['customizationOptions'] as List<dynamic>?)
              ?.map((e) =>
                  CustomizationOptionDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProductDtoImplToJson(_$ProductDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'prepTimeMinutes': instance.prepTimeMinutes,
      'isAvailable': instance.isAvailable,
      'customizationOptions': instance.customizationOptions,
    };

_$MenuResponseImpl _$$MenuResponseImplFromJson(Map<String, dynamic> json) =>
    _$MenuResponseImpl(
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MenuResponseImplToJson(_$MenuResponseImpl instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'products': instance.products,
    };
