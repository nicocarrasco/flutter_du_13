import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_svg/svg.dart';

class SignInBoard extends StatelessWidget {
  const SignInBoard({Key? key}) : super(key: key);

  List<Widget> getPictureAndText() {
    return <Widget>[
      SvgPicture.asset("images/login.svg"),
      const SizedBox(width: 40),
      const Text(
        "Content de vous revoir 👋",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 23,
          color: backgroundLighterColor,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: getPictureAndText(),
      ),
    );
  }
}
