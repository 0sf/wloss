import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalCalorieCount extends StatelessWidget {

  final double totcount;

  TotalCalorieCount(this.totcount);

  final formatter = new NumberFormat("#####.##");
  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: Text(
        formatter.format(totcount),
        style: TextStyle(
          color: Colors.green.shade400,
          fontSize: 45,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(blurRadius: 10, color: Colors.black,offset: Offset(3,3))]
        ),
      ),
    );
  }
}
