import 'package:flutter/material.dart';
import 'package:flutter_du_13/providers/product.dart';
import 'package:flutter_du_13/providers/produit_provider.dart';
import 'package:provider/provider.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, required this.product, required this.isSeller});

  final Product product;
  final bool isSeller;

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
                        child: product.image != null
                            ? Image.network(
                                product.image!,
                                width: 100,
                                height: 100,
                                loadingBuilder: (
                                  BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress,
                                ) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              )
                            : const Image(
                                image: AssetImage('images/image-not-found.jpg'),
                              ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(product.name),
                ),
                Row(
                  children: <Widget>[
                    const Text("Description: "),
                    Text(product.description),
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
                if (!isSeller)
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
                      child: const Text('Ajouter au panier'),
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
