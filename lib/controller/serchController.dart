
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Searchcontroller extends GetxController
{
  RxList searchResult  = [].obs;

  TextEditingController searchEditingController = TextEditingController();
  Future<QuerySnapshot<Map<String, dynamic>>> findUser(String name)
  async {
     var data = await FirebaseFirestore.instance.collection("chatroom").orderBy("name").get();
    return data;

  }

}