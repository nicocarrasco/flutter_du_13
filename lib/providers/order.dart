import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Order {
  Order({
    required this.products,
    required this.price,
    required this.date,
    this.userId,
  });

  Order.fromMap(Map<String, dynamic> snapshot)
      : products = snapshot['products'] ?? '',
        price = snapshot['price'] ?? '',
        date = snapshot['date'].toDate() ?? '',
        userId = snapshot['userId'] ?? '';

  final List<dynamic> products;
  final DateTime date;
  final int price;
  String? userId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "products": products,
      "price": price,
      "date": date,
      "userId": ""
    };
  }
}

class OrderProvider extends ChangeNotifier {
  Future<List<Order>> getOrders() async {
    final List<Order> orderList = <Order>[];
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection("orders")
            .orderBy('date', descending: true)
            .get();
    final User? userCreditential = FirebaseAuth.instance.currentUser;

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      final dynamic a = querySnapshot.docs[i].data();
      if (!(userCreditential != null && userCreditential.uid == a["userId"])) {
        continue;
      }
      final Order order = Order.fromMap(querySnapshot.docs[i].data());
      orderList.add(order);
    }
    return orderList;
  }

  Future<String> addOrder({
    required Order order,
  }) async {
    try {
      final User? userCreditential = FirebaseAuth.instance.currentUser;

      final Map<String, dynamic> jsonOrder = order.toJson();
      if (userCreditential != null) {
        jsonOrder["userId"] = userCreditential.uid;
      }
      await FirebaseFirestore.instance.collection('orders').add(jsonOrder);
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "L'utilisateur n'existe pas";
      }
    }
    return "Une erreur est survenue";
  }
}
