import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

class Product {
  const Product({
    required this.id,
    required this.picture,
    required this.name,
    required this.price,
    required this.userId,
  });

  Product.fromMap(Map<String, > snapshot, this.id) :
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        picture = snapshot['picture'] ?? '',
        userId = snapshot['userId'] ?? '';

  final String id;
  final String picture;
  final String name;
  final String price;
  final String userId;

  Map<String, Object> toJson() {
    return {
      "price": price,
      "name": name,
      "picture": picture,
      "userId": userId
    };
  }
}

class ProductProvider extends ChangeNotifier {
  ProductProvider() {
    CollectionReference product = FirebaseFirestore.instance.collection('products');
  }

  Future<String> signIn({
    required String emailAddress,
    required String password,
  }) async {
    try {
      return students
          //adding to firebase collection
          .add({
            //Data added in the form of a dictionary into the document.
            'full_name': fullName, 
            'grade': grade, 
            'age': age
          })
          .then((value) => print("Student data Added"))
          .catchError((error) => print("Student couldn't be added."));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "L'utilisateur n'existe pas";
      } else if (e.code == 'wrong-password') {
        return "Mot de passe incorrect";
      }
    }
    return "Une erreur est survenue";
  }
}