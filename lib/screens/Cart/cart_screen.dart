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
      body: selectedProduct.isEmpty
          ? const Center(
              child: Text("Your cart is empty", style: TextStyle(fontSize: 24)),
            )
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${selectedProduct.length} ${selectedProduct.length > 1 ? "items" : "item"}',
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedProduct.length,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    itemBuilder: (BuildContext context, int index) {
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
                                  tag: selectedProduct[index].id,
                                  child: Image.network(
                                    selectedProduct[index].picture,
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
                                    Text(selectedProduct[index].name),
                                    const Text('this is an amazing phone'),
                                    const Spacer(),
                                    const Text('ref: ZFcse0984'),
                                    Text('QTY: ${selectedProduct[index].id}'),
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
                                  child:
                                      Text('${selectedProduct[index].price} €'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, top: 10, bottom: 20),
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
