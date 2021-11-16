// @dart=2.9
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
      return Display(goalWeight: goalweight, shedule: shedule);
    } else if (bmiWeightClass == BMIWeightClass.overweight ||
        bmiWeightClass == BMIWeightClass.obese) {
      return Display(
        goalWeight: goalweight,
        shedule: shedule,
      );
    } else if (bmiWeightClass == BMIWeightClass.normal) {
      return Container();
    } else {
      return Container();
    }
  }
}

class Display extends StatelessWidget {
  final double goalWeight, shedule;
  const Display({this.goalWeight, this.shedule});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text("Goal Weight\n" + goalWeight.toStringAsFixed(1) + " Kg"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text("Schedule\n" + shedule.toStringAsFixed(0) + " weeks"),
        ),
      ],
    );
  }
}
