import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/screens/AddProduct/ImagePicker/image_picker.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
          const MultipleImagePicker(),
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
              // if (_formKey.currentState!.validate()) {
              //   final String message =
              //       await Provider.of<UserProvider>(context, listen: false)
              //           .signIn(
              //     emailAddress: _emailController.text,
              //     password: _passwordController.text,
              //   );

              //   if (message != "Success") {
              //     await Fluttertoast.showToast(
              //       msg: message,
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.BOTTOM,
              //       backgroundColor: errorColor,
              //       webBgColor: "#FF6666",
              //       webShowClose: true,
              //       webPosition: "center",
              //       textColor: backgroundLighterColor,
              //       fontSize: 16.0,
              //       timeInSecForIosWeb: 2,
              //     );
              //   }
              // }
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
