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
          excr.join(' , '),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    } else {
      return Container();
    }
  }
}
