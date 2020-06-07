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
    final user = Provider.of<User>(context, listen: false);
    final meals = Provider.of<List<Meal>>(context) ?? [];

    void _deleteMeal(String docId) {
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

    // StreamBuilder<List<Meal>>(
    //     stream: DatabaseService(uid: user.uid).meals,
    //     builder: (context, snapshot) {
    //       List<Meal> meals = snapshot.data;
    //       if (snapshot.hasData) {
    //         //final meals = Provider.of<List<Meal>>(context) ?? [];
    //         return ListView.builder(
    //             itemCount: meals.length,
    //             itemBuilder: (context, index) {
    //               return MealTile(
    //                 meal: meals[index],
    //                 deleteFn: _deleteMeal,
    //               );
    //             });
    //       } else {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     });
  }
}
