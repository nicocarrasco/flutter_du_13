import 'package:flutter/material.dart';

import '../shop_screen.dart';

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: const Color.fromRGBO(184, 216, 223, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 180,
        height: 180,
        child: Column(
          children: <Widget>[
            const Spacer(
              flex: 3,
            ),
            Center(child: Text(product.picture)),
            const Spacer(
              flex: 3,
            ),
            Row(
              children: <Widget>[
                const Spacer(),
                Text(product.name),
                const Spacer(),
                Text('${product.price} €'),
                const Spacer()
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
