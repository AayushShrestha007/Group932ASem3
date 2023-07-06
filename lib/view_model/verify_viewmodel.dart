import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyViewModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isEmailVerified = false;
  Timer? timer;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = auth.currentUser;
      await user?.sendEmailVerification();
    } catch (e) {
      print('Error sending verification email: $e');
    }
  }

  Future<void> checkEmailVerified() async {
    await auth.currentUser?.reload();
    isEmailVerified = auth.currentUser?.emailVerified ?? false;
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await sendVerificationEmail();
      }
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  void dispose() {
    timer?.cancel();
  }
}

