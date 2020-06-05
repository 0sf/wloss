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
            width: 300,
            child: new CircularPercentIndicator(
              radius: 200.0,
              lineWidth: 30.0,
              progressColor: (widget.pct < 1)
                  ? Colors.green.shade800
                  : Colors.red.shade800,
              header: Text('Daily Complete'),
              circularStrokeCap: CircularStrokeCap.round,
              percent: (widget.pct > 1) ? 1 : widget.pct,
              center: new Text(
                (widget.pct * 100).toStringAsFixed(2) + "%",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        (widget.dif > 0)
            ? Text(
                " - " + widget.dif.toStringAsFixed(2),
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 32,
                ),
              )
            : Text(
                "+" + (-1 * widget.dif).toString(),
                style: TextStyle(color: Colors.red, fontSize: 32),
              ),
      ],
    );
  }
}
