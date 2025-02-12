import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:quicktask/auth/login_screen.dart';
import 'package:quicktask/models/user_info_model.dart';
import 'package:quicktask/screens/main_screen.dart';
import 'package:quicktask/utility/toast_msg.dart';

class AuthenticationProvider extends ChangeNotifier{

  bool _isLoading = false;
  bool get isLoading=> _isLoading;

  UserInfoModel? _userInfoModel;
  UserInfoModel? get userInfoModel=> _userInfoModel;

  final _auth= FirebaseAuth.instance;
  final _firestore= FirebaseFirestore.instance;

  AuthenticationProvider() {
    _auth.authStateChanges().listen(onAuthChanged);
  }


  Future<void> onAuthChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _userInfoModel = null;
    } else {
      final doc = await _firestore.collection('userDetails').doc(firebaseUser.uid).get();
      if (doc.exists) {
        _userInfoModel = UserInfoModel.fromJson(doc.data()!);
      } else {
        _userInfoModel = UserInfoModel(
          uuid: firebaseUser.uid,
          displayName: firebaseUser.displayName ?? "Guest",
          email: firebaseUser.email ?? "guest@gmail.com",
        );
        _firestore.collection('userDetails').doc(firebaseUser.uid).set(_userInfoModel!.toJson());
      }
    }
    notifyListeners();
  }


  Future<void> login(String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      if (user != null) {
        final doc = await _firestore.collection('userDetails').doc(user.uid).get();
        if (doc.exists) {
          _userInfoModel = UserInfoModel.fromJson(doc.data()!);
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
      }
    } on FirebaseAuthException catch (e) {
      ToastMsg.toastMsg(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> signup(String email, String password, String name, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        _userInfoModel = UserInfoModel(
          uuid: user.uid,
          displayName: name,
          email: user.email ?? "guest@gmail.com",
        );
        await _firestore.collection('userDetails').doc(user.uid).set(_userInfoModel!.toJson());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
      }
    } on FirebaseAuthException catch (e) {
      ToastMsg.toastMsg(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> changePassword(String newPassword) async {
    _isLoading = true;
    notifyListeners();
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        ToastMsg.toastMsg("Password updated successfully");
      }
    } on FirebaseAuthException catch (e) {
      ToastMsg.toastMsg(e.toString());
    }
    finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> logout(BuildContext context) async {
    try {
      await _auth.signOut();
      _userInfoModel = null;
      notifyListeners();
      PersistentNavBarNavigator.pushNewScreen(context,
          withNavBar: false,
          screen: const Login()
      );
    } on FirebaseAuthException catch (e) {
      ToastMsg.toastMsg(e.toString());
    }
  }
}
