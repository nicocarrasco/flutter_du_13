import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class UserProvider extends ChangeNotifier {
  UserProvider() {
    _user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }
  User? _user;

  bool isAuthenticated() => _user != null;

  Future<String> signIn({
    required String emailAddress,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
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

  Future<String> signUp({
    required String emailAddress,
    required String password,
    required String role,
  }) async {
    try {
      final UserCredential newUserCreditential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(newUserCreditential.user?.uid)
          .set({'role': role});
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
