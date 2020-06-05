import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wloss/screens/meal_mng/meal_mng.dart';

import '../../screens/home/settings_form.dart';
import '../../screens/home/temp.dart';
import '../../model/meal.dart';
import '../../services/database.dart';
import '../../services/auth.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
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

    return StreamProvider<List<Meal>>.value(
      value: DatabaseService().meals,
      child: Scaffold(
        backgroundColor: Colors.brown.shade50,
        appBar: AppBar(
          title: Text('WLoss'),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            )
          ],
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
}
