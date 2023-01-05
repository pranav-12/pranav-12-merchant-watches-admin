import 'package:json_annotation/json_annotation.dart';

part 'add_prodect_model.g.dart';

@JsonSerializable()
class AddProdectModel {
  // @JsonKey(name: '_id')
  // String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'image')
  List<dynamic>? image;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'deliveryFee')
  String? deliveryFee;

  AddProdectModel.create({
    // required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.deliveryFee,
  });

  AddProdectModel({
    // this.id,
    this.name,
    this.price,
    this.description,
    this.image,
    this.category,
    this.deliveryFee,
  });

  factory AddProdectModel.fromJson(Map<String, dynamic> json) {
    return _$AddProdectModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddProdectModelToJson(this);
}
