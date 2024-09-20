import 'package:flutter/material.dart';

class SelectedPage extends StatelessWidget {
  const SelectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
                children: [
          Container(
            height: height * 1,
            width: width * 1,
            decoration: BoxDecoration(

                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage("assets/img/bg.jpeg"))),
            child: Stack(
              children: [
                Container(
                  height: height * 0.4,
                  width: width * 0.7,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/img/vector.jpeg"))),
                ),
              ],
            ),
          ),
          TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder()
            ),
          ),
                ],
              ),
        ));
  }
}
