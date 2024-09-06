//keytool -list -v -alias androiddebugkey -keystore C:\Users\R4\.android\debug.keystore

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService
{
  GoogleAuthService._();
  static GoogleAuthService  googleAuthService = GoogleAuthService._();
  GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> signInWithGoogle()
  async {
  try
      {
        GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
        GoogleSignInAuthentication googleSignInAuthentication =await googleSignInAccount!.authentication;
        AuthCredential credential =GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken
        );
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        log(userCredential.user!.email.toString());
        log(userCredential.user!.photoURL.toString());
      }
      catch(e)
    {
      Get.snackbar("Google sign Failed!", e.toString());
      log(e.toString());
    }
  }

  Future<void> googleSignOut()
  async {
    await googleSignIn.signOut();
  }
}