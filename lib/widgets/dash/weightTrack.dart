import 'package:flutter/material.dart';

import 'package:wloss/model/user.dart';
import 'package:wloss/services/calc/calc.dart';
import '../../enum/enums.dart';

class WeightTracker extends StatefulWidget {
  final UserData userData;
  WeightTracker({this.userData});
  @override
  _WeightTrackerState createState() => _WeightTrackerState();
}

class _WeightTrackerState extends State<WeightTracker> {
  @override
  Widget build(BuildContext context) {
    Calc c = Calc(widget.userData);

    final BMIWeightClass bmiWeightClass = c.bmiWeightClass(c.bmi());
    var goalweight = c.goalWeight();
    var shedule = c.schedule();

    if (bmiWeightClass == BMIWeightClass.underweight) {
      return Card(
        child: Text("Goal Weight: " +
            goalweight.toStringAsFixed(2) +
            " Kg\n"
                "Schedule: " +
            shedule.toStringAsFixed(2) +
            " weeks"),
      );
    } else if (bmiWeightClass == BMIWeightClass.overweight ||
        bmiWeightClass == BMIWeightClass.obese) {
      return Card(
        child: Text("Goal Weight: " +
            goalweight.toStringAsFixed(2) +
            " Kg\n" +
            " Schedule: " +
            shedule.toStringAsFixed(2) +
            " weeks"),
      );
    } else {
      return Container();
    }
  }
}
