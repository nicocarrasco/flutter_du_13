import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/responsive.dart';

import 'add_product_form.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  List<Widget> getAddProductScreen(BuildContext context) {
    return <Widget>[
      Expanded(
        child: SingleChildScrollView(
          child: Row(
            children: <Widget>[
              const Spacer(),
              Expanded(
                flex: MediaQuery.of(context).size.width < registerSmallScreen
                    ? 8
                    : 4,
                child: const AddProductForm(),
              ),
              const Spacer()
            ],
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MediaQuery.of(context).size.width > registerBigScreen
            ? Row(
                textDirection: TextDirection.rtl,
                children: getAddProductScreen(context),
              )
            : Column(children: getAddProductScreen(context)),
      ),
    );
  }
}
