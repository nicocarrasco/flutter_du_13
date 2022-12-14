import 'package:flutter/cupertino.dart';
import 'package:flutter_du_13/providers/product.dart';

// class Product {
//   const Product({
//     required this.id,
//     required this.picture,
//     required this.name,
//     required this.price,
//   });
//   final String id;
//   final String picture;
//   final String name;
//   final int price;
// }

class ProduitProvider extends ChangeNotifier {
  List<Product> selectedProduct = <Product>[];

  void addProduct(Product product) {
    selectedProduct.add(product);
    notifyListeners();
  }

  void removeProduct(int index) {
    selectedProduct.removeAt(index);
    notifyListeners();
  }

  void removeAllProducts() {
    selectedProduct = <Product>[];
    notifyListeners();
  }
}
