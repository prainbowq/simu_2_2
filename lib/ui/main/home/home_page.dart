import 'package:flutter/material.dart';
import 'package:igo/main.dart';
import 'package:igo/ui/product_grid.dart';
import 'package:igo/ui/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.category,
    required this.descending,
    required this.grid,
  });

  final String category;
  final bool descending;
  final bool grid;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final processedProducts = products
        .where(
          (item) => item.category == widget.category,
        )
        .toList()
      ..sort(
          (a, b) => (widget.descending ? -1 : 1) * a.price.compareTo(b.price));
    return widget.grid
        ? ProductGrid(products: processedProducts)
        : ProductList(products: processedProducts);
  }
}
