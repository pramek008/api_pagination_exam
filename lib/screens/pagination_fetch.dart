import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../service/api_service.dart';

class PaginationFetchScreen extends StatefulWidget {
  const PaginationFetchScreen({super.key});

  @override
  State<PaginationFetchScreen> createState() => _PaginationFetchScreenState();
}

class _PaginationFetchScreenState extends State<PaginationFetchScreen> {
  List<ProductResponseModel> products = [];
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  int skippedData = 0;

  Future<void> _fetchProducts() async {
    // Check if we're not already loading data
    if (!isLoading) {
      // Set loading state to true
      setState(() => isLoading = true);

      try {
        // Fetch new products from the API
        final newProducts =
            await ApiService().fetchPaginationProducts(skipData: skippedData);

        // Update the state with new data
        setState(() {
          // Add new products to the existing list
          products.addAll(newProducts);
          // Increase the skip count by the number of new products
          skippedData += newProducts.length;
          // Set loading state to false
          isLoading = false;
        });
      } catch (e) {
        // Log any errors that occur during fetching
        print('Error fetching products: $e');
        // Set loading state to false in case of error
        setState(() => isLoading = false);
      }
    }
  }

  void _onMaxScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchProducts();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onMaxScroll);
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination Fetch'),
      ),
      body: SafeArea(
        child: products.isEmpty && isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _scrollController,
                itemCount: products.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == products.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final post = products[index];
                  return ListTile(
                    isThreeLine: true,
                    style: ListTileStyle.list,
                    title: Text(post.title),
                    subtitle: Text(
                      post.description.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    trailing: Text(
                      post.price.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
