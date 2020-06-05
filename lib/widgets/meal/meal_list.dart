import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wloss/model/user.dart';
import 'package:wloss/services/database.dart';

import '../../model/meal.dart';
import './meal_tile.dart';

class MealList extends StatefulWidget {
  @override
  _MealListState createState() => _MealListState();
}

class _MealListState extends State<MealList> {
  @override
  Widget build(BuildContext context) {
    final meals = Provider.of<List<Meal>>(context) ?? [];

    void _deleteMeal(String docId) {
      final user = Provider.of<User>(context, listen: false);
      DatabaseService(uid: user.uid).deleteMeal(docId);
    }

    return ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return MealTile(
            meal: meals[index],
            deleteFn: _deleteMeal,
          );
        });
  }
}
