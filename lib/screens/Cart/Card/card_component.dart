import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';

import '../../../providers/produit_provider.dart';

class CardCart extends StatelessWidget {
  const CardCart({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
            top: 10,
          ),
          child: Row(
            children: <Widget>[
              Hero(
                tag: product.id,
                child: Image.network(
                  product.picture,
                  width: 100,
                  height: 100,
                ),
              ),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 0,
                color: Colors.black,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
                  Text(
                    product.name,
                  ),
                  const Text('this is an amazing phone'),
                  const Spacer(),
                  const Text('ref: ZFcse0984'),
                  Text(
                    'QTY: ${product.id}',
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
                child: Text(
                  '${product.price} €',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
