import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/database.dart';
import '../../model/user.dart';
import '../../services/auth.dart';
import '../../screens/home/settings_form.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final AuthService _auth = AuthService();
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  void _showSettingsPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 60.0,
            ),
            child: SettingsForm(),
          );
        });
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
          Text(
            fname,
            style: TextStyle(fontSize: 22),
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
                    color: Theme.of(context).accentColor,
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
