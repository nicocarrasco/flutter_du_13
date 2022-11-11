import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:flutter_du_13/utils/validateEmail.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProfilEmail extends StatefulWidget {
  const ProfilEmail({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilEmail> createState() => _ProfilEmailState();
}

class _ProfilEmailState extends State<ProfilEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    _emailController.text =
        Provider.of<UserProvider>(context, listen: false).getEmailAdress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: primaryDarkerColor, //change your color here
          ),
          actions: <Widget>[
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                ),
              )
            else
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    final String message = await Provider.of<UserProvider>(
                      context,
                      listen: false,
                    ).updateEmail(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    setState(() {
                      _isLoading = false;
                    });

                    final bool isError = message != "L'email a bien été changé";

                    await Fluttertoast.showToast(
                      msg: message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: isError ? errorColor : primaryColor,
                      webBgColor: "#72B2D5",
                      webShowClose: true,
                      webPosition: "center",
                      textColor: backgroundLighterColor,
                      fontSize: 16.0,
                      timeInSecForIosWeb: 2,
                    );
                    if (!isError) {
                      Navigator.pop(
                        context,
                      );
                    }
                  }
                },
                child: const Text(
                  "Enregistrer",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryDarkerColor,
                  ),
                ),
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                "Adresse email",
              ),
              const SizedBox(height: 8),
              TextFormField(
                style: const TextStyle(
                  fontSize: 12,
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: primaryColor,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 12,
                  ),
                  hintText: "john.doe@gmail.com",
                  prefixIcon: Icon(Icons.alternate_email, size: 11),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez remplir ce champ';
                  }
                  return validateEmail(value);
                },
              ),
              const SizedBox(height: 12),
              const Text(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                "Mot de passe",
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                style: const TextStyle(
                  fontSize: 12,
                ),
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "********",
                  prefixIcon: Icon(Icons.lock, size: 11),
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
        ),
      ),
    );
  }
}
