import 'package:flutter/material.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:flutter_du_13/screens/AddProduct/add_product_screen.dart';
import 'package:flutter_du_13/screens/Cart/cart_screen.dart';
import 'package:flutter_du_13/screens/Home/home_screen.dart';
import 'package:flutter_du_13/screens/Orders/orders_screen.dart';
import 'package:flutter_du_13/screens/Profil/profil_screen.dart';
import 'package:flutter_du_13/screens/SignIn/sign_in_screen.dart';
import 'package:flutter_du_13/screens/SignUp/sign_up_screen.dart';
import 'package:flutter_du_13/ui/bottom_bar.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        child,
  );
}

class AppRouter {
  AppRouter(this.userProvider);
  final UserProvider userProvider;

  late final GoRouter router = GoRouter(
    refreshListenable: userProvider,
    routes: <RouteBase>[
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return BottomBar(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            name: "Home",
            path: '/',
            pageBuilder: (BuildContext context, GoRouterState state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const HomePage(),
            ),
          ),
          GoRoute(
            name: "Cart",
            path: '/cart',
            pageBuilder: (BuildContext context, GoRouterState state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const Cart(),
            ),
          ),
          GoRoute(
            name: "Orders",
            path: '/orders',
            pageBuilder: (BuildContext context, GoRouterState state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const OrdersPage(),
            ),
          ),
          GoRoute(
            name: "Profil",
            path: '/profil',
            pageBuilder: (BuildContext context, GoRouterState state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const ProfilPage(),
            ),
          ),
          GoRoute(
            name: "AddProduct",
            path: '/addproduct',
            pageBuilder: (BuildContext context, GoRouterState state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const AddProductScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        name: "SignUp",
        path: '/sign-up',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        name: "SignIn",
        path: '/sign-in',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const SignInScreen(),
        ),
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
      final String cartPath = state.namedLocation("Cart");
      final String orderPath = state.namedLocation("Orders");
      final String profilPath = state.namedLocation("Profil");

      final String addProduct = state.namedLocation("AddProduct");

      final List<String> authRoutes = userProvider.getRole() == "Acheteur"
          ? <String>[homePath, cartPath, orderPath, profilPath]
          : <String>[homePath, addProduct, profilPath];

      if ((!userProvider.isAuthenticated() || userProvider.getRole() == null) &&
          state.location != locPath &&
          state.location != signUpPath) {
        return locPath;
      }
      if (userProvider.isAuthenticated() &&
          userProvider.getRole() != null &&
          !authRoutes.contains(state.location)) {
        return homePath;
      }
      return null;
    },
  );
}
