
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthService {
  static AuthService authService = AuthService._();

  AuthService._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //ACCOUNT CREATE - SIGNUP

  Future<void> createAccountWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  //LOGIN SIGN IN
  Future<String> signInWithEmailAndPassword(String email, String password) async {
   try{
     await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
     return 'success';
   }
   catch(e)
    {
      return e.toString();
    }
  }
  //SIGN OUT
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //CURRENT USER DETAIL
  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if(user!=null)
      {
        log("email :${user.email}");
      }
    return user;
  }
}
