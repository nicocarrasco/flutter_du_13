import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/screens/Profil/profil_email.dart';
import 'package:flutter_du_13/screens/Profil/profile_form.dart';
import 'package:flutter_du_13/screens/Profil/profile_picture.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _SearchProfilState();
}

class _SearchProfilState extends State<ProfilPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                const ProfilPicture(),
                const Divider(
                  height: 20,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                  color: placeholderColor,
                ),
                const ProfilForm(),
                const Divider(
                  height: 20,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                  color: placeholderColor,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) => const ProfilEmail(),
                      ),
                    );
                  },
                  child: const Text(
                    "Changez d'adresse email",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryDarkerColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
