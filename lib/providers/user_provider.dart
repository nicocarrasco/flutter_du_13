import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    _user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      if (_user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(_user?.uid)
            .snapshots()
            .listen(
              (DocumentSnapshot<Map<String, dynamic>> event) => <Set<void>>{
                if (event.data()!["role"] != null)
                  <void>{_role = event.data()!["role"], notifyListeners()}
              },
            );
      }

      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }
  User? _user;
  // "Vendeur" or "Acheteur" or null
  String? _role;

  bool isAuthenticated() => _user != null;
  String? getRole() => _role;
  String getName() {
    if (isAuthenticated() && _user!.displayName != null) {
      return _user!.displayName!;
    }
    return "";
  }

  Future<String> getPicture() async {
    if (isAuthenticated() && _user!.photoURL != null) {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference ref = storage.ref().child(_user!.photoURL!);
      final String picture = await ref.getDownloadURL();
      return picture;
    }
    return "https://picsum.photos/250?image=11";
  }

  String getEmailAdress() {
    if (isAuthenticated() && _user!.email != null) {
      return _user!.email!;
    }
    return "";
  }

  Future<String> updateName({
    required String name,
  }) async {
    if (!isAuthenticated()) {
      return "L'utilisateur n'est pas authentifié";
    }
    try {
      await _user!.updateDisplayName(name);
      return "Le nom a bien été changé";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "L'utilisateur n'existe pas";
      }
    }
    return "Une erreur est survenue";
  }

  Future<String> updateEmail({
    required String email,
    required String password,
  }) async {
    if (!isAuthenticated()) {
      return "L'utilisateur n'est pas authentifié";
    }
    try {
      final UserCredential userCred = await _user!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: getEmailAdress(),
          password: password,
        ),
      );
      if (userCred.user == null) {
        throw Exception();
      } else {
        await userCred.user?.updateEmail(email);
        return "L'email a bien été changé";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "L'utilisateur n'existe pas";
      } else if (e.code == 'wrong-password') {
        return "Mot de passe incorrect";
      }
    } on PlatformException catch (e) {
      if (e.code == 'EMAIL_EXISTS') {
        return "Email déjà utilisé";
      }
    }
    return "Une erreur est survenue";
  }

  Future<String> updatePicture({
    required XFile picture,
  }) async {
    try {
      final TaskSnapshot url = await FirebaseStorage.instance
          .ref('images/')
          .child('${DateTime.now().toIso8601String()}-${picture.name}')
          .putData(
            await picture.readAsBytes(),
          );
      await _user!.updatePhotoURL(url.ref.fullPath);
      return "L'image de profil a été mise à jour";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "L'utilisateur n'existe pas";
      }
    }
    return "Une erreur est survenue";
  }

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
          .set(<String, dynamic>{'role': role});
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
