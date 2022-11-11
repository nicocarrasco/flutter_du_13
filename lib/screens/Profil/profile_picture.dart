import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';

class ProfilPicture extends StatefulWidget {
  const ProfilPicture({Key? key}) : super(key: key);

  @override
  State<ProfilPicture> createState() => _ProfilPictureState();
}

class _ProfilPictureState extends State<ProfilPicture> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/250?image=9'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          TextButton(
            onPressed: () => {},
            child: const Text(
              "Modifiez votre photo de profil",
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
