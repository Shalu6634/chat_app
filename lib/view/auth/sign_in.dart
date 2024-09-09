
import 'package:chat_app/services/google/google_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';


import 'package:chat_app/controller/auth_controller.dart';
import '../../services/auth_services/auth_service.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var authController = Get.put(Authcontroller());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Lets Get Start!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: height * 0.1,
              ),
              TextField(
                controller: authController.txtEmail,
                decoration: const InputDecoration(
                    label: Text('Email'),
                    hintText: 'abc@gmail.com',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ))),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextField(
                  controller: authController.txtPassword,
                  decoration: const InputDecoration(
                      label: Text('Password'),
                      hintText: '123455',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ))),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              SizedBox(
                  width: width * 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () async {
                      String response = await AuthService.authService
                          .signInWithEmailAndPassword(
                              authController.txtEmail.text,
                              authController.txtPassword.text);
                      //
                      User? user = AuthService.authService.getCurrentUser();
                      if (user != null && response == 'success') {
                        Get.offAndToNamed('/home');
                      } else {
                        Get.snackbar('Sign in failed', response);
                      }
                    },
                    child: const Text('Sign In'),
                  )),
              SignInButton(Buttons.google, onPressed: (){
                GoogleAuthService.googleAuthService.signInWithGoogle();
                User? user = AuthService.authService.getCurrentUser();
                if (user != null) {
                  Get.offAndToNamed('/home');
                }
              }),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed('/signUp');
                      },
                      child: const Text('Dont have account?Sign Up')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
