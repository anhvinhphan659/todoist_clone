import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandle {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  static Future init({bool initSchedule = true}) async {
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = const DarwinInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(settings,
        onDidReceiveBackgroundNotificationResponse: (payload) async {});
  }

  static Future showNotification({
    int id = 0,
    String title = "",
    String body = "",
    String payload = "",
  }) async {
    _notifications.show(id, title, body, await notificationDetails(),
        payload: payload);
  }
}
