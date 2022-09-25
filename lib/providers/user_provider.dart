import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class UserProvider extends ChangeNotifier {
  User? _user;

  bool isAuthenticated() => _user != null;

  Future<String> signIn({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      _user = credential.user;
      notifyListeners();

      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "L'utilisateur n'existe pas";
      } else if (e.code == 'wrong-password') {
        return "Mot de passe incorrect";
      }
    }
    return "Une erreur est survenue";
  }
}
