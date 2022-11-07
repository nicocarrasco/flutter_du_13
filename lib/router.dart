import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:flutter_du_13/screens/Shop/shop_screen.dart';
import 'package:flutter_du_13/screens/SignIn/sign_in_screen.dart';
import 'package:flutter_du_13/screens/SignUp/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter(this.userProvider);
  final UserProvider userProvider;

  late final GoRouter router = GoRouter(
    refreshListenable: userProvider,
    routes: <RouteBase>[
      GoRoute(
        name: "Home",
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const ShopPage(),
        // ElevatedButton(
        //   onPressed: () async {
        //     await FirebaseAuth.instance.signOut();
        //   },
        //   style: ElevatedButton.styleFrom(
        //     padding: EdgeInsets.zero,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(15),
        //     ),
        //   ),
        //   child: Ink(
        //     decoration: BoxDecoration(
        //       gradient: const LinearGradient(
        //         end: Alignment(2.5, 2.5),
        //         colors: <Color>[primaryDarkerColor, primaryLighterColor],
        //       ),
        //       borderRadius: BorderRadius.circular(15),
        //     ),
        //     child: const SizedBox(
        //       width: 300,
        //       child: Padding(
        //         padding: EdgeInsets.symmetric(vertical: 17),
        //         child: Text(
        //           "S'inscrire",
        //           textAlign: TextAlign.center,
        //           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      GoRoute(
        name: "SignUp",
        path: '/sign-up',
        builder: (BuildContext context, GoRouterState state) =>
            const SignUpScreen(),
      ),
      GoRoute(
        name: "SignIn",
        path: '/sign-in',
        builder: (BuildContext context, GoRouterState state) =>
            const SignInScreen(),
      ),
    ],
//     errorPageBuilder: (context, state) => MaterialPage<void>(
//   key: state.pageKey,
//   child: ErrorPage(error: state.error),
// ),
    redirect: (BuildContext context, GoRouterState state) {
      final String locPath = state.namedLocation("SignIn");
      final String signUpPath = state.namedLocation("SignUp");
      final String homePath = state.namedLocation("Home");
      if (!userProvider.isAuthenticated() &&
          state.location != locPath &&
          state.location != signUpPath) {
        return locPath;
      }
      if (userProvider.isAuthenticated() && state.location != homePath) {
        return homePath;
      }
      return null;
    },
  );
}
