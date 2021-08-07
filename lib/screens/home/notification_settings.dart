import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:wloss/model/time_zone.dart';
import '../../data/notification_detail.dart';

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

  //bool _notificationState = false;

  cancelAllNotifications() async {
    await widget.flutterLocalNotificationsPlugin.cancelAll();
  }

  showSchdNotifications() async {
    final List<ActiveNotification> activeNotifications = await widget
        .flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();

    print(activeNotifications.map((e) =>
        print(e.id.toString() + e.body.toString() + e.title.toString())));
  }

  showAllNotifcations() async {
    var notify = await widget.flutterLocalNotificationsPlugin
        .pendingNotificationRequests();
    notify.map(
        (e) => print(e.id.toString() + e.body.toString() + e.title.toString()));
  }

  // tz.TZDateTime schduleDate = new tz.TZDateTime(location, year);
  // showNotification() async {
  //   var android = new AndroidNotificationDetails(
  //       'id', 'channel ', 'description',
  //       priority: Priority.high, importance: Importance.max);
  //   var iOS = new IOSNotificationDetails();
  //   var platform = new NotificationDetails(android: android, iOS: iOS);
  //   await widget.flutterLocalNotificationsPlugin.show(
  //       0, 'Wloss App', 'It\'s meal time', platform,
  //       payload: 'Welcome to the Local Notification demo ');
  // }

  // Future<void> showNotificationPeriod() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails('repeating channel id',
  //           'repeating channel name', 'repeating description');
  //   const iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);
  //   await widget.flutterLocalNotificationsPlugin.periodicallyShow(
  //     0,
  //     'repeating title',
  //     'repeating body',
  //     RepeatInterval.daily,
  //     platformChannelSpecifics,
  //   );
  // }

  Future<void> zonedSchedule() async {
    // SetTimeZone
    final timeZone = TimeZone();

    // The device's timezone.
    String timeZoneName = await timeZone.getTimeZoneName();

    // Find the 'current location'
    final location = await timeZone.getLocation(timeZoneName);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('repeating channel id',
            'repeating channel name', 'repeating description');
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var id = 0;
    for (var i = 1; i < 8; i++) {
      for (var j = 0; j < 3; j++) {
        var dateTime = DateTime(
            dayAndTime[j].year,
            dayAndTime[j].month,
            dayAndTime[j].day + i,
            dayAndTime[j].hour,
            dayAndTime[j].minute,
            dayAndTime[j].second);

        print(dateTime.year.toString() +
            " " +
            dateTime.month.toString() +
            " " +
            dateTime.day.toString() +
            " " +
            dateTime.hour.toString() +
            " " +
            dateTime.minute.toString() +
            " " +
            dateTime.second.toString());

        final scheduledDate = tz.TZDateTime.from(dateTime, location);

        await widget.flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          titles[j],
          body[j],
          scheduledDate,
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
        );
        id++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Builder(
        builder: (context) => Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SwitchListTile(
              //   title: const Text('Notification'),
              //   value: _notificationState,
              //   onChanged: (bool value) {
              //     setState(() {
              //       _notificationState = value;
              //     });
              //   },
              //   secondary: const Icon(Icons.notifications_none_outlined),
              // ),
              ElevatedButton(
                onPressed: () {
                  zonedSchedule();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Notifications enabled from tomorrow onwards!'),
                    ),
                  );
                },
                child: new Text(
                  'Schedule',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  cancelAllNotifications();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notifications Disabled!'),
                    ),
                  );
                },
                child: new Text(
                  'Cancel All',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showAllNotifcations();
                  showSchdNotifications();
                },
                child: new Text(
                  'Get List',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
