import 'package:flutter/material.dart';
import 'ItemList/items_component.dart';

class Product {
  const Product({
    required this.id,
    required this.picture,
    required this.name,
    required this.price,
  });
  final String id;
  final String picture;
  final String name;
  final int price;
}

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<ShopPage> {
  final List<Product> _selectedProduct = <Product>[];

  final List<Product> _allProduct = <Product>[
    const Product(id: "1", picture: "test", name: "gun", price: 29),
    const Product(id: "2", picture: "test", name: "spoon", price: 40),
    const Product(id: "3", picture: "test", name: "computer", price: 5),
    const Product(id: "4", picture: "test", name: "bag", price: 35),
    const Product(id: "5", picture: "test", name: "phone", price: 21),
    const Product(id: "6", picture: "test", name: "phone case", price: 55),
    const Product(id: "7", picture: "test", name: "chair", price: 30),
    const Product(id: "8", picture: "test", name: "desk", price: 14),
    const Product(id: "9", picture: "test", name: "pullovers", price: 100),
    const Product(id: "10", picture: "test", name: "pant", price: 32),
  ];

  List<Product> _foundProducts = <Product>[];

  @override
  void initState() {
    _foundProducts = _allProduct;
    super.initState();
  }

  void _addArticle(Product product) {
    _selectedProduct.add(product);
    setState(() {});
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
        title: const Text('Shop'),
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
                  labelText: "Search your product...",
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
          Text(
            _selectedProduct.isNotEmpty
                ? '${_selectedProduct.map((Product e) => e.price).reduce((int value, int element) => value + element)} €'
                : '0€',
          ),
          Expanded(
            child: _foundProducts.isNotEmpty
                ? ItemList(
                    addArticle: _addArticle,
                    foundProducts: _foundProducts,
                  )
                : const Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
