import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rasidtasks/features/notification/manager/cubit/notificatoin_state.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;



class NotificationCubit extends Cubit<NotificationState> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isTimezoneInitialized = false;

  NotificationCubit()
      : super(NotificationState(
            pendingNotifications: [], isLoading: false, errorMessage: ''));

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));

    try {
      if (!_isTimezoneInitialized) {
        tz.initializeTimeZones();
        tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
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

      loadPendingNotifications();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to initialize: ${e.toString()}'));
    }
  }

  void onReceiveNotification(NotificationResponse notificationResponse) {
    
  }

  Future<void> showInstantNotification(String title, String body) async {
    emit(state.copyWith(isLoading: true));

    try {
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
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title,
        body,
        notificationDetails,
      );

      loadPendingNotifications();
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to send notification: ${e.toString()}'));
    }

    emit(state.copyWith(isLoading: false));
  }

  Future<void> showScheduledNotification(
      String title, String body, DateTime scheduledDate) async {
    emit(state.copyWith(isLoading: true));

    try {
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
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title,
        body,
        localScheduledDateTime,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

      loadPendingNotifications();
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to schedule notification: ${e.toString()}'));
    }

    emit(state.copyWith(isLoading: false));
  }

  Future<void> loadPendingNotifications() async {
    emit(state.copyWith(isLoading: true));
    try {
      final pending = await flutterLocalNotificationPlugin.pendingNotificationRequests();
      emit(state.copyWith(pendingNotifications: pending));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to load notifications: ${e.toString()}'));
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> cancelNotification(int id) async {
    try {
      await flutterLocalNotificationPlugin.cancel(id);
      loadPendingNotifications();
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to cancel notification: ${e.toString()}'));
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      await flutterLocalNotificationPlugin.cancelAll();
      loadPendingNotifications();
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to cancel all notifications: ${e.toString()}'));
    }
  }
}
