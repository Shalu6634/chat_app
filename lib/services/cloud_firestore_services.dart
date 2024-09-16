import 'package:chat_app/modal/chat_modal.dart';
import 'package:chat_app/modal/cloud_modal.dart';
import 'package:chat_app/services/auth_services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CloudFireStoreServices {
  static CloudFireStoreServices cloudFireStoreServices =
      CloudFireStoreServices._();

  CloudFireStoreServices._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void insertUserIntoFireStore(UserModal user) {
    fireStore.collection("user").doc(user.email).set({
      'email': user.email,
      'name': user.name,
      'phone': user.phone,
      'image': user.image,
      // 'password':user.password,
      'token': user.token
      // "name"user.name
    });
  }

  //READ CURRENT USER DATA - PROFILE PAGE
  Future<DocumentSnapshot<Map<String, dynamic>>> readCurrentUserData() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore.collection("user").doc(user!.email).get();
  }

  // READ ALL USER DATA - HOMEPAGE
  Future<QuerySnapshot<Map<String, dynamic>>> readAllUserData() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore
        .collection("user")
        .where("email", isNotEqualTo: user!.email)
        .get();
  }

  //where("email",isnotequalto : user.email)

  Future<void> addChatInFireStore(ChatModel chat) async {
    String? sender = chat.sender;
    String? receiver = chat.receiver;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join('_');
    await fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .add(chat.toMap(chat));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readChatFromFireStore(String receiver)
  {
    String? sender = AuthService.authService.getCurrentUser()!.email;
    List doc = [sender,receiver];
    doc.sort();
    String docId = doc.join("_");
    return fireStore.collection("chatroom").doc(docId).collection("chat").snapshots();
  }
}
