import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';

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
    return  <String, dynamic>{
      "name": name,
      "price": price,
      "picture": picture,
      "userId": ""
    };
  }
}

class ProductProvider extends ChangeNotifier {

  Future<String> addProduct({
    required Product product,
    required List<XFile> images,
  }) async {

    try {
      final User? userCreditential = FirebaseAuth.instance.currentUser;

      final Map<String, dynamic> jsonProduct = product.toJson();
      if (userCreditential != null) {
        jsonProduct["userId"] = userCreditential.uid;
      }
      await FirebaseFirestore.instance
          .collection('products')
          .add(jsonProduct);
      return "Produit ajouté avec succès.";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "L'utilisateur n'existe pas";
      }
    }
    return "Une erreur est survenue";
  }
}