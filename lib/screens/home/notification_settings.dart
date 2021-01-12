import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:wloss/model/time_zone.dart';

class NotificationSettings extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NotificationSettings({this.flutterLocalNotificationsPlugin});
  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  void intitState() {
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  bool _notificationState = false;

  // tz.TZDateTime schduleDate = new tz.TZDateTime(location, year);
  showNotification() async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await widget.flutterLocalNotificationsPlugin.show(
        0, 'Wloss App', 'It\'s meal time', platform,
        payload: 'Welcome to the Local Notification demo ');
  }

  Future<void> showNotificationPeriod() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('repeating channel id',
            'repeating channel name', 'repeating description');
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await widget.flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'repeating title',
      'repeating body',
      RepeatInterval.daily,
      platformChannelSpecifics,
    );
  }

  Future<void> zonedSchedule(
    int id,
  ) async {
    String title = "wlossApp";
    String body = "Schedule Is working!";
    // SetTimeZone
    final timeZone = TimeZone();

    // The device's timezone.
    String timeZoneName = await timeZone.getTimeZoneName();

    // Find the 'current location'
    final location = await timeZone.getLocation(timeZoneName);

    //Set a date
    var dateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 17, 38, 0);

    final scheduledDate = tz.TZDateTime.from(dateTime, location);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('repeating channel id',
            'repeating channel name', 'repeating description');
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await widget.flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
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
            SwitchListTile(
              title: const Text('Notification'),
              value: _notificationState,
              onChanged: (bool value) {
                setState(() {
                  _notificationState = value;
                });
              },
              secondary: const Icon(Icons.notifications_none_outlined),
            ),
            RaisedButton(
              onPressed: showNotification,
              child: new Text(
                'Save',
              ),
            ),
            RaisedButton(
              onPressed: () => {
                zonedSchedule(
                  1,
                )
              },
              child: new Text(
                'Schedule',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
