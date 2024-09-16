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
          style: TextStyle(color: Colors.blue),
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List data = snapshot.data!.docs;
              List<ChatModel> chatList = [];
              for (var i in data) {
                chatList.add(
                  ChatModel.fromMap(
                    i.data(),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: chatList.length,
                  itemBuilder: (context, index) =>
                      Text(chatList[index].message!));
            },
          )),
          TextField(
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
                  },
                  icon: Icon(Icons.send)),
              enabledBorder: OutlineInputBorder(),
              border: OutlineInputBorder(
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
