import 'package:flutter/material.dart';

class ShowExcercise extends StatelessWidget {
  final double dif;
  final List<String> excr;
  ShowExcercise(this.dif, this.excr);
  @override
  Widget build(BuildContext context) {
    if (dif < 0) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Text(
          excr.join(' , ') +
              " You can do ${excr[0]} for 40 min to loose the extra ${((-1) * dif).toStringAsFixed(1)} calorie amount",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    } else {
      return Container();
    }
  }
}
