
import 'package:chat_app/services/messeging/firebase_messeging_service.dart';
import 'package:chat_app/services/notification/local_notification_services.dart';
import 'package:chat_app/view/SplashScreen.dart';
import 'package:chat_app/view/auth/auth_manager.dart';

import 'package:chat_app/view/chatPage/chatPage.dart';
import 'package:chat_app/view/auth/sign_up.dart';
import 'package:chat_app/view/auth/sign_in.dart';
import 'package:chat_app/view/home/homePage.dart';
import 'package:chat_app/view/secondPage/selectPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
 await  LocalNotificationServices.notificationServices.initNotificationServices();
 await FirebaseMessagingService.fm.requestPermission();
 await FirebaseMessagingService.fm.getDeviceToken();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: [
        // GetPage(name: '/', page:() => const Splashscreen(),),
        // GetPage(name: '/', page:() => const SelectedPage(),),
        GetPage(name: '/auth', page:() => const AuthManager(),),
        GetPage(name: '/', page:() => const SignIn(),),
        GetPage(name: '/signUp', page:() => const SignUp(),),
        GetPage(name: '/home', page:() => HomePage(),),
        GetPage(name: '/chat', page:() => const ChatPage(),),

      ],
    );
  }
}
