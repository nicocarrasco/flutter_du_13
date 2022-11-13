import 'package:flutter/material.dart';
import 'package:flutter_du_13/providers/sell_order_provider.dart';
import 'package:flutter_du_13/screens/SellOrders/Card/card_component.dart';

class SellOrdersPage extends StatefulWidget {
  const SellOrdersPage({Key? key}) : super(key: key);

  @override
  State<SellOrdersPage> createState() => _SellOrdersPagePageState();
}

class _SellOrdersPagePageState extends State<SellOrdersPage> {
  List<SellOrder> _allOrders = <SellOrder>[];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
    super.initState();
  }

  Future<void> getData() async {
    final List<SellOrder> orders = await SellOrderProvider().getSellOrders();
    setState(() {
      _allOrders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles vendus'),
      ),
      body: _allOrders.isNotEmpty
          ? Column(
              children: <Widget>[
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
              ],
            )
          : const Center(
              child: Text(
                'Vous n\'avez vendu aucun article',
                style: TextStyle(fontSize: 24),
              ),
            ),
    );
  }
}
