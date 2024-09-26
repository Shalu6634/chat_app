import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedPage extends StatelessWidget {
  const SelectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          height: height * 1,
          width: width * 1,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/img/bg.jpeg"),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: height * 0.5,
                  width: width * 0.80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/img/vector1.png"))),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/signIn');
                },
                child: Container(
                  height: height * 0.070,
                  width: width * 0.7,
                  decoration: BoxDecoration(
                    color: Color(0xff1f6563),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xff374751)),
                  ),
                  child: const Center(
                      child: Text(
                    'SIGN-IN',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ),
              ),
              SizedBox(height: height * 0.040),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/signUp');
                },
                child: Container(
                  height: height * 0.070,
                  width: width * 0.7,
                  decoration: BoxDecoration(
                      color: Color(0xff1f6563),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xff374751))),
                  child: const Center(
                      child: Text(
                    'SIGN-UP',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ),
              ),
            ],
          )),
    );
  }
}
