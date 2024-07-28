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
    // Skip data to fetch the next set of products
    required int skipData,
  }) async {
    final response = await Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
        method: 'GET',
        queryParameters: {
          // Limit the number of products to fetch in a single request
          'limit': 10,
          // Skip the number of products to fetch the next set of products
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
