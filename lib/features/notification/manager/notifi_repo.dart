import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationRepo {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isTimezoneInitialized = false; // To ensure it's initialized once

  Future<void> init() async {
    if (!_isTimezoneInitialized) {
      tz.initializeTimeZones(); // Initialize timezone database
      tz.setLocalLocation(tz.getLocation(
          'Africa/Cairo')); // Set local timezone, replace with your own if needed
      _isTimezoneInitialized = true;
    }

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onReceiveNotification,
    );
  }

  void onReceiveNotification(NotificationResponse notificationResponse) {
    // Handle notification when clicked
  }

  Future<void> showInstantNotification(
      int id, String title, String body) async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        "0",
        "Instant Notification",
        importance: Importance.max,
        priority: Priority.high,
        icon: "@mipmap/ic_launcher",
      ),
    );
    await flutterLocalNotificationPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  Future<void> showScheduledNotification(
      int id, String title, String body, DateTime scheduledDate) async {
    // Convert scheduledDate to a tz.TZDateTime
    tz.TZDateTime localScheduledDateTime =
        tz.TZDateTime.from(scheduledDate, tz.local);

    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        "1",
        "Scheduled Notification",
        importance: Importance.max,
        priority: Priority.high,
        icon: "@mipmap/ic_launcher",
      ),
    );

    await flutterLocalNotificationPlugin.zonedSchedule(
      id,
      title,
      body,
      localScheduledDateTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await flutterLocalNotificationPlugin.pendingNotificationRequests();
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationPlugin.cancelAll();
  }
}
