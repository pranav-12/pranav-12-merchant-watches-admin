// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductModel _$AddProductModelFromJson(Map<String, dynamic> json) =>
    AddProductModel(
      products: json['products'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$AddProductModelToJson(AddProductModel instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String?,
      price: json['price'] as int?,
      description: json['description'] as String?,
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category: json['category'] as String?,
      deliveryFee: json['deliveryFee'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'image': instance.image,
      'category': instance.category,
      'deliveryFee': instance.deliveryFee,
    };
