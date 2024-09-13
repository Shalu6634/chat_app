import 'package:chat_app/modal/cloud_modal.dart';
import 'package:chat_app/services/auth_services/auth_service.dart';
import 'package:chat_app/services/cloud_firestore_services.dart';
import 'package:chat_app/services/google/google_auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
          actions: [
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
                  icon: const Icon(Icons.logout)),
            ),
          ],
        ),
        drawer: Drawer(
          child: FutureBuilder(
            future: CloudFireStoreServices.cloudFireStoreServices
                .readCurrentUserData(),
            builder: (context, snapshot) {
              var data = snapshot.data!.data();
              UserModal userModal = UserModal.fromMap(data!);
              if (snapshot.hasData) {
                return Column(
                  children: [Text(userModal.name!), Text(userModal.email!)],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        body: FutureBuilder(
          future:
              CloudFireStoreServices.cloudFireStoreServices.readAllUserData(),
          builder: (context, snapshot) {
            List<QuerySnapshot<Map<String, dynamic>>> dataList = snapshot.data!;
            List<UserModal> userList = [];
            for(var users in dataList)
              {
                userList.add(UserModal.fromMap(users[0]));
              }



            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  Text(userList.length.toString());
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}
