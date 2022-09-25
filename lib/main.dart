import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/screens/SignIn/sign_in_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutTreize',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: "Montserrat",
        scaffoldBackgroundColor: backgroundColor,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          errorStyle: TextStyle(fontSize: 12, height: 1, color: errorColor),
          prefixIconColor: placeholderColor,
          hintStyle: TextStyle(color: placeholderColor, fontSize: 14),
          fillColor: backgroundLighterColor,
          hoverColor: backgroundLighterColor,
          // contentPadding: EdgeInsets.symmetric(
          //     horizontal: defaultPadding, vertical: defaultPadding,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SignInScreen(),
    );
  }
}
