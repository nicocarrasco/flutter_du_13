import 'package:flutter/material.dart';

import 'package:flutter_du_13/providers/product.dart';
import '../Card/card_component.dart';
import '../detail_screen.dart';

class ItemList extends StatefulWidget {
  const ItemList({
    Key? key,
    required this.foundProducts,
    required this.isSeller,
  }) : super(key: key);
  final List<Product> foundProducts;
  final bool isSeller;
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: (MediaQuery.of(context).size.width ~/ 250).toInt(),
      ),
      itemCount: widget.foundProducts.length,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (BuildContext context) => Detail(
                  product: widget.foundProducts[index],
                  isSeller: widget.isSeller,
                ),
              ),
            );
          },
          child: ElevatedCard(product: widget.foundProducts[index]),
        );
      },
    );
  }
}
