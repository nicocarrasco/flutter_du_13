import 'package:flutter/material.dart';
import 'package:flutter_du_13/providers/product.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'ItemList/items_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _SearchPageState();
}

class _SearchPageState extends State<HomePage> {
  List<Product> _foundProducts = <Product>[];

  List<Product> _allProduct = <Product>[];
  late final bool isSeller;

  @override
  void initState() {
    isSeller = Provider.of<UserProvider>(context, listen: false).getRole() ==
        "Vendeur";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData(isSeller);
    });

    _foundProducts = _allProduct;
    super.initState();
  }

  Future<void> getData(bool isSeller) async {
    _allProduct = await ProductProvider().getProducts(isSeller);
    setState(() {
      _foundProducts = _allProduct;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Product> results = <Product>[];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allProduct;
    } else {
      results = _allProduct
          .where(
            (Product product) => product.name
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()),
          )
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSeller
            ? const Text('Mes produits en vente')
            : const Text('Produits en vente'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Cherchez vos produits...",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                onTap: () {},
                onChanged: (String value) => _runFilter(value),
                cursorColor: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: _foundProducts.isNotEmpty
                ? ItemList(
                    foundProducts: _foundProducts,
                    isSeller: isSeller,
                  )
                : Center(
                    child: isSeller
                        ? const Text(
                            'Vous n\'avez aucun produit en vente',
                            style: TextStyle(fontSize: 24),
                          )
                        : const Text(
                            'Aucun produit à acheter',
                            style: TextStyle(fontSize: 24),
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
