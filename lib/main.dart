// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/wine_shop_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wine Shop',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: WineShopScreen(),
    );
  }
}
