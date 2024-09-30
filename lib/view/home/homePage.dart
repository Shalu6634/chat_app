
import 'package:animated_botton_navigation/animated_botton_navigation.dart';
import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/controller/themeModeChange.dart';
import 'package:chat_app/modal/cloud_modal.dart';
import 'package:chat_app/services/auth_services/auth_service.dart';
import 'package:chat_app/services/cloud_firestore_services.dart';
import 'package:chat_app/services/google/google_auth_services.dart';
import 'package:chat_app/services/notification/local_notification_services.dart';
import 'package:chat_app/view/chatPage/chatPage.dart';
import 'package:chat_app/view/home/Profile.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


ThemeModeController controller   = Get.put(ThemeModeController());
class HomePage extends StatelessWidget {
   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //---------------bottomSheet----------------------

    final List<Widget> _pages = [
     const  Center(child: Text('Home ', style: TextStyle(color: Colors.white),),),
     const  Center(child: Text('Udates ', style: TextStyle(color: Colors.white),),),
      const Center(child: Text('Communities ', style: TextStyle(color: Colors.white),),),
      const Center(child: Text('Calls ', style: TextStyle(color: Colors.white),),),
     const  Center(child: Text('Profile ', style: TextStyle(color: Colors.white),),),

    ];
    //bottom------------
    var chatController = Get.put(ChatController());
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
  backgroundColor: Colors.white,
      appBar: AppBar(

        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'ChatApp',
            style: TextStyle(color: Color(0xff00a985), fontSize: 27,fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
                onTap: () async {
                  await LocalNotificationServices.notificationServices
                      .showScheduleNotification();
                },
                child: const Icon(
                  Icons.notification_add_outlined,

                )),
          ),
          GestureDetector(
              onTap: () async {
                await LocalNotificationServices.notificationServices
                    .showPeriodicNotification();
              },
              child:
              const Icon(Icons.add_comment_outlined)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
                onPressed: () {
                  AuthService.authService.signOutUser();
                  GoogleAuthService.googleAuthService.googleSignOut();
                  //user null
                  User? user = AuthService.authService.getCurrentUser();
                  if (user == null) {
                    Get.offAndToNamed('/signIn');
                  }
                },
                icon: const Icon(Icons.logout)),
          ),
        ],
        bottom: PreferredSize(

          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              margin: EdgeInsets.only(right: 12, left: 12),
              height: height * 0.065,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    const Text(
                      'Search ',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(
                      width: width * 0.5,
                    ),
                    const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    VerticalDivider(
                      thickness: 1.5,
                      color: Colors.grey.shade400,
                      endIndent: 5,
                      indent: 5,
                    ),
                    Icon(
                      Icons.mic,
                      color: Color(0xff1f6563),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      body: FutureBuilder(
        future: CloudFireStoreServices.cloudFireStoreServices.readAllUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List dataList = snapshot.data!.docs;
          List<UserModal> userList = [];
          for (var users in dataList) {
            userList.add(UserModal.fromMap(users.data()!));
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) =>
                  Column(
                    children: [
                      ListTile(
                        onTap: () {
                          chatController.getReceiver(userList[index].name!,
                              userList[index].email!, userList[index].image!);
                          Get.toNamed('/chat');
                        },
                        leading: Container(
                          decoration: BoxDecoration(

                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black,blurRadius: 1)
                            ]
                          ),
                          child: CircleAvatar(
                            radius: 27,
                            backgroundImage: NetworkImage("${userList[index].image}"),
                          ),
                        ),
                        title: Text(
                          userList[index].name.toString(),
                          style: TextStyle(

                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        subtitle: Text(
                          userList[index].email.toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 13,fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        endIndent: 20,
                        indent: 80,
                      ),
                    ],
                  ),
            );
          }

          return Center(
            child: Text(snapshot.error.toString()),
          );
        },
      ),

      bottomNavigationBar: AnimatedBottomNavigation(

        selectedColor: chatController.changeColor(),
        unselectedColor: Colors.black,
        height: 50,
        backgroundColor: Colors.white,

        indicatorSpaceBotton: 20,
        icons: const [
          Icons.home,
          Icons.update,
          Icons.group,
          Icons.call_rounded,
          Icons.person,
        ],
        currentIndex: currentIndexValue,
        onTapChange: (index) {
          chatController.indexChange(index);
          if(index == 0)
            {
              Get.to( HomePage());
            }
          else if(index==1)
          {
            Get.to( HomePage());
          }
          else if(index==2)
          {
            Get.to( HomePage());
          }
          else if(index==3)
          {
            Get.to( HomePage());
          }
          else if(index==4)
            {
              Get.to(const ProfilePage());
            }
          print(index);
        },
      ),
    );
  }
}
