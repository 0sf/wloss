import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationSettings extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NotificationSettings({this.flutterLocalNotificationsPlugin});
  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  showNotification() async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await widget.flutterLocalNotificationsPlugin.show(
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo ');
    await widget.flutterLocalNotificationsPlugin.show(
        1, 'Flutter devs2', 'Flutter Local Notification Demo2', platform,
        payload: 'Welcome to the Local Notification demo2 ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Container(
        child: Column(
          children: [
            RaisedButton(
              onPressed: showNotification,
              child: new Text(
                'showNotification',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
