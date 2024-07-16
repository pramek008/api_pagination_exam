import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../service/api_service.dart';

class OnceFetchScreen extends StatefulWidget {
  const OnceFetchScreen({super.key});

  @override
  State<OnceFetchScreen> createState() => _OnceFetchScreenState();
}

class _OnceFetchScreenState extends State<OnceFetchScreen> {
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
        child: FutureBuilder(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final posts = snapshot.data as List<ProductResponseModel>;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
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
              );
            }
          },
        ),
      ),
    );
  }
}
