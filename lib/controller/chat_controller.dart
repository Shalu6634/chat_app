import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController
{
  RxString receiverName = "".obs;
  RxString receiverEmail = "".obs;
  RxString receiverImage = "".obs;
  TextEditingController txtMessage =  TextEditingController();
  TextEditingController txtUpdateMessage =  TextEditingController();

  void getReceiver(String name,String email,String image)
  {
    receiverName.value = name;
    receiverEmail.value = email;
    receiverImage.value=image;

  }
}