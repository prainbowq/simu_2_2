import 'package:flutter/material.dart';
import 'package:igo/main.dart';
import 'package:igo/ui/cart/cart_screen.dart';
import 'package:igo/ui/login/login_screen.dart';
import 'package:igo/ui/main/home/home_app_bar.dart';
import 'package:igo/ui/main/home/home_page.dart';
import 'package:igo/ui/main/user/user_app_bar.dart';
import 'package:igo/ui/main/user/user_page.dart';
import 'package:igo/ui/show_snack_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var index = 0;
  var category = categories.first;
  var descending = true;
  var grid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: [
        homeAppBar(
          category: category,
          onCategoryChanged: (value) => setState(() => category = value),
          descending: descending,
          onDescendingChanged: (value) => setState(() => descending = value),
          grid: grid,
          onGridChanged: (value) => setState(() => grid = value),
        ),
        AppBar(),
        AppBar(),
        userAppBar(),
      ][index],
      body: [
        HomePage(category: category, descending: descending, grid: grid),
        const Placeholder(),
        const Placeholder(),
        const UserPage(),
      ][index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) async {
          if (value == 2) {
            if (user == null) {
              showSnackBar(context, '查看購物車需要登入。');
              await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ) ==
                      true
                  ? setState(() {})
                  : null;
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            }
          } else {
            setState(() => index = value);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('$imagesPrefix/home.png')),
            label: '首頁',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('$imagesPrefix/folder.png')),
            label: '分類',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('$imagesPrefix/shopping-cart.png')),
            label: '購物車',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('$imagesPrefix/user.png')),
            label: '顧客中心',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
