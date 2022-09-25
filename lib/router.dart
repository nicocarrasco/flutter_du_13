import 'package:flutter/material.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:flutter_du_13/screens/SignIn/sign_in_screen.dart';
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
            const Text("yo"),
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
      final String homePath = state.namedLocation("Home");
      if (!userProvider.isAuthenticated() && state.location != locPath) {
        return locPath;
      }
      if (userProvider.isAuthenticated() && state.location != homePath) {
        return homePath;
      }
      return null;
    },
  );
}
