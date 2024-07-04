import 'package:flutter/material.dart';
import 'package:igo/main.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int totalPrice;
  late int totalAmount;

  void calculateTotal() => setState(() {
        totalPrice = 0;
        final cartProducts = products
            .where((product) =>
                user!.cart.map((item) => item.key).contains(product.name))
            .toList();
        for (final product in cartProducts) {
          final entry =
              user!.cart.firstWhere((item) => item.key == product.name);
          totalPrice += product.price * entry.value;
        }
        if (user!.cart.isNotEmpty) {
          totalAmount =
              user!.cart.map((item) => item.value).reduce((s, v) => s + v);
        } else {
          totalAmount = 0;
        }
      });

  @override
  void initState() {
    super.initState();
    calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    final cartProducts = products
        .where((product) =>
            user!.cart.map((item) => item.key).contains(product.name))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('購物車'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          final product = cartProducts[index];
          final entry =
              user!.cart.firstWhere((item) => item.key == product.name);
          final entryIndex = user!.cart.indexOf(entry);
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
                    Spacer(),
                    Row(children: [
                      const Text('數量'),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: entry.value > 1
                              ? () async {
                                  user!.cart
                                    ..removeAt(entryIndex)
                                    ..insert(entryIndex,
                                        MapEntry(entry.key, entry.value - 1));
                                  await database.update(
                                    'users',
                                    user!.toMap(),
                                    where: 'number = ?',
                                    whereArgs: [user!.number],
                                  );
                                  calculateTotal();
                                }
                              : null,
                          child: const Text('-')),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text("${entry.value}"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          user!.cart
                            ..removeAt(entryIndex)
                            ..insert(entryIndex,
                                MapEntry(entry.key, entry.value + 1));
                          await database.update(
                            'users',
                            user!.toMap(),
                            where: 'number = ?',
                            whereArgs: [user!.number],
                          );
                          calculateTotal();
                        },
                        child: const Text('+'),
                      ),
                    ]),
                  ],
                ),
              ),
            ]),
          );
        },
      ),
      bottomNavigationBar: Row(children: [
        Expanded(
          flex: 3,
          child: Text.rich(TextSpan(children: [
            TextSpan(text: '結帳金額'),
            TextSpan(
                text: '\$$totalPrice', style: TextStyle(color: Colors.red)),
          ])),
        ),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('結帳 ($totalAmount)'),
          ),
        ),
      ]),
    );
  }
}
