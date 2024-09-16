import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? sender, receiver, message;
  Timestamp time;

  ChatModel(
      {required this.sender,
      required this.receiver,
      required this.time,
      required this.message});

  factory ChatModel.fromMap(Map m1) {
    return ChatModel(
        sender: m1['sender'],
        receiver: m1['receiver'],
        time: m1['time'],
        message: m1['message']);
  }

  Map<String, dynamic> toMap(ChatModel chat)
  {
    return {
    'sender':chat.sender,
    'receiver':chat.receiver,
    'time':chat.time,
    'message':chat.message,
    };
  }
}
