import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_du_13/providers/product.dart';

class SellOrder {
  SellOrder({
    required this.product,
    required this.price,
    this.buyerName,
    required this.date,
    this.userId,
  });

  SellOrder.fromMap(Map<String, dynamic> snapshot)
      : product = snapshot['product'] ?? '',
        price = snapshot['price'] ?? '',
        date = snapshot['date'].toDate() ?? '',
        buyerName = snapshot['buyerName'] ?? '',
        userId = snapshot['userId'] ?? '';

  final String product;
  final DateTime date;
  final int price;
  String? buyerName;
  String? userId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "products": product,
      "price": price,
      "buyerName": "",
      "date": date,
      "userId": ""
    };
  }
}

class SellOrderProvider extends ChangeNotifier {
  Future<List<SellOrder>> getSellOrders() async {
    final List<SellOrder> sellOrderList = <SellOrder>[];
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection("sell-orders")
            .orderBy('date', descending: true)
            .get();
    final User? userCreditential = FirebaseAuth.instance.currentUser;

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      final dynamic a = querySnapshot.docs[i].data();
      if (!(userCreditential != null && userCreditential.uid == a["userId"])) {
        continue;
      }
      final SellOrder sellOrder =
          SellOrder.fromMap(querySnapshot.docs[i].data());
      sellOrderList.add(sellOrder);
    }
    return sellOrderList;
  }

  Future<String> addSellOrder({
    required SellOrder sellOrder,
    required Product product,
  }) async {
    try {
      final User? userCreditential = FirebaseAuth.instance.currentUser;

      final Map<String, dynamic> jsonOrder = sellOrder.toJson();
      if (userCreditential != null) {
        jsonOrder["buyerName"] = userCreditential.displayName;
        jsonOrder["userId"] = product.userId;
      }
      await FirebaseFirestore.instance.collection('sell-orders').add(jsonOrder);
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "L'utilisateur n'existe pas";
      }
    }
    return "Une erreur est survenue";
  }
}
