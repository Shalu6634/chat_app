import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationServices {
  LocalNotificationServices._();

  static LocalNotificationServices notificationServices =
      LocalNotificationServices._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails("chat app", "Local Notification",
          importance: Importance.max, priority: Priority.max);

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

  Future<void> showNotification(String title, String body) async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await plugin.show(0, title, body, notificationDetails);
  }

  //scheduledNotification
  Future<void> showScheduleNotification() async {
    tz.Location location = tz.getLocation('Asia/Kolkata');

    await plugin.zonedSchedule(
        1,
        'Big offer',
        'New Feature',
        tz.TZDateTime.now(location).add(const Duration(seconds: 4)),
        NotificationDetails(android: androidNotificationDetails),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  //periodic Notification

  Future<void> showPeriodicNotification() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails("chat app", "Local Notification",
            importance: Importance.max, priority: Priority.max);
     NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await plugin.periodicallyShow(
        0,
        "Periodic Notification",
        "This notification repeat periodically",
        RepeatInterval.everyMinute,
        platformChannelSpecifics);
  }
}
