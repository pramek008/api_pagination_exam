import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../service/api_service.dart';

class PaginationFetchScreen extends StatefulWidget {
  const PaginationFetchScreen({super.key});

  @override
  State<PaginationFetchScreen> createState() => _PaginationFetchScreenState();
}

class _PaginationFetchScreenState extends State<PaginationFetchScreen> {
  // List to store the fetched products
  List<ProductResponseModel> products = [];
  // ScrollController to listen for scroll events
  final ScrollController _scrollController = ScrollController();

  // Flag to check if we're already loading data
  bool isLoading = false;

  // Counter to keep track of the number of products fetched
  // starting from 0 because we're fetching the first set of products
  // which is 0 to 9, and will increase by 10 each time we fetch more products
  // because the limit is set to 10 in the API_SERVICE
  int skippedData = 0;

  Future<void> _fetchProducts() async {
    // Set loading state to true
    setState(() {
      isLoading = true;
    });
    // Fetch new products from the API
    final newProducts =
        await ApiService().fetchPaginationProducts(skipData: skippedData);
    // Check if the new products list is empty
    if (newProducts.isEmpty) {
      setState(() {
        // Set loading state to false and stop fetching data
        // because there are no more products to fetch
        isLoading = false;
      });
      return;
      // If the new products list is not empty
    } else {
      // Update the state with new data
      setState(() {
        // Add new products to the existing list
        products.addAll(newProducts);
        // Increase the skip count by the number of new products
        // the increment of skippedData 10 20 30 40 50 and so on
        // because the limit is set to 10 in the API_SERVICE
        skippedData = skippedData + newProducts.length;
        // Set loading state to false
        isLoading = false;
      });
    }
  }

  // Another way to fetch products with similar functionality as above
  // Future<void> _fetchProducts() async {
  //   // Check if we're not already loading data
  //   if (!isLoading) {
  //     // Set loading state to true
  //     setState(() => isLoading = true);
  //     try {
  //       // Fetch new products from the API
  //       final newProducts =
  //           await ApiService().fetchPaginationProducts(skipData: skippedData);
  //       // Update the state with new data
  //       setState(() {
  //         // Add new products to the existing list
  //         products.addAll(newProducts);
  //         // Increase the skip count by the number of new products
  //         skippedData += newProducts.length;
  //         // Set loading state to false
  //         isLoading = false;
  //       });
  //     } catch (e) {
  //       // Log any errors that occur during fetching
  //       print('Error fetching products: $e');
  //       // Set loading state to false in case of error
  //       setState(() => isLoading = false);
  //     }
  //   }
  // }

  // Function to listen for scroll events
  void _onMaxScroll() {
    // Check if the user has scrolled to the bottom of the list
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Fetch more products when the user reaches the bottom
      _fetchProducts();
    }
  }

  @override
  void initState() {
    super.initState();
    // Add a listener to the scroll controller
    _scrollController.addListener(_onMaxScroll);
    // Fetch the initial set of products
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination Fetch'),
      ),
      body: SafeArea(
        // Display a loading indicator while fetching first set of products
        child: products.isEmpty && isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _scrollController,
                itemCount: products.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  // If we've reached the end of the list and still loading, show a loading indicator
                  if (index == products.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // If we're at the last item, not loading, and have products, show "No more products" message
                  else if (products.isNotEmpty &&
                      !isLoading &&
                      index == products.length - 1) {
                    return const Center(
                        child: Text('No more products to load'));
                  }
                  // Display the product details in a ListTile
                  return ListTile(
                    isThreeLine: true,
                    style: ListTileStyle.list,
                    title: Text(products[index].title),
                    subtitle: Text(
                      products[index].description.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    trailing: Text(
                      products[index].price.toString(),
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
