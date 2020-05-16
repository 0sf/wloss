import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wloss/models/meal_model.dart';

class MealView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mealBox = Hive.box('mealInfo0');
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: mealBox.length,
            itemBuilder: (context, index) {
              final meal = mealBox.getAt(index) as MealModel;
              return ListTile(
                title: Text(meal.foodTitle.toString()),
                subtitle: Column(
                  children: <Widget>[
                    Text('ID: ' + meal.id.month.toString()),
                    Text('Amount: ' + meal.amount.toString()),
                    Text('Calories: ' + meal.calories.toString()),
                    Text('Portion: ' + meal.portion.toString()),
                    Text('Consumed Calories: ' +
                        meal.consumedCalorie.toString()),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
