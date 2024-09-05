// import 'package:chat_app/services/auth_services/auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

// import '../../controlle/r/auth_controller.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // var authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
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
                    'Welcome Back',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: height * 0.1,
              ),
              const TextField(
                // controller: authController.txtEmail,
                decoration: InputDecoration(
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
          
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextField(
                  // controller: authController.txtPassword,
                  decoration: InputDecoration(
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
                  onPressed: () {},
                  child: Text('Sign Up'),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     // String response = await  AuthService.authService.signInWithEmailAndPassword(authController.txtEmail.text, authController.txtPassword.text);
              //     //
              //     // User? user = AuthService.authService.getCurrentUser();
              //     // if(user!=null&&response=='success')
              //     // {
              //     //   Get.offAndToNamed('/home');
              //     // }
              //     // else
              //     // {
              //     //   Get.snackbar('Sign in failed', response);
              //     // }
              //   },
              //   child: const Text('Sign-in'),
              // ),
          
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






















// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../controller/auth_controller.dart';
// import '../../services/auth_services/auth_service.dart';

// class SignUp extends StatelessWidget {
//   const SignUp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var authController = Get.put(AuthController());
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const TextField(
//             decoration: InputDecoration(
//                 labelText: 'Email',
//                 enabledBorder: OutlineInputBorder(),
//                 focusedBorder: OutlineInputBorder()),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           const TextField(
//             decoration: InputDecoration(
//                 labelText: 'Password',
//                 enabledBorder: OutlineInputBorder(),
//                 focusedBorder: OutlineInputBorder()),
//           ),
//           TextButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: const Text('Already have account?Sign In')),
//           ElevatedButton(
//             onPressed: () {
//               AuthService.authService.createAccountWithEmailAndPassword(
//                   authController.txtEmail.text,
//                   authController.txtPassword.text);
//             },
//             child: const Text('Sign In'),
//           ),
//         ],
//       ),
//     );
//   }
// }
