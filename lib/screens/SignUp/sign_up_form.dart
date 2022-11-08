import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _accountType = "Acheteur";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 30),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: 'Flut',
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                TextSpan(
                  text: 'Treize',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              "Inscription",
            ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                "Vous êtes...",
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 40.0),
                    decoration: _accountType == "Acheteur"
                        ? const BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 10.0,
                                color: primaryColor,
                              ),
                            ],
                          )
                        : null,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          splashColor: primaryColor.withAlpha(30),
                          onTap: () {
                            setState(() {
                              _accountType = "Acheteur";
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/images/seller.svg",
                                height: 75,
                                fit: BoxFit.scaleDown,
                              ),
                              const Text(
                                "Acheteur",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: _accountType == "Vendeur"
                        ? const BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 10.0,
                                color: primaryColor,
                              ),
                            ],
                          )
                        : null,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          splashColor: primaryColor.withAlpha(30),
                          onTap: () {
                            setState(() {
                              _accountType = "Vendeur";
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/images/seller.svg",
                                height: 75,
                                fit: BoxFit.scaleDown,
                              ),
                              const Text(
                                "Vendeur",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
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
                "Adresse email",
              ),
              const SizedBox(height: 15),
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
              const SizedBox(height: 15),
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
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final String message =
                    await Provider.of<UserProvider>(context, listen: false)
                        .signUp(
                  emailAddress: _emailController.text,
                  password: _passwordController.text,
                  role: _accountType,
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
                    "S'inscrire",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () => context.go('/sign-in'),
            child: const Text(
              "Revenir à l'écran de connexion",
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
