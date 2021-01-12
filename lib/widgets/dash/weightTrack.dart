import 'package:flutter/material.dart';
import '../../enum/enums.dart';

class WeightTracker extends StatefulWidget {
  final BMIWeightClass bmiWeightClass;
  WeightTracker({this.bmiWeightClass});
  @override
  _WeightTrackerState createState() => _WeightTrackerState();
}

class _WeightTrackerState extends State<WeightTracker> {
  @override
  Widget build(BuildContext context) {
    if (widget.bmiWeightClass == BMIWeightClass.underweight) {
      return Text("Underweight");
    } else if (widget.bmiWeightClass == BMIWeightClass.overweight ||
        widget.bmiWeightClass == BMIWeightClass.obese) {
      return Text("Overweight");
    } else {
      return Container();
    }
  }
}
