// category_screen.dart
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final int index;
  final String categoryName;

  const CategoryScreen({Key? key, required this.index, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$index: $categoryName'),
      ),
      body: Center(
        child: Text('Category $index: $categoryName'),
      ),
    );
  }
}