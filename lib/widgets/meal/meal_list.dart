import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../services/database.dart';
import '../../model/meal.dart';
import './meal_tile.dart';

class MealList extends StatefulWidget {
  final DateTime date;
  MealList(this.date);

  @override
  _MealListState createState() => _MealListState();
}

class _MealListState extends State<MealList> {
  List<Meal> mealList = [];

  bool isDate(DateTime date, Meal meals) {
    if (date.day == meals.foodId.day &&
        date.month == meals.foodId.month &&
        date.year == meals.foodId.year) {
      return true;
    }

    return false;
  }

  void _addToList(List<Meal> meals, DateTime date) {
    var i = 0;
    for (var meal in meals) {
      if (date.day == meal.foodId.day &&
          date.month == meal.foodId.month &&
          date.year == meal.foodId.year) {
        mealList[i] = meal;
        i++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    // final meals = Provider.of<List<Meal>>(context) ?? [];

    void _deleteMeal(String docId) {
      DatabaseService(uid: user.uid).deleteMeal(docId);
    }

    // return ListView.builder(
    //     itemCount: meals.length,
    //     itemBuilder: (context, index) {
    //       return MealTile(
    //         meal: meals[index],
    //         deleteFn: _deleteMeal,
    //       );
    //     });

    // ListView.builder(
    //     itemCount: meals.length,
    //     shrinkWrap: true,
    //     itemBuilder: (context, index) {
    //       return isDate(widget.date, meals[index])
    //           ? MealTile(
    //               meal: meals[index],
    //               deleteFn: _deleteMeal,
    //             )
    //           : Text('');
    //     });

    return StreamBuilder<List<Meal>>(
        stream: DatabaseService(uid: user.uid).meals,
        builder: (context, snapshot) {
          List<Meal> meals = snapshot.data;
          if (snapshot.hasData) {
            //final meals = Provider.of<List<Meal>>(context) ?? [];
            return ListView.builder(
                itemCount: meals.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return isDate(widget.date, meals[index])
                      ? MealTile(
                          meal: meals[index],
                          deleteFn: _deleteMeal,
                        )
                      : Text('');
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Text('No meals');
          }
        });
  }
}
