// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:salon_hub/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({String? email, String? password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);

      if (_firebaseAuth.currentUser!.emailVerified) {
        return "Signed in";
      } else {
        try {
          await _firebaseAuth.currentUser!.sendEmailVerification();
          return "not verified";
        } catch (e) {
          return e.toString();
        }
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  String uid = "";

  Future<String> signUp(
      {String? email,
      String? password,
      String? firstName,
      String? lastName,
      String? salonName,
      String? address,
      String? phonenum}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      CustomUser user = salonName != ""
          ? CustomUser(
              address: address,
              salonName: salonName,
              phoneno: phonenum,
              isSalon: true)
          : CustomUser(
              address: address,
              phoneno: phonenum,
              salonName: salonName,
              isSalon: false);
      uid = _firebaseAuth.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .set(user.toJson());

      try {
        await _firebaseAuth.currentUser!.sendEmailVerification();
        _firebaseAuth.currentUser!
            .updateDisplayName("${firstName} ${lastName}");
        return "Verification link sent";
      } catch (e) {
        return e.toString();
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Signed out";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "Reset Link sent";
    } catch (e) {
      return e.toString();
    }
  }

  User? getUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }
}
