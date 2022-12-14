import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../animation/bouncing_logo.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 40),
          const SizedBox(
            height: 70,
            child: BouncingLogo(),
          ),
          const SizedBox(height: 51),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              "Connectez vous",
            ),
          ),
          const SizedBox(height: 51),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                "Adresse email",
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: primaryColor,
                decoration: const InputDecoration(
                  hintText: "john.doe@gmail.com",
                  prefixIcon: Icon(Icons.alternate_email, size: 14),
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
                "Mot de passe",
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "********",
                  prefixIcon: Icon(Icons.lock, size: 14),
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
                    await Provider.of<UserProvider>(context, listen: false)
                        .signIn(
                  emailAddress: _emailController.text,
                  password: _passwordController.text,
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
                    'Se connecter',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () => context.go('/sign-up'),
            child: const Text(
              "Cr??ez votre compte ici",
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
                color: primaryDarkerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
