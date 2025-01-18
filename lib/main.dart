import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'screens/joke_types_screen.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setupNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await notificationsPlugin.initialize(initializationSettings);

  await notificationsPlugin.zonedSchedule(
    0,
    'Joke of the Day',
    'Check out today\'s joke!',
    _nextInstanceOf10AM(),
    NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_notification_channel',
        'Daily Notifications',
        channelDescription: 'Notification channel for daily joke reminders',
      ),
    ),
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

tz.TZDateTime _nextInstanceOf10AM() {
  final now = tz.TZDateTime.now(tz.getLocation('UTC'));
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.getLocation('UTC'), now.year, now.month, now.day, 10);
  
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

void main() async {
  void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
  
  tz.initializeTimeZones();
  await setupNotifications();

  runApp(const MyApp());
}
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const JokeTypesScreen(),
    );
  }
}