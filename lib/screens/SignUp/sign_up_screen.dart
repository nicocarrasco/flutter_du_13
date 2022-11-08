import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/responsive.dart';
import 'package:flutter_du_13/screens/SignIn/sign_in_board.dart';

import 'sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  Widget getSignInBoard(dynamic context) {
    return Expanded(
      flex: MediaQuery.of(context).size.width > registerBigScreen ? 5 : 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[Expanded(child: SignInBoard())],
      ),
    );
  }

  List<Widget> getSignUpScreen(BuildContext context) {
    return <Widget>[
      if (MediaQuery.of(context).size.width >= registerSmallScreen)
        getSignInBoard(context),
      Expanded(
        flex: MediaQuery.of(context).size.width > registerBigScreen ? 5 : 7,
        child: SingleChildScrollView(
          child: Row(
            children: <Widget>[
              const Spacer(),
              Expanded(
                flex: MediaQuery.of(context).size.width < registerSmallScreen
                    ? 8
                    : 4,
                child: const SignUpForm(),
              ),
              const Spacer()
            ],
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MediaQuery.of(context).size.width > registerBigScreen
            ? Row(
                textDirection: TextDirection.rtl,
                children: getSignUpScreen(context),
              )
            : Column(children: getSignUpScreen(context)),
      ),
    );
  }
}
