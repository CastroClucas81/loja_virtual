import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  static UserModel of(BuildContext context) => ScopedModel.of(context);

  // quando o app abre
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

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

  void signIn({
    required String email,
    required String pass,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((authCredential) async {
      firebaseUser = authCredential.user;

      await _loadCurrentUser();

      onSuccess();

      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFailure();
      isLoading = false;
      notifyListeners();
    });
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  // salvando no firebase
  _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .set(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser;

    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot<Map<String, dynamic>> docUser = await FirebaseFirestore
            .instance
            .collection("users")
            .doc(firebaseUser!.uid)
            .get();

        userData = docUser.data()!;
      }
    }

    notifyListeners();
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  void signOut() {
    _auth.signOut();

    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }
}
