import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wloss/widgets/meal/new_meal.dart';
import '../../services/database.dart';
import '../../model/meal.dart';
import '../../widgets/meal/meal_list.dart';

class MealDashboard extends StatefulWidget {
  static const routeName = '/meal-dash';
  @override
  _MealDashboardState createState() => _MealDashboardState();
}

class _MealDashboardState extends State<MealDashboard> {
  void _startAddNewMealItem(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewMealItem(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Meal>>.value(
      value: DatabaseService().meals,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Pick your meal'),
            elevation: 0.0,
          ),
          body: MealList(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startAddNewMealItem(context),
          )),
    );
  }
}
