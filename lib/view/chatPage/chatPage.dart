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
      appBar: AppBar(
        title: Text(
          chatController.receiverName.value,
          style: const TextStyle(color: Colors.blue),
        ),
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
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xff00bfa6),
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
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            chatList[index].message!,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
          TextField(
            maxLines: null,
            controller: chatController.txtMessage,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () async {
                    ChatModel chat = ChatModel(
                        sender: AuthService.authService.getCurrentUser()!.email,
                        receiver: chatController.receiverEmail.value,
                        time: Timestamp.now(),
                        message: chatController.txtMessage.text);
                    await CloudFireStoreServices.cloudFireStoreServices
                        .addChatInFireStore(chat);
                    chatController.txtMessage.clear();
                  },
                  icon: const Icon(Icons.send)),
              enabledBorder: OutlineInputBorder(),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
