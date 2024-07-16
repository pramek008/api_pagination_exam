import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pagination_exam/models/product_model.dart';

class ApiService {
  List<String> productProperties = [
    'title',
    'description',
    'price',
    'category',
    'stock',
  ];

  Future<List<ProductResponseModel>> fetchProducts() async {
    final response = await Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
        method: 'GET',
        queryParameters: {
          'select': productProperties.join(','),
        },
      ),
    ).get('/products');

    debugPrint('Response: ${response.data}');

    if (response.statusCode == 200) {
      List<ProductResponseModel> products = [];
      for (var product in response.data["products"]) {
        products.add(ProductResponseModel.fromJson(product));
      }
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductResponseModel>> fetchPaginationProducts({
    required int skipData,
  }) async {
    final response = await Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
        method: 'GET',
        queryParameters: {
          'limit': 10,
          'skip': skipData,
          'select': productProperties.join(','),
        },
      ),
    ).get('/products');

    debugPrint('Response: ${response.data}');

    if (response.statusCode == 200) {
      List<ProductResponseModel> products = [];
      for (var product in response.data["products"]) {
        products.add(ProductResponseModel.fromJson(product));
      }
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
