import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../model/user.dart';
import '../../screens/meal_mng/meal_mng.dart';
import './main_drawer.dart';
import '../../screens/home/temp.dart';
import '../../model/meal.dart';
import '../../services/database.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = AndroidInitializationSettings('wloss');
    var initSetttings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return NewScreen(
        payload: payload,
      );
    }));
  }

  void _showNotification() {
    print("pressed");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);

    return StreamProvider<List<Meal>>.value(
      value: DatabaseService(uid: user.uid).meals,
      child: Scaffold(
        drawer: MainDrawer(
          flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        ),
        backgroundColor: Colors.brown.shade50,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () => _showNotification())
          ],
          title: Text('WLoss'),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
        ),
        body: Temp(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.fastfood),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MealDashboard()));
            }),
      ),
    );
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var platform = new NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
        0, 'Wloss', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo ');
  }
}

class NewScreen extends StatelessWidget {
  final String payload;

  NewScreen({
    @required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload),
      ),
    );
  }
}
