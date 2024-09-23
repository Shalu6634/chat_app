import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/modal/chat_modal.dart';
import 'package:chat_app/services/auth_services/auth_service.dart';
import 'package:chat_app/services/cloud_firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ChatController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          children: [
            Text(
              chatController.receiverName.value,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
            StreamBuilder(
                stream: CloudFireStoreServices.cloudFireStoreServices
                    .findUserOnlineOrNot(),
                builder: (context, snapshot) {
                  Map? user = snapshot.data!.data();
                  return Text(user!['isOnline']?"online":" ",style: TextStyle(color: Colors.green,fontSize: 12),);
                },)
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(chatController.receiverImage.value),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: CloudFireStoreServices.cloudFireStoreServices
                .readChatFromFireStore(chatController.receiverEmail.value),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
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
              return Column(
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
                            title: const Text("Update"),
                            content: TextField(
                              controller: chatController.txtUpdateMessage,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(),
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
                                  child: const Text("Update"))
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
                              horizontal: 5, vertical: 6),
                          decoration: BoxDecoration(
                            color: (chatList[index].sender ==
                                    AuthService.authService
                                        .getCurrentUser()!
                                        .email
                                ? Color(0xff1f6563)
                                : Colors.white),
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
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Text(
                              chatList[index].message!,
                              style: TextStyle(
                                  color: (chatList[index].sender ==
                                          AuthService.authService
                                              .getCurrentUser()!
                                              .email
                                      ? Colors.white
                                      : Colors.black),
                                  fontSize: 15),
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
              padding: const EdgeInsets.only(right: 20, left: 10, bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50,
                    width: 270,
                    child: TextField(
                      maxLines: null,
                      style: TextStyle(color: Colors.white),
                      controller: chatController.txtMessage,
                      cursorColor: Colors.white,
                      cursorWidth: 2,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              ChatModel chat = ChatModel(
                                  sender: AuthService.authService
                                      .getCurrentUser()!
                                      .email,
                                  receiver: chatController.receiverEmail.value,
                                  time: Timestamp.now(),
                                  message: chatController.txtMessage.text);
                              await CloudFireStoreServices
                                  .cloudFireStoreServices
                                  .addChatInFireStore(chat);
                              chatController.txtMessage.clear();
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white)),
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
                        color: Color(0xff374751),
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
