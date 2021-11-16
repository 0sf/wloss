// @dart=2.9
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
  bool isDate(DateTime date, Meal meals) {
    if (date.day == meals.foodId.day &&
        date.month == meals.foodId.month &&
        date.year == meals.foodId.year) {
      return true;
    }
    return false;
  }

  void _addToList(List<Meal> meals, List<Meal> mealList, DateTime date) {
    for (var meal in meals) {
      if (date.day == meal.foodId.day &&
          date.month == meal.foodId.month &&
          date.year == meal.foodId.year) {
        mealList.add(meal);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);

    void _deleteMeal(String docId) {
      DatabaseService(uid: user.uid).deleteMeal(docId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 800),
          content: Text('Deleted!'),
        ),
      );
    }

    return StreamBuilder<List<Meal>>(
        stream: DatabaseService(uid: user.uid).meals,
        builder: (context, snapshot) {
          List<Meal> meals = snapshot.data;
          if (snapshot.hasData) {
            var mealList = <Meal>[];
            _addToList(meals, mealList, widget.date);
            if (mealList.isEmpty) {
              print("Empty");
              return Center(child: Text('No meals for that date.'));
            } else if (mealList.isNotEmpty) {
              return Container(
                child: ListView.builder(
                    itemCount: mealList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = mealList[index];
                      return MealTile(
                        meal: item,
                        deleteFn: _deleteMeal,
                      );
                    }),
              );
            } else {
              return Container();
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Text('Stream builder ERORR!');
          }
        });
  }
}
