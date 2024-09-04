import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../services/auth_services/auth_service.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            decoration: InputDecoration(
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          const TextField(
            decoration: InputDecoration(
                labelText: 'Password',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder()),
          ),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Already have account?Sign In')),
          ElevatedButton(
            onPressed: () {
              AuthService.authService.createAccountWithEmailAndPassword(
                  authController.txtEmail.text,
                  authController.txtPassword.text);
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
