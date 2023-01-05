// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_prodect_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProdectModel _$AddProdectModelFromJson(Map<String, dynamic> json) =>
    AddProdectModel(
      name: json['name'] as String?,
      price: json['price'] as int?,
      description: json['description'] as String?,
      image: json['image'] as List<dynamic>?,
      category: json['category'] as String?,
      deliveryFee: json['deliveryFee'] as String?,
    );

Map<String, dynamic> _$AddProdectModelToJson(AddProdectModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'image': instance.image,
      'category': instance.category,
      'deliveryFee': instance.deliveryFee,
    };
