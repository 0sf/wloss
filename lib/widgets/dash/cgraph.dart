import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CGraph extends StatefulWidget {
  final double pct;
  final double dif;
  const CGraph({Key key, this.pct, this.dif}) : super(key: key);

  @override
  _CGraphState createState() => _CGraphState();
}

class _CGraphState extends State<CGraph> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            height: 300,
            width: 200,
            child: new CircularPercentIndicator(
              radius: 175.0,
              lineWidth: 30.0,
              progressColor: (widget.pct < 1)
                  ? Colors.green.shade400
                  : Colors.red.shade400,
              header: Text(
                'Daily Calories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              percent: (widget.pct > 1) ? 1 : widget.pct,
              center: new Text(
                (widget.pct * 100).toStringAsFixed(1) + "%",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              footer: (widget.dif > 0)
                  ? Text(
                      " - " + widget.dif.toStringAsFixed(1) + " KCal",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 32,
                      ),
                    )
                  : Text(
                      "+" + (-1 * widget.dif).toStringAsFixed(1) + " KCal",
                      style: TextStyle(color: Colors.red, fontSize: 30),
                      softWrap: true,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
