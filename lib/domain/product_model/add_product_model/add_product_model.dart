import 'package:json_annotation/json_annotation.dart';

part 'add_product_model.g.dart';

@JsonSerializable()
class AddProductModel {
  @JsonKey(name: 'products')
  List<Product>? products;

  AddProductModel({this.products = const []});

  factory AddProductModel.fromJson(Map<String, dynamic> json) {
    return _$AddProductModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddProductModelToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'image')
  List<String>? image;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'deliveryFee')
  String? deliveryFee;


 Product.create({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.deliveryFee,
  });

  Product({
    this.name,
    this.price,
    this.description,
    this.image,
    this.category,
    this.deliveryFee,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
