import 'package:json_annotation/json_annotation.dart';

part 'add_product_model.g.dart';

@JsonSerializable()
class AddProductModel {
  List<dynamic> products;

  AddProductModel({this.products = const []});

  factory AddProductModel.fromJson(Map<String, dynamic> json) {
    return AddProductModel(products: json["products"]);
  }

  Map<String, dynamic> toJson() => {
        "products": products,
      };
}

@JsonSerializable()
class Product {
  String? name;

  int? price;

  String? description;

  List<String>? image;

  String? category;

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
    return Product(
      name: json["name"],
      price: json["price"],
      description: json["description"],
      image: json["image"],
      category: json["category"],
      deliveryFee: json["deliveryFee"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "description": description,
        "image": image,
        "category": category,
        "deliveryFee": deliveryFee,
      };
}
