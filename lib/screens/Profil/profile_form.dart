import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProfilForm extends StatefulWidget {
  const ProfilForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilForm> createState() => _ProfilFormState();
}

class _ProfilFormState extends State<ProfilForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isNameLoading = false;

  @override
  void initState() {
    _emailController.text =
        Provider.of<UserProvider>(context, listen: false).getEmailAdress();
    _nameController.text =
        Provider.of<UserProvider>(context, listen: false).getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                "Nom d'utilisateur",
              ),
              const SizedBox(height: 8),
              Focus(
                onFocusChange: (bool hasFocus) async {
                  if (!hasFocus) {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isNameLoading = true;
                      });
                      final String message = await Provider.of<UserProvider>(
                        context,
                        listen: false,
                      ).updateName(
                        name: _nameController.text,
                      );

                      setState(() {
                        _isNameLoading = false;
                      });

                      await Fluttertoast.showToast(
                        msg: message,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: primaryColor,
                        webBgColor: "#72B2D5",
                        webShowClose: true,
                        webPosition: "center",
                        textColor: backgroundLighterColor,
                        fontSize: 16.0,
                        timeInSecForIosWeb: 2,
                      );
                    }
                  }
                },
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      fontSize: 12,
                    ),
                    hintText: "Nom d'utilisateur",
                    prefixIcon: const Icon(Icons.person, size: 11),
                    suffix: _isNameLoading
                        ? const SizedBox(
                            height: 12,
                            width: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                            ),
                          )
                        : null,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: const <Widget>[
          //     Text(
          //       style: TextStyle(
          //         fontSize: 12,
          //         fontWeight: FontWeight.w600,
          //       ),
          //       "Adresse email",
          //     ),
          // Focus(
          //   onFocusChange: (bool hasFocus) async {
          //     if (!hasFocus) {
          //       if (_formKey.currentState!.validate()) {
          //         setState(() {
          //           _isNameLoading = true;
          //         });
          //         final String message = await Provider.of<UserProvider>(
          //           context,
          //           listen: false,
          //         ).updateEmail(
          //           email: _emailController.text,
          //         );

          //         setState(() {
          //           _isNameLoading = false;
          //         });

          //         await Fluttertoast.showToast(
          //           msg: message,
          //           toastLength: Toast.LENGTH_SHORT,
          //           gravity: ToastGravity.BOTTOM,
          //           backgroundColor: primaryColor,
          //           webBgColor: "#72B2D5",
          //           webShowClose: true,
          //           webPosition: "center",
          //           textColor: backgroundLighterColor,
          //           fontSize: 16.0,
          //           timeInSecForIosWeb: 2,
          //         );
          //       }
          //     }
          //   },
          //   child: TextFormField(
          //     style: const TextStyle(
          //       fontSize: 12,
          //     ),
          //     controller: _emailController,
          //     keyboardType: TextInputType.emailAddress,
          //     cursorColor: primaryColor,
          //     decoration: const InputDecoration(
          //       hintStyle: TextStyle(
          //         fontSize: 12,
          //       ),
          //       hintText: "john.doe@gmail.com",
          //       prefixIcon: Icon(Icons.alternate_email, size: 11),
          //     ),
          //     validator: (String? value) {
          //       if (value == null || value.isEmpty) {
          //         return 'Veuillez remplir ce champ';
          //       }
          //       return validateEmail(value);
          //     },
          //   ),
          // )
          //   ],
          // ),
        ],
      ),
    );
  }
}
