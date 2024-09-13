import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/modal/cloud_modal.dart';
import 'package:chat_app/services/cloud_firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
          decoration: BoxDecoration(
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
                padding: EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.grey),
                    )),
              ),
              SizedBox(
                height: height * 0.02,
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
                          image: "https://media.istockphoto.com/id/1451587807/vector/user-profile-icon-vector-avatar-or-person-icon-profile-picture-portrait-symbol-vector.jpg?s=612x612&w=0&k=20&c=yDJ4ITX1cHMh25Lt1vI1zBn2cAKKAlByHBvPJ8gEiIg=");
        
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed('/');
                      },
                      child: const Text('Already have account? Sign In',style: TextStyle(color: Colors.grey),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
