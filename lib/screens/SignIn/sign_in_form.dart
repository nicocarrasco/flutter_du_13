import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40),
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
                keyboardType: TextInputType.emailAddress,
                cursorColor: primaryColor,
                decoration: const InputDecoration(
                  hintText: "john.doe@gmail.com",
                  prefixIcon: Icon(Icons.alternate_email, size: 14),
                ),
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
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "********",
                  prefixIcon: Icon(Icons.lock, size: 14),
                ),
              ),
              const SizedBox(height: 45),
            ],
          ),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {},
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 45),
          const Text(
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            "Vous n’avez pas encore de compte?",
          ),
          const SizedBox(height: 6),
          const Text(
            "Créez votre compte ici",
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600,
              color: primaryDarkerColor,
            ),
          ),
        ],
      ),
    );
  }
}
