
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

int currentIndexValue = 0;
class ChatController extends GetxController
{
  RxString receiverName = "".obs;
  RxString receiverEmail = "".obs;
  RxString receiverImage = "".obs;
  RxString image  = "".obs;
  TextEditingController txtMessage =  TextEditingController();
  TextEditingController txtUpdateMessage =  TextEditingController();


  void getReceiver(String name,String email,String image)
  {
    receiverName.value = name;
    receiverEmail.value = email;
    receiverImage.value=image;

  }
  void getImage(String url)
  {
    image.value = url;
  }


  void indexChange(int index)
  {

    currentIndexValue = index;
    print('${currentIndexValue}');

  }
  Color changeColor()
  {
    return const Color(0xff68d4d1);
  }


}