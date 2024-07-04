import 'package:flutter/material.dart';
import 'package:igo/data/product.dart';
import 'package:igo/ui/product_actions.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.products, this.doRefresh = true});

  final List<Product> products;
  final bool doRefresh;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final product = widget.products[index];
        return SizedBox(
          height: 140,
          child: Row(children: [
            Image.network(product.imageUrl, width: 140),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name),
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
                    onFavoriteToggled:
                        widget.doRefresh ? () => setState(() {}) : () {},
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
