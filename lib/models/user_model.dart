import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  void signUp({
    required Map<String, dynamic> userData,
    required String pass,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
      email: userData["email"],
      password: pass,
    )
        .then((authCredential) async {
      firebaseUser = authCredential.user;

      await _saveUserData(userData);

      onSuccess();

      isLoading = false;
      notifyListeners();
    }).catchError((err) {
      onFailure();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn() {
    isLoading = true;

    notifyListeners();
  }

  void recoverPass() {}

  // salvando no firebase
  _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .set(userData);
  }
}
