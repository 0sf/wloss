import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../model/meal.dart';

class MealTile extends StatefulWidget {
  final Meal meal;
  final Function deleteFn;

  MealTile({this.meal, this.deleteFn});

  @override
  _MealTileState createState() => _MealTileState();
}

class _MealTileState extends State<MealTile> {
  final formatter = new NumberFormat("##.#");
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
          leading: CachedNetworkImage(
            imageUrl: widget.meal.foodURL,
            placeholder: (context, url) => new Icon(Icons.fastfood),
          ),
          // CircleAvatar(
          //   radius: 25,
          //   child: (widget.meal.foodURL == null)
          //       ? Icon(Icons.restaurant_menu)
          //       : Image.network(widget.meal.foodURL),
          // ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () => widget.deleteFn(widget.meal.documentID),
          ),
          title: Text(widget.meal.foodName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Calories: " +
                  formatter.format(widget.meal.calorieConsumed).toString() +
                  " KCal"),
              Text("Amount: " +
                  formatter.format(widget.meal.portion).toString()),
            ],
          ),
        ),
      ),
    );
  }
}
