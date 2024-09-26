import 'dart:io';

import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/modal/cloud_modal.dart';
import 'package:chat_app/services/auth_services/auth_service.dart';
import 'package:chat_app/services/cloud_firestore_services.dart';
import 'package:chat_app/services/google/google_auth_services.dart';
import 'package:chat_app/services/notification/local_notification_services.dart';
import 'package:chat_app/utils/global.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ChatController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'ChatApp',
          style: TextStyle(color: Color(0xff8feac6)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(onTap: () async {
              await LocalNotificationServices.notificationServices.showScheduleNotification();
            },child: const Icon(Icons.notification_add_outlined,color: Colors.white,)),
          ),
          GestureDetector(onTap: () async {
            await LocalNotificationServices.notificationServices.showPeriodicNotification();
          },child: const Icon(Icons.add_comment_outlined, color: Colors.white)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
                onPressed: () {
                  AuthService.authService.signOutUser();
                  GoogleAuthService.googleAuthService.googleSignOut();
                  //user null
                  User? user = AuthService.authService.getCurrentUser();
                  if (user == null) {
                    Get.offAndToNamed('/signIn');
                  }
                },
                icon: const Icon(Icons.logout, color: Colors.white)),
          ),
        ],
      ),
      drawer: Drawer(
        shadowColor: Colors.white,
        child: FutureBuilder(
          future: CloudFireStoreServices.cloudFireStoreServices
              .readCurrentUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff1f6563),
                ),
              );
            }

            Map? data = snapshot.data!.data();
            UserModal userModal = UserModal.fromMap(data!);
            return Column(
              children: [
                DrawerHeader(
                  child: GestureDetector(
                    onTap: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      fileImage = File(file!.path);
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: (fileImage != null)
                          ? NetworkImage(FileImage(fileImage!).toString())
                          : const NetworkImage(
                              'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fvector%2Fdefault-avatar-female-profile-user-profile-icon-profile-picture-portrait-symbol-gm1469197622-500499399&psig=AOvVaw04lEsjZwuS41kogqnEzxRc&ust=1727224481056000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCNj9j-qq2ogDFQAAAAAdAAAAABAE'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Name  :  "),
                    Text(userModal.name!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Email:",
                      style: TextStyle(fontFamily: 'robot'),
                    ),
                    Text(userModal.email!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Phone :"),
                    Text(userModal.phone!),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      body: FutureBuilder(
        future: CloudFireStoreServices.cloudFireStoreServices.readAllUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List dataList = snapshot.data!.docs;
          List<UserModal> userList = [];
          for (var users in dataList) {
            userList.add(UserModal.fromMap(users.data()!));
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  chatController.getReceiver(userList[index].name!,
                      userList[index].email!, userList[index].image!);
                  Get.toNamed('/chat');
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(userList[index].image!),
                ),
                title: Text(
                  userList[index].name.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                subtitle: Text(
                  userList[index].email.toString(),
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            );
          }

          return Center(
            child: Text(snapshot.error.toString()),
          );
        },
      ),
    );
  }
}
