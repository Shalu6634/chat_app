//keytool -list -v -alias androiddebugkey -keystore C:\Users\R4\.android\debug.keystore

import 'dart:developer';

import 'package:chat_app/modal/cloud_modal.dart';
import 'package:chat_app/services/cloud_firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleAuthService._();

  static GoogleAuthService googleAuthService = GoogleAuthService._();
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      UserModal userModal=UserModal(
          name: userCredential.user!.displayName.toString(),
          email: userCredential.user!.email,
          phone: userCredential.user!.phoneNumber.toString(),
          token: "___",
          image: userCredential.user!.photoURL.toString());
      CloudFireStoreServices.cloudFireStoreServices.insertUserIntoFireStore(userModal);
      log(userCredential.user!.email.toString());
      log(userCredential.user!.photoURL.toString());
    } catch (e) {
      Get.snackbar("Google sign Failed!", e.toString());
      log(e.toString());
    }

  }

  Future<void> googleSignOut() async {
    await googleSignIn.signOut();
  }
}
