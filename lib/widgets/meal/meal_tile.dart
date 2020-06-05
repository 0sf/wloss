import 'package:flutter/material.dart';

import '../../model/meal.dart';

class MealTile extends StatefulWidget {
  final Meal meal;
  final Function deleteFn;

  MealTile({this.meal, this.deleteFn});

  @override
  _MealTileState createState() => _MealTileState();
}

class _MealTileState extends State<MealTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
      ),
      child: Card(
        margin: EdgeInsets.fromLTRB(
          20.0,
          6.0,
          20.0,
          0.0,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () => widget.deleteFn(widget.meal.documentID),
          ),
          title: Text(widget.meal.foodName),
          subtitle: Text(widget.meal.calorieConsumed.toString()),
        ),
      ),
    );
  }
}
