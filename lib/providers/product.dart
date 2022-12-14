import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Product {
  Product({
    required this.picture,
    required this.name,
    required this.price,
    required this.description,
    this.userId,
    this.image,
  });

  Product.fromMap(Map<String, dynamic> snapshot)
      : price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        picture = snapshot['picture'] ?? '',
        description = snapshot['description'] ?? '',
        image = null,
        userId = snapshot['userId'] ?? '';

  final String picture;
  final String name;
  final int price;
  final String description;
  String? image;
  String? userId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": name,
      "price": price,
      "picture": picture,
      "description": description,
      "userId": ""
    };
  }
}

class ProductProvider extends ChangeNotifier {
  Future<String?> getFile(String imagePath) async {
    try {
      final Reference ref = FirebaseStorage.instance.ref(imagePath);
      final String datas = await ref.getDownloadURL();
      return datas;
    } catch (e) {
      return null;
    }
  }

  Future<List<Product>> getProducts(bool isSeller) async {
    final List<Product> productList = <Product>[];
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection("products").get();
    final User? userCreditential = FirebaseAuth.instance.currentUser;

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      final dynamic a = querySnapshot.docs[i].data();
      if (isSeller) {
        if (!(userCreditential != null &&
            userCreditential.uid == a["userId"])) {
          continue;
        }
      }
      final String? image = await getFile(a["picture"]);
      final Product product = Product.fromMap(querySnapshot.docs[i].data());
      product.image = image;
      productList.add(product);
    }
    return productList;
  }

  Future<String> sendFile(XFile? image) async {
    if (image != null) {
      try {
        final Reference ref =
            FirebaseStorage.instance.ref('images/').child(image.name);
        await ref.putData(await image.readAsBytes());
        return ref.fullPath;
      } catch (e) {
        await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: errorColor,
          webBgColor: "#FF6666",
          webShowClose: true,
          webPosition: "center",
        );
      }
    }
    return "";
  }

  Future<String> addProduct({
    required Product product,
    required XFile? image,
  }) async {
    try {
      final User? userCreditential = FirebaseAuth.instance.currentUser;

      final Map<String, dynamic> jsonProduct = product.toJson();
      if (userCreditential != null) {
        jsonProduct["userId"] = userCreditential.uid;
      }
      jsonProduct["picture"] = await sendFile(image);
      await FirebaseFirestore.instance.collection('products').add(jsonProduct);
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "L'utilisateur n'existe pas";
      }
    }
    return "Une erreur est survenue";
  }
}
