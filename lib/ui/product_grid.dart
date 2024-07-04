import 'package:flutter/material.dart';
import 'package:igo/data/product.dart';
import 'package:igo/ui/product_actions.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key, required this.products});

  final List<Product> products;

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        final product = widget.products[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              height: 200,
            ),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "\$${product.price}",
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            ProductActions(
              product: product,
              onFavoriteToggled: () => setState(() {}),
            ),
          ],
        );
      },
    );
  }
}
