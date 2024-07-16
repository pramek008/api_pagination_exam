import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../service/api_service.dart';
import 'once_fetch.dart';
import 'pagination_fetch.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ProductResponseModel>> futureProducts;

  @override
  void initState() {
    futureProducts = ApiService().fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnceFetchScreen()));
                },
                child: const Text('Once Fetch'),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaginationFetchScreen()));
                },
                child: const Text('Pagination Fetch'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
