import 'package:flutter/material.dart';
import 'package:flutter_du_13/firebase/product.dart';
import 'ItemList/items_component.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _SearchPageState();
}

class _SearchPageState extends State<HomePage> {
  List<Product> _foundProducts = <Product>[];

  final List<Product> _allProduct = <Product>[
    const Product(
      // id: "1",
      picture:
          "test",
      name: "gun",
      price: 29,
    ),
    const Product(picture: "test", name: "spoon", price: 40),
    const Product(picture: "test", name: "computer", price: 5),
    const Product(picture: "test", name: "bag", price: 35),
    const Product(picture: "test", name: "phone", price: 21),
    const Product(picture: "test", name: "phone case", price: 55),
    const Product(picture: "test", name: "chair", price: 30),
    const Product(picture: "test", name: "desk", price: 14),
    const Product(picture: "test", name: "pullovers", price: 100),
    const Product(picture: "test", name: "pant", price: 32),
  ];

  @override
  void initState() {
    _foundProducts = _allProduct;
    super.initState();
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
        title: const Text('Home'),
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
          Expanded(
            child: _foundProducts.isNotEmpty
                ? ItemList(
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
