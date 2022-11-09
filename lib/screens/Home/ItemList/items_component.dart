import 'package:flutter/material.dart';

import '../../../providers/produit_provider.dart';
import '../Card/card_component.dart';
import '../detail_screen.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.foundProducts,
  });

  final List<Product> foundProducts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
      ),
      itemCount: foundProducts.length,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (BuildContext context) => Detail(
                  product: foundProducts[index],
                ),
              ),
            );
          },
          child: ElevatedCard(product: foundProducts[index]),
        );
      },
    );
  }
}
