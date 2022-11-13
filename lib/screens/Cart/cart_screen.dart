import 'package:flutter/material.dart';
import 'package:flutter_du_13/firebase/product.dart';
import 'package:provider/provider.dart';

import '../../providers/produit_provider.dart';
import 'Card/card_component.dart';

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
    bool isMobile(BuildContext context) =>
        MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
      ),
      body: selectedProduct.isEmpty
          ? const Center(
              child:
                  Text("Votre panier est vide", style: TextStyle(fontSize: 24)),
            )
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${selectedProduct.length} ${selectedProduct.length > 1 ? "produits" : "produit"}',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedProduct.length,
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Consumer<ProduitProvider>(
                        builder: (
                          BuildContext context,
                          ProduitProvider productProv,
                          Widget? child,
                        ) =>
                            isMobile(context)
                                ? Dismissible(
                                    direction: DismissDirection.endToStart,
                                    key: UniqueKey(),
                                    onDismissed: (DismissDirection direction) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${productProv.selectedProduct[index].name} supprimé du panier',
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        productProv.removeProduct(index);
                                      });
                                    },
                                    // Show a red background as the item is swiped away.
                                    background: Container(
                                      alignment: AlignmentDirectional.centerEnd,
                                      color: Colors.red,
                                      child: const Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          0.0,
                                          0.0,
                                          10.0,
                                          0.0,
                                        ),
                                        child: Icon(
                                          size: 55,
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    child: CardCart(
                                      product:
                                          productProv.selectedProduct[index],
                                    ),
                                  )
                                : Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: CardCart(
                                          product: productProv
                                              .selectedProduct[index],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${productProv.selectedProduct[index].name} supprimé du panier',
                                              ),
                                            ),
                                          );
                                          setState(() {
                                            productProv.removeProduct(index);
                                          });
                                        },
                                        child: const Icon(
                                          size: 25,
                                          Icons.close,
                                          color: Color.fromARGB(
                                            255,
                                            229,
                                            115,
                                            115,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        selectedProduct.isNotEmpty
                            ? 'Total: ${selectedProduct.map((Product e) => e.price).reduce((int value, int element) => value + element)} €'
                            : '0€',
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Commander'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
