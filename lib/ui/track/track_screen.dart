import 'package:flutter/material.dart';
import 'package:igo/main.dart';
import 'package:igo/ui/product_list.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where((product) => user!.favorites.contains(product.name))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('追蹤清單'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ProductList(products: filteredProducts, doRefresh: false),
    );
  }
}
