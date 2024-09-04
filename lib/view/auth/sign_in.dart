import 'package:chat_app/services/auth_services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign - in'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: authController.txtEmail,
            decoration: const InputDecoration(
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: authController.txtPassword,
            decoration: const InputDecoration(
                labelText: 'Password',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder()),
          ),
          TextButton(
              onPressed: () {
                Get.toNamed('/signup');
              },
              child: const Text('Don`t have account?Sign Up')),
          ElevatedButton(
            onPressed: () async {
             String response = await  AuthService.authService.signInWithEmailAndPassword(authController.txtEmail.text, authController.txtPassword.text);

              User? user = AuthService.authService.getCurrentUser();
              if(user!=null&&response=='success')
                {
                       Get.offAndToNamed('/home');
                }
              else
                {
                  Get.snackbar('Sign in failed', response);
                }
            },
            child: const Text('Sign-in'),
          ),
        ],
      ),
    );
  }
}
