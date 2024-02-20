import 'package:flutter_local_notifications/flutter_local_notifications.dart';
 
class ShowNotification  {
 
  showNotification(String message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
 
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/eranou_dark');
 
/*     const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    ); */
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
     // iOS: initializationSettingsIOS,
    );
 
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
 
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high channel',
      'Very important notification!!',
      description: 'the first notification',
      importance: Importance.max,
    );
 
    await flutterLocalNotificationsPlugin.show(
      1,
      'Nouveau Message',
      message,
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description),
      ),
    );
  }
}