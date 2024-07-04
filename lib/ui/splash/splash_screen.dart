import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:igo/data/product.dart';
import 'package:igo/data/user.dart';
import 'package:igo/main.dart';
import 'package:igo/ui/main/main_screen.dart';
import 'package:sqflite/sqflite.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var imageName = 'Shopping2';

  @override
  void initState() {
    super.initState();
    getDatabasesPath().then((path) => openDatabase(
          '$path/igo.db',
          onCreate: (database, version) => database.execute(User.sql),
          version: 1,
        ).then((value) => database = value));
    for (final category in categories) {
      DefaultAssetBundle.of(context)
          .loadString("$dataPrefix/$category.json")
          .then((text) => products += (jsonDecode(text) as List)
              .map((item) => Product.fromMap(item, category))
              .toList());
    }
    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(() => imageName = 'Shopping1'),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('$imagesPrefix/$imageName.jpg')),
      backgroundColor: Colors.cyan,
    );
  }
}
