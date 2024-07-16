import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductResponseModel {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "price")
  double price;
  @JsonKey(name: "category")
  String category;
  @JsonKey(name: "stock")
  int stock;

  ProductResponseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseModelToJson(this);
}
