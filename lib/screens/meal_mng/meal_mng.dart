import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../screens/meal_mng/search.dart';
import '../../model/user.dart';
import '../../services/database.dart';
import '../../model/meal.dart';
import '../../widgets/meal/meal_list.dart';

class MealDashboard extends StatefulWidget {
  static const routeName = '/meal-dash';
  @override
  _MealDashboardState createState() => _MealDashboardState();
}

class _MealDashboardState extends State<MealDashboard> {
  bool loading = true;
  DateTime cDate = DateTime.now();

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        cDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<Meal>>.value(
      value: DatabaseService(uid: user.uid).meals,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Pick your meal'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _presentDatePicker())
            ],
            elevation: 0.0,
          ),
          body: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  height: 30,
                  width: 300,
                  color: Colors.blue,
                  child: Text(
                    "Date: " + DateFormat('dd-MM-yyyy').format(cDate),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(child: Container(child: MealList(cDate))),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchAdd()));
              })),
    );
  }
}
