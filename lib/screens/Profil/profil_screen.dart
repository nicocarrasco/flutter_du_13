import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/screens/Profil/profile_form.dart';
import 'package:flutter_du_13/screens/Profil/profile_picture.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _SearchProfilState();
}

class _SearchProfilState extends State<ProfilPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: const [
                ProfilPicture(),
                Divider(
                  height: 20,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                  color: placeholderColor,
                ),
                ProfilForm()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
