import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../screens/meal_mng/meal_mng.dart';
import './main_drawer.dart';
import '../../screens/home/temp.dart';
import '../../model/meal.dart';
import '../../services/database.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);

    return StreamProvider<List<Meal>>.value(
      value: DatabaseService(uid: user.uid).meals,
      child: Scaffold(
        drawer: MainDrawer(),
        backgroundColor: Colors.brown.shade50,
        appBar: AppBar(
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
}
