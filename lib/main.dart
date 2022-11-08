import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:flutter_du_13/router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<UserProvider>(
          create: (BuildContext context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (BuildContext context, UserProvider user, Widget? child) {
        return MultiProvider(
          providers: <SingleChildWidget>[
            Provider<AppRouter>(
              create: (BuildContext createContext) => AppRouter(user),
            ),
          ],
          child: Builder(
            builder: (BuildContext context) {
              final GoRouter router =
                  Provider.of<AppRouter>(context, listen: false).router;
              return MaterialApp.router(
                routerConfig: router,
                title: 'FlutTreize',
                themeMode: ThemeMode.light,
                theme: ThemeData(
                  brightness: Brightness.light,
                  fontFamily: "Montserrat",
                  scaffoldBackgroundColor: backgroundColor,
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    errorStyle:
                        TextStyle(fontSize: 12, height: 1, color: errorColor),
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
              );
            },
          ),
        );
      },
    );
  }
}
