import 'package:flutter/material.dart';

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
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2,
                    ),
                    itemCount: _foundProducts.length,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<Widget>(
                              builder: (BuildContext context) => Detail(
                                product: _foundProducts[index],
                                addProduct: _addArticle,
                              ),
                            ),
                          );
                        },
                        child: ElevatedCard(product: _foundProducts[index]),
                      );
                    },
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

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: const Color.fromRGBO(184, 216, 223, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 180,
        height: 180,
        child: Column(
          children: <Widget>[
            const Spacer(
              flex: 3,
            ),
            Center(child: Text(product.picture)),
            const Spacer(
              flex: 3,
            ),
            Row(
              children: <Widget>[
                const Spacer(),
                Text(product.name),
                const Spacer(),
                Text('${product.price} €'),
                const Spacer()
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  const Detail({super.key, required this.product, required this.addProduct});

  final Function addProduct;

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            addProduct(product);
            Navigator.pop(context);
          },
          child: Text(product.name),
        ),
      ),
    );
  }
}
