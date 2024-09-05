
// import 'package:chat_app/services/auth_services/auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../Controller/auth_controller.dart';
import '../../services/auth_services/auth_service.dart';

// import '../../controlle/r/auth_controller.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(onTap: (){
          Get.back();
        },child: Icon(Icons.arrow_back,color: Colors.white,size: 25,)),
        title: const Text(
          'Sign Up',
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
                    'Register your   \n  account',
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
                  onPressed: ()  async {
                   await AuthService.authService.createAccountWithEmailAndPassword(authController.txtEmail.text, authController.txtPassword.text);

                    Get.back();
                    authController.txtEmail.clear();
                    authController.txtPassword.clear();
                      },

                  child: Text('Sign Up'),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed('/');
                      },
                      child: const Text('Already have account? Sign In')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}