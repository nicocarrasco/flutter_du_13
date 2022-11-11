import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/firebase/product.dart';
import 'package:flutter_du_13/screens/AddProduct/ImagePicker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  List<XFile> _imagefiles = <XFile>[];

  void _manageStateForChildWidget(List<XFile> newValue) {
    setState(() {
      // if (newValue.isNotEmpty) {
      //   Fluttertoast.showToast(
      //     msg: newValue[0].path,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: errorColor,
      //     webBgColor: "#FF6666",
      //     webShowClose: true,
      //     webPosition: "center",
      //     textColor: backgroundLighterColor,
      //     fontSize: 16.0,
      //     timeInSecForIosWeb: 2,
      //   );
      // }
      _imagefiles = newValue;
    });
  }

  Widget buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 30,
        crossAxisSpacing: 24,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (BuildContext context, int index) =>
      kIsWeb? Image.network(_imagefiles[index].path) : Image.file(File(_imagefiles[index].path)),
      itemCount: _imagefiles.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 40),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: 'Vendre un produit',
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 51),
          MultipleImagePicker(notifyParent: _manageStateForChildWidget,),
          const SizedBox(height: 20),
          SizedBox(
            height: _imagefiles.isNotEmpty ? 150 : 0,
            width: _imagefiles.isNotEmpty ?  MediaQuery.of(context).size.width : 0,
            child: Expanded(
              child:  buildGridView(),
            ),
          ),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                "Nom du produit",
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _productNameController,
                keyboardType: TextInputType.text,
                cursorColor: primaryColor,
                decoration: const InputDecoration(
                  hintText: "Lampe",
                  // prefixIcon: Icon(Icons.alternate_email, size: 14),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez remplir ce champ';
                  }
                  return null;
                },
              )
            ],
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                "Description",
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _productDescriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "Description de la lampte",
                  // prefixIcon: Icon(Icons.lock, size: 14),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez remplir ce champ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                "Prix",
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _productPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "10",
                  // prefixIcon: Icon(Icons.lock, size: 14),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez remplir ce champ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 45),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final String message =
                    await ProductProvider()
                      .addProduct(
                        product: Product(
                          picture: "test",
                          name: _productNameController.text,
                          price: int.parse(_productPriceController.text),
                        ),
                        images: _imagefiles,
                      );
                if (message != "Success") {
                  await Fluttertoast.showToast(
                    msg: message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: errorColor,
                    webBgColor: "#FF6666",
                    webShowClose: true,
                    webPosition: "center",
                    textColor: backgroundLighterColor,
                    fontSize: 16.0,
                    timeInSecForIosWeb: 2,
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  end: Alignment(2.5, 2.5),
                  colors: <Color>[primaryDarkerColor, primaryLighterColor],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const SizedBox(
                width: 300,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17),
                  child: Text(
                    'Vendre',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
