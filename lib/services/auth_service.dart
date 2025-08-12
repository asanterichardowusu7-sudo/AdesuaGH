import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _fb = FirebaseAuth.instance;
  User? get user => _fb.currentUser;
  Stream<User?> get userChanges => _fb.authStateChanges();

  Future<void> signUp(String email, String password) async {
    await _fb.createUserWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    await _fb.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _fb.signOut();
    notifyListeners();
  }
}
