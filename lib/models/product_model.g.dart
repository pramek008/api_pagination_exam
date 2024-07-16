// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseModel _$ProductResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProductResponseModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      stock: (json['stock'] as num).toInt(),
    );

Map<String, dynamic> _$ProductResponseModelToJson(
        ProductResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'category': instance.category,
      'stock': instance.stock,
    };
