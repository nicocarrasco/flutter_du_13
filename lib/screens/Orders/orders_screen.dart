import 'package:flutter/material.dart';
import 'package:flutter_du_13/providers/order.dart';
import 'package:flutter_du_13/screens/Orders/Card/card_component.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> _allOrders = <Order>[];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
    super.initState();
  }

  Future<void> getData() async {
    final List<Order> orders = await OrderProvider().getOrders();
    setState(() {
      _allOrders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commandes passées'),
      ),
      body: Column(
        children: <Widget>[
          if (_allOrders.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _allOrders.length,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CardOrder(
                    order: _allOrders[index],
                  );
                },
              ),
            )
          else
            const Center(
              child: Text(
                'Vous n\'avez pas encore passé de commande',
                style: TextStyle(fontSize: 24),
              ),
            ),
        ],
      ),
    );
  }
}
