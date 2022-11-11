import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage_web/firebase_storage_web.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:flutter_du_13/constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  Future<String> sendFile(XFile? image) async {
    if (image != null) {
        try {
          // if (!kIsWeb) {
          final Reference ref = FirebaseStorage.instance.ref('images/').child(image.name);
          await ref.putFile(File(image.path));
          return ref.fullPath;
          // } else {
            // var ref = FirebaseStorageWeb().
          // }
        } catch (e) {
         developer.log(e.toString());
         await Fluttertoast.showToast(
         msg: e.toString(),
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         backgroundColor: errorColor,);
        }
    }
    return "";
  }

  Future<String> addProduct({
    required Product product,
    required XFile? image,
  }) async {

    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final User? userCreditential = FirebaseAuth.instance.currentUser;

      final Map<String, dynamic> jsonProduct = product.toJson();
      if (userCreditential != null) {
        jsonProduct["userId"] = userCreditential.uid;
      }
      // await Fluttertoast.showToast(
      //   msg: "tes1t",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: errorColor,);
      jsonProduct["picture"] = await sendFile(image);
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