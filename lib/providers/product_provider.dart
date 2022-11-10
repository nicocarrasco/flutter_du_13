import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class Product {
  const Product({
    required this.picture,
    required this.name,
    required this.price,
  });

  Product.fromMap(Map<String, dynamic> snapshot) :
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        picture = snapshot['picture'] ?? '';

  final String picture;
  final String name;
  final int price;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "picture": picture,
    };
  }
}

class ProductProvider extends ChangeNotifier {

  Future<String> addProduct({
    required Product product,
  }) async {
    try {
      final User? userCreditential = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCreditential?.uid)
          .collection('Products')
          .add(product.toJson());
      return "Produit ajouté avec succès.";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "L'utilisateur n'existe pas";
      }
    }
    return "Une erreur est survenue";
  }
}