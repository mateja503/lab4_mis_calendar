import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // Android-specific initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('flutter_logo');

    // iOS-specific initialization
    final DarwinInitializationSettings initializationSettingsIOS =
    const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Combine Android and iOS settings
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Initialize the plugin
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification responses
        if (response.payload != null) {
          print("Notification Payload: ${response.payload}");
        }
      },
    );
  }

  // Notification details for Android and iOS
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId', // ID of the notification channel
        'channelName', // Name of the notification channel
        channelDescription: 'This channel is used for exam notifications.',
        importance: Importance.max,
        priority: Priority.high,
        icon: 'flutter_logo', // Replace with your app's launcher icon
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  // Method to show a notification
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload,
    );
  }
}
