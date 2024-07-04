import 'package:flutter/material.dart';
import 'package:igo/data/product.dart';
import 'package:igo/main.dart';
import 'package:igo/ui/login/login_screen.dart';
import 'package:igo/ui/product_bottom_sheet.dart';
import 'package:igo/ui/show_snack_bar.dart';

class ProductActions extends StatefulWidget {
  const ProductActions({
    super.key,
    required this.product,
    required this.onFavoriteToggled,
  });

  final Product product;
  final VoidCallback onFavoriteToggled;

  @override
  State<ProductActions> createState() => _ProductActionsState();
}

class _ProductActionsState extends State<ProductActions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: user == null
              ? () async {
                  showSnackBar(context, '加入追蹤清單需要登入。');
                  await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          ) ==
                          true
                      ? widget.onFavoriteToggled()
                      : null;
                }
              : () async {
                  if (user!.favorites.contains(widget.product.name)) {
                    user!.favorites.remove(widget.product.name);
                  } else {
                    user!.favorites.add(widget.product.name);
                  }
                  await database.update(
                    'users',
                    user!.toMap(),
                    where: 'number = ?',
                    whereArgs: [user!.number],
                  );
                  setState(() {});
                  widget.onFavoriteToggled();
                },
          icon: Image.asset(
            '$imagesPrefix/heart${user != null && user!.favorites.contains(widget.product.name) ? ' (1)' : ''}.png',
          ),
        ),
        IconButton(
          onPressed: user == null
              ? () async {
                  showSnackBar(context, '加入購物車需要登入。');
                  await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          ) ==
                          true
                      ? widget.onFavoriteToggled()
                      : null;
                }
              : () => Scaffold.of(context).showBottomSheet(
                    (context) => ProductBottomSheet(product: widget.product),
                  ),
          icon: const ImageIcon(AssetImage('$imagesPrefix/shopping-cart.png')),
        ),
      ],
    );
  }
}
