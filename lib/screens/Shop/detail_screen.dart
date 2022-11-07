import 'package:flutter/material.dart';
import 'package:flutter_du_13/screens/Shop/shop_screen.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, required this.product, required this.addProduct});

  final Function addProduct;

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            addProduct(product);
            Navigator.pop(context);
          },
          child: Text(product.name),
        ),
      ),
    );
  }
}
