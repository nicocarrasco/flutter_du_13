import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../providers/produit_provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartPage();
}

class _CartPage extends State<Cart> {
  @override
  void initState() {
    super.initState();
  }

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
                  child: Consumer<ProduitProvider>(
                    builder: (
                      BuildContext context,
                      ProduitProvider productProv,
                      Widget? child,
                    ) =>
                        ListView.builder(
                      itemCount: selectedProduct.length,
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: Key(selectedProduct[index].id),
                          onDismissed: (DismissDirection direction) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${productProv.selectedProduct[index].name} dismissed',
                                ),
                              ),
                            );
                            setState(() {
                              productProv.removeProduct(index);
                            });
                          },
                          // Show a red background as the item is swiped away.
                          background: Container(color: Colors.red),
                          child: Card(
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
                                        productProv
                                            .selectedProduct[index].picture,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Spacer(),
                                        Text(
                                          productProv
                                              .selectedProduct[index].name,
                                        ),
                                        const Text('this is an amazing phone'),
                                        const Spacer(),
                                        const Text('ref: ZFcse0984'),
                                        Text(
                                          'QTY: ${productProv.selectedProduct[index].id}',
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
                                        '${productProv.selectedProduct[index].price} €',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
