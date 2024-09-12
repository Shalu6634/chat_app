import 'package:chat_app/modal/cloud_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CloudFireStoreServices {
  static CloudFireStoreServices cloudFireStoreServices = CloudFireStoreServices._();
  CloudFireStoreServices._();
  FirebaseFirestore firestore =  FirebaseFirestore.instance;
  void insertUserIntoFireStore(UserModal user)
  {
    firestore.collection("user").doc(user.email).set({
      'email':user.email,
      'name':user.name,
      'phone':user.phone,
      'image':user.image,
      // 'password':user.password,
      'token':user.token
      // "name"user.name
    });
  }
}