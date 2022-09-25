import 'package:flutter/material.dart';

import 'sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: const <Widget>[
            Spacer(),
            Expanded(
              flex: 8,
              child: SignInForm(),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
