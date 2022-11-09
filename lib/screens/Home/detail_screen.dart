import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/produit_provider.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Hero(
                  tag: product.name,
                  child: Card(
                    elevation: 10,
                    child: SizedBox(
                      height: 250,
                      child: Center(
                        child: Image.network(product.picture),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(product.name),
                ),
                Row(
                  children: const <Widget>[
                    Text("Description:"),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                const Spacer(),
                Card(
                  elevation: 4,
                  child: SizedBox(
                    width: 70,
                    height: 40,
                    child: Center(
                      child: Text('${product.price} €'),
                    ),
                  ),
                ),
                Consumer<ProduitProvider>(
                  builder: (
                    BuildContext context,
                    ProduitProvider productProv,
                    Widget? child,
                  ) =>
                      ElevatedButton(
                    onPressed: () {
                      productProv.addProduct(product);
                      Navigator.pop(context);
                    },
                    child: const Text('Buy'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
