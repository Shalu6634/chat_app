import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  LocalNotificationServices._();

  static LocalNotificationServices notificationServices =
      LocalNotificationServices._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotificationServices() async {
    plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    AndroidInitializationSettings android =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    DarwinInitializationSettings iOS = const DarwinInitializationSettings();
    InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await plugin.initialize(settings);
  }

  //show notification

  Future<void> showNotification(String title,String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "chat app",
      "Local Notification",
          importance: Importance.max,
          priority: Priority.max
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails
    );
    await plugin.show(0, title, body, notificationDetails);
  }
}
