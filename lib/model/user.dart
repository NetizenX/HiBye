import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User extends ChangeNotifier {
  // From the google_sign_in package
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  late String uid;

  void createUserInDB() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({});
  }

  Future<bool> userInDB() async {
    var docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return docSnapshot.exists;
  }

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // TODO: handle missing uid
      uid = FirebaseAuth.instance.currentUser!.uid;
      createUser();
      notifyListeners();
    }
  }

  Future googleSignOut() async {
    await googleSignIn.signOut();
    if (_user == null) {
      print('No user to sign out');
    } else {
      print('Signed out user ${_user!.displayName}.');
    }
    _user = null;
  }

  String getFirstName() {
    if (_user != null) {
      if (_user!.displayName != null) {
        return _user!.displayName!.split(" ")[0];
      }
    }
    return "not logged in";
  }

  void createUser() async {
    if (await userInDB() != true) {
      print('User not in DB');
      createUserInDB();
      print('User $uid created');
    } else {
      print('User already in db');
    }
  }
}
