import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/providers/order.dart';

class CardOrder extends StatelessWidget {
  const CardOrder({super.key, required this.order});

  final Order order;

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
        height: 180,
        child: Column(
          children: <Widget>[
            const Spacer(
              flex: 3,
            ),
            Row(
              children: <Widget>[
                // const Text("Vous avez commandé :"),
                // const Spacer(),
                // Text(order.name),
                // const Spacer(
                //   flex: 2,
                // ),
                Text('Prix total : ${order.price} €'),
                // const Spacer()
              ],
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
