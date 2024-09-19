
import 'package:chat_app/services/google/google_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

      body:
      Container(
        height: height*1,
        width: width*1,
        decoration: const BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover,image: AssetImage("assets/img/bg.jpeg"))
        ),
        child:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              const Align(
                  alignment: Alignment.center,
                  child: Expanded(
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                height: height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: authController.txtEmail,
                  decoration: const InputDecoration(
                      label: Text('Email'),
                      hintText: 'abc@gmail.com',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff1f6563)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1f6563)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: authController.txtPassword,
                  decoration: const InputDecoration(
                      label: Text('Password'),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff1f6563)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1f6563)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(alignment: Alignment.centerRight,child: Text("Forgot password?",style: TextStyle(color: Colors.grey),)),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              SizedBox(
                  width: width * 0.9,
                  height: height*0.060,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1f6563),
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
                        GoogleAuthService.googleAuthService.signInWithGoogle();
                        Get.offAndToNamed('/home');
                      } else {
                        Get.snackbar('Sign in failed', response);
                      }

                    },
                    child: const Text('Sign In',style: TextStyle(color: Colors.white),),
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
                      child: const Text('Dont have account?Sign Up',style: TextStyle(color: Colors.grey),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
