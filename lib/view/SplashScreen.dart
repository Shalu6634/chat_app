import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height  = MediaQuery.of(context).size.height;
    double width  = MediaQuery.of(context).size.width;
    Timer(Duration(seconds: 5),  () {
      Get.toNamed("/select");
    },);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: height*0.3,
              width: width*0.5,
              decoration: const BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img/chat.png'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
