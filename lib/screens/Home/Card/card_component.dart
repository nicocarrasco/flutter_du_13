import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../home_screen.dart';

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
            Center(
              child: Hero(
                tag: product.name,
                child: Image.network(
                  product.picture,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            Row(
              children: <Widget>[
                const Spacer(),
                Text(product.name),
                const Spacer(
                  flex: 2,
                ),
                Text('${product.price} €'),
                const Spacer()
              ],
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
