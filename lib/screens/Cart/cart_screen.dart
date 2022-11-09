import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../providers/produit_provider.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Product> selectedProduct =
        Provider.of<ProduitProvider>(context, listen: false)
            .selectedProduct
            .cast<Product>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                if (selectedProduct.isNotEmpty)
                  Text(
                    '${selectedProduct.length} ${selectedProduct.length > 1 ? "items" : "item"}',
                  )
                else
                  const Center(
                    child: Text("Your cart is empty"),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedProduct.length,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 8,
                  shadowColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      children: <Widget>[
                        const Spacer(
                          flex: 3,
                        ),
                        Center(
                          child: Hero(
                            tag: 'test',
                            child: Image.network(
                              selectedProduct[index].picture,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        Row(
                          children: const <Widget>[
                            Spacer(),
                            Text('test'),
                            Spacer(
                              flex: 2,
                            ),
                            Text('${10} €'),
                            Spacer()
                          ],
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10, bottom: 20),
            child: Row(
              children: <Widget>[
                const Spacer(),
                Text(
                  selectedProduct.isNotEmpty
                      ? 'Total: ${selectedProduct.map((Product e) => e.price).reduce((int value, int element) => value + element)} €'
                      : '0€',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
