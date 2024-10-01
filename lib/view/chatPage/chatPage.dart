import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/modal/chat_modal.dart';
import 'package:chat_app/services/auth_services/auth_service.dart';
import 'package:chat_app/services/cloud_firestore_services.dart';
import 'package:chat_app/services/storage_image_folder/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/notification/local_notification_services.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var chatController = Get.put(ChatController());
    return Scaffold(

      appBar: AppBar(
      backgroundColor: chatController.changeColor(),
        leadingWidth: width * 1.5,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(
              width: 7,
            ),
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(chatController.receiverImage.value),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    chatController.receiverName.value,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 18),
                  //   child: StreamBuilder(
                  //     stream: CloudFireStoreServices.cloudFireStoreServices
                  //         .findUserOnlineOrNot(),
                  //     builder: (context, snapshot) {
                  //       Map? user = snapshot.data!.data();
                  //       return Text(
                  //         user?['isOnline'] ? "online" : " ",
                  //         style: TextStyle(color: Colors.green, fontSize: 12),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.add_ic_call_rounded,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
          ),
        ],
        bottomOpacity: 2,
        shadowColor: Colors.white70,
        elevation: 1.5,
      ),
      body:
      Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: CloudFireStoreServices.cloudFireStoreServices
                .readChatFromFireStore(chatController.receiverEmail.value),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              List data = snapshot.data!.docs;
              List<ChatModel> chatList = [];
              List docIdList = [];
              for (QueryDocumentSnapshot snap in data) {
                docIdList.add(snap.id);
                chatList.add(
                  ChatModel.fromMap(
                    snap.data() as Map,
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                    chatList.length,
                    (index) => Align(
                      alignment: (chatList[index].sender ==
                              AuthService.authService.getCurrentUser()!.email)
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                "Update your message!",
                                style: TextStyle(fontSize: 17),
                              ),
                              content: TextField(
                                controller: chatController.txtUpdateMessage,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    if (chatList[index].sender ==
                                        AuthService.authService
                                            .getCurrentUser()!
                                            .email) {
                                      String dcId = docIdList[index];
                                      CloudFireStoreServices
                                          .cloudFireStoreServices
                                          .updateChat(
                                              dcId,
                                              chatController
                                                  .receiverEmail.value,
                                              chatController
                                                  .txtUpdateMessage.text);
                                      Get.back();
                                    }
                                  },
                                  child: const Text(
                                    "Update",
                                    style: TextStyle(color: Color(0xff1f6563)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    "ok",
                                    style: TextStyle(
                                      color: Color(0xff1f6563),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        onDoubleTap: () {
                          if (chatList[index].sender ==
                              AuthService.authService.getCurrentUser()!.email) {
                            CloudFireStoreServices.cloudFireStoreServices
                                .removeChat(docIdList[index],
                                    chatController.receiverEmail.value);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 1),
                            decoration: BoxDecoration(
                              color: (chatList[index].sender ==
                                      AuthService.authService
                                          .getCurrentUser()!
                                          .email
                                  ? const Color(0xff00a985)
                                  : Color(0xff1f6563)),
                              borderRadius: (chatList[index].sender ==
                                      AuthService.authService
                                          .getCurrentUser()!
                                          .email)
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))
                                  : const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                            ),
                            child: (chatList[index].image!.isEmpty &&
                                    chatList[index].image == "")
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 5, right: 10, bottom: 5),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: chatList[index].message!,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                          TextSpan(
                                              text:
                                                  "\t\t${(chatList[index].time!.toDate().hour > 9 && chatList[index].time!.toDate().hour < 24) ? (chatList[index].time!.toDate().hour % 12) : '0${(chatList[index].time!.toDate().hour)}'} : ${(chatList[index].time!.toDate().minute > 9) ? (chatList[index].time!.toDate().minute) : '0${(chatList[index].time!.toDate().minute)}'} ",
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white)),
                                          TextSpan(
                                              text: (chatList[index]
                                                          .time!
                                                          .toDate()
                                                          .hour >
                                                      12)
                                                  ? 'PM'
                                                  : 'AM',
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: height * 0.3,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            chatList[index].image!),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
          Padding(
              padding: const EdgeInsets.only(right: 20, left: 10, bottom: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50,
                    width: 270,
                    child: TextField(
                      maxLines: null,
                      style: TextStyle(color: Colors.black),
                      controller: chatController.txtMessage,
                      cursorColor: Color(0xff00a985),
                      cursorWidth: 2,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                String url =
                                    await StorageService.service.uploadImage();
                                chatController.getImage(url);
                              },
                              icon: Icon(
                                Icons.image,

                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  ChatModel chat = ChatModel(
                                      sender: AuthService.authService
                                          .getCurrentUser()!
                                          .email,
                                      receiver:
                                          chatController.receiverEmail.value,
                                      time: Timestamp.now(),
                                      message: chatController.txtMessage.text,
                                      image: chatController.image.value);
                                  await CloudFireStoreServices
                                      .cloudFireStoreServices
                                      .addChatInFireStore(chat);

                                  await LocalNotificationServices
                                      .notificationServices
                                      .showNotification(
                                          AuthService.authService
                                              .getCurrentUser()!
                                              .email!,
                                          chatController.txtMessage.text);

                                  chatController.getImage("");
                                  chatController.txtMessage.clear();
                                },
                                icon: const Icon(
                                  Icons.send,

                                )),
                          ],
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Color(0xff00a985))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Color(0xff00a985))),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff00a985),
                      ),
                      child: Icon(
                        Icons.mic_rounded,
                        color: Colors.white,
                        size: 29,
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
