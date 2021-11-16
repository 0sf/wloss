// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../screens/home/settings_page.dart';
import '../../screens/home/notification_settings.dart';
import '../../screens/home/feedback.dart';
import '../../services/database.dart';
import '../../model/user.dart';
import '../../services/auth.dart';

class MainDrawer extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MainDrawer({this.flutterLocalNotificationsPlugin});
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final AuthService _auth = AuthService();
  bool loading = false;

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: tapHandler,
    );
  }

  void _showSettingsPanel() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsPage()));
  }

  void _showFeedback() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FeedBack()));
  }

  void _showNotificationSettings() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotificationSettings(
                  flutterLocalNotificationsPlugin:
                      widget.flutterLocalNotificationsPlugin,
                ))); //NotificationSettings()
  }

  Widget userDetails({
    String fname,
    double height,
    double weight,
    double activityFactor,
    String gender,
    int age,
  }) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 28,
            child: Icon(
              Icons.person,
              size: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            fname,
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Gender: ' + gender),
              SizedBox(height: 10),
              Text('Age: ' + age.toString()),
              SizedBox(height: 10),
              Text("Height: " + height.toString()),
              SizedBox(height: 10),
              Text("Weight: " + weight.toString()),
              SizedBox(height: 10),
              Text("AFactor: " + activityFactor.toString()),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Drawer(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'WLoss',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  userDetails(
                    fname: userData.firstName,
                    age: userData.age,
                    height: userData.height,
                    weight: userData.weight,
                    activityFactor: userData.activityFactor,
                    gender: userData.gender,
                  ),
                  buildListTile(
                    'Edit',
                    Icons.settings,
                    _showSettingsPanel,
                  ),
                  buildListTile(
                    'Notifications',
                    Icons.notifications,
                    _showNotificationSettings,
                  ),
                  buildListTile(
                    'Feedback',
                    Icons.feedback,
                    _showFeedback,
                  ),
                  buildListTile(
                    'Logout',
                    Icons.person,
                    () async {
                      await _auth.signOut();
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
