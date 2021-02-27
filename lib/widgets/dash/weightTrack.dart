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
        child: Text("Underweight" "Goal Weight: " +
            goalweight.toStringAsFixed(2) +
            "Schedule: " +
            shedule.toStringAsFixed(2)),
      );
    } else if (bmiWeightClass == BMIWeightClass.overweight ||
        bmiWeightClass == BMIWeightClass.obese) {
      return Card(
        child: Text("Overweight, " +
            "Goal Weight: " +
            goalweight.toStringAsFixed(2) +
            " Schedule: " +
            shedule.toStringAsFixed(2)),
      );
    } else {
      return Container();
    }
  }
}
