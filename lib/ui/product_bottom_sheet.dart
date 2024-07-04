import 'package:flutter/material.dart';
import 'package:igo/data/product.dart';
import 'package:igo/main.dart';
import 'package:igo/ui/show_snack_bar.dart';

class ProductBottomSheet extends StatefulWidget {
  const ProductBottomSheet({super.key, required this.product});

  final Product product;

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  var amount = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.product.imageUrl, width: 140),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product.name),
                    const Spacer(),
                    Text(
                      "\$${widget.product.price}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        const Divider(),
        Row(children: [
          const Text('數量'),
          const Spacer(),
          ElevatedButton(
              onPressed: amount > 1 ? () => setState(() => amount--) : null,
              child: const Text('-')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text("$amount"),
          ),
          ElevatedButton(
            onPressed: () => setState(() => amount++),
            child: const Text('+'),
          ),
        ]),
        const Divider(),
        const Spacer(),
        const Divider(),
        Row(children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                user!.cart.add(MapEntry(widget.product.name, amount));
                await database.update(
                  'users',
                  user!.toMap(),
                  where: 'number = ?',
                  whereArgs: [user!.number],
                );
                if (!mounted) return;
                showSnackBar(context, '已加入購物車。');
                Navigator.of(context).pop();
              },
              child: const Text('加入購物車'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('直接購買'),
            ),
          ),
        ]),
      ],
    );
  }
}
