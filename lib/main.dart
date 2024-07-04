import 'package:flutter/material.dart';
import 'package:igo/data/product.dart';
import 'package:igo/data/user.dart';
import 'package:igo/ui/splash/splash_screen.dart';
import 'package:sqflite/sqflite.dart';

const dataPrefix = 'assets/data';
const imagesPrefix = 'assets/images';
const categories = ['電腦', '智慧手機', '汽車百貨'];
late Database database;
var products = <Product>[];
User? user;

void main() {
  runApp(const IgoApp());
}

class IgoApp extends StatelessWidget {
  const IgoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SplashScreen());
  }
}
