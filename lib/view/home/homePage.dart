import 'package:chat_app/services/auth_services/auth_service.dart';
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
            child: IconButton(onPressed: (){
              AuthService.authService.signOutUser();
              //user null
              User? user = AuthService.authService.getCurrentUser();
              if(user==null)
              {
                Get.offAndToNamed('/signIn');
              }

            }, icon: const Icon(Icons.logout)),
          ),
        ],
      ),
      body: Center(
        child: Text('----------Welcome-----------',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)
      ),
    );
  }
}
