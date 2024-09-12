import 'package:flutter/material.dart';

class SelectedPage extends StatelessWidget {
  const SelectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      body:
        Container(
          width: 360,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFFEEFAFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: 76,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Welcome to Chat Pulse!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontSize: 16,
                          fontFamily: 'Kaisei Decol',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Easily add your streams and start following right away',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF266563),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 320,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                decoration: ShapeDecoration(
                  color: Color(0xFF1F6563),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 320,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 15),
                decoration: ShapeDecoration(
                  color: Color(0xFF1F6563),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Signup',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    // fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
        )

    );
  }
}
