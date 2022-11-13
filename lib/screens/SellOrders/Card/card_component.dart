import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/providers/sell_order_provider.dart';

class CardOrder extends StatelessWidget {
  const CardOrder({super.key, required this.order});

  final SellOrder order;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 180,
        height: 130,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Vous avez vendu : ${order.products}"),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('À : ${order.buyerName}'),
                  const SizedBox(height: 10),
                  Text('Prix total : ${order.price} €'),
                  const SizedBox(height: 10),
                  Text(
                    'Date : ${order.date.day}/${order.date.month}/${order.date.year} à ${order.date.hour}h${order.date.minute.toString().padLeft(2, '0')}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
