import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/modal/cloud_modal.dart';
import 'package:chat_app/services/cloud_firestore_services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../services/auth_services/auth_service.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var authController = Get.put(Authcontroller());
    return Scaffold(
      body: SingleChildScrollView(

        child: Container(
          height: height * 1,
          width: width * 1,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/img/bg.jpeg"))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Sign Up',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: height * 0.040,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  cursorColor: Color(0xff1f6563),
                  controller: authController.txtName,
                  decoration: const InputDecoration(
                      label: Text('Name'),
                      hintText: 'xyz',
                      hoverColor: Color(0xff1f6563),
                      labelStyle: TextStyle(color: Color(0xff1f6563)),
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
                  cursorColor: Color(0xff1f6563),
                  controller: authController.txtPhone,
                  decoration: const InputDecoration(
                      label: Text('Phone'),
                      hintText: '+91',
                      labelStyle: TextStyle(color: Color(0xff1f6563)),
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
                  cursorColor: Color(0xff1f6563),
                  controller: authController.txtEmail,
                  decoration: const InputDecoration(
                      label: Text('Email'),
                      labelStyle: TextStyle(color: Color(0xff1f6563)),
                      hintText: 'abc@gmail.com',
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
                  cursorColor: Color(0xff1f6563),
                  controller: authController.txtPassword,
                  decoration: const InputDecoration(
                      label: Text('Password'),
                      labelStyle: TextStyle(color: Color(0xff1f6563)),
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
                  cursorColor: Color(0xff1f6563),
                  controller: authController.txtConfirmPassword,
                  decoration: const InputDecoration(
                      label: Text('Confirm Password'),
                    labelStyle: TextStyle(color: Color(0xff1f6563)),
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
                          ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding:  EdgeInsets.only(right: 25),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.grey),
                    )),
              ),
              SizedBox(
                height: height * 0.010,
              ),
              SizedBox(
                width: width * 0.9,
                height: height*0.060,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:Color(0xff1f6563),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () async {
                    if (authController.txtPassword.text ==
                        authController.txtConfirmPassword.text) {
                      await AuthService.authService
                          .createAccountWithEmailAndPassword(
                              authController.txtEmail.text,
                              authController.txtPassword.text);
        
                      UserModal user = UserModal(
                          name: authController.txtName.text,
                          email: authController.txtEmail.text,
                          phone: authController.txtPhone.text,
                          token: "--",
                          image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.facebook.com%2Fpermalink.php%2F%3Fstory_fbid%3D726656556228851%26id%3D100066535393876&psig=AOvVaw0OZQxE8urvDX0f3Ko_BEUN&ust=1727058131648000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCKCytIy_1YgDFQAAAAAdAAAAABAq');
        
                      CloudFireStoreServices.cloudFireStoreServices
                          .insertUserIntoFireStore(user);
                      Get.back();
                      authController.txtEmail.clear();
                      authController.txtPassword.clear();
                      authController.txtPhone.clear();
                      authController.txtConfirmPassword.clear();
                      authController.txtName.clear();
                    }
                  },
                  child: const Text('Sign Up',style: TextStyle(color: Colors.white),),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Get.toNamed('/');
                    },

                    child: const Text('Already have account? Sign In',style: TextStyle(color: Colors.grey),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
