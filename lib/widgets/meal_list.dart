import 'package:flutter/material.dart';
import '../models/meal_item.dart';
import 'package:intl/intl.dart';

class MealList extends StatelessWidget {
  final formatter = new NumberFormat("#####.##");
  final List<MealItem> meals;
  final Function deleteTx;

  MealList(this.meals, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => deleteTx(meals[index].id),
            ),
            leading: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black45, width: 2),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text(
                    formatter.format(meals[index].consumedCalorie),
                    style: TextStyle(
                      backgroundColor: Colors.yellow.shade300,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              meals[index].title,
              style: Theme.of(context).textTheme.headline4,
            ),
            subtitle: Text(meals[index].amount.toString() +
                "g, " +
                meals[index].perCalorieCount.toString() +
                " of calories contain in " +
                meals[index].perGramCount.toString() +
                " grams."),
            isThreeLine: true,
          ),
        );
      },
      itemCount: meals.length,
    );
  }
}
