import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BMRI extends StatelessWidget {
  final formatter = new NumberFormat("#######.##");
  double bmi, bmr, dailyCalorieCount;

  BMRI({this.bmi, this.bmr, this.dailyCalorieCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            formatter.format(bmi).toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            formatter.format(bmr).toString(),
          ),
          Text(formatter.format(dailyCalorieCount).toString()),
        ],
      ),
    );
  }
}
