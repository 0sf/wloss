import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BMRI extends StatefulWidget {
  final double bmi, bmr;

  BMRI({this.bmi, this.bmr});

  @override
  _BMRIState createState() => _BMRIState();
}

class _BMRIState extends State<BMRI> {
  final formatter = new NumberFormat("##.#");
  Color bmiColorValue = Colors.black;
  String bmiStatus = '';
  String url =
      'https://image.shutterstock.com/image-vector/bmi-body-mass-index-dial-600w-1215565054.jpg';

  void bmiColor(double bmi) {
    if (bmi > 0 && bmi <= 18.4) {
      bmiColorValue = Colors.blue;
      bmiStatus = 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      bmiColorValue = Colors.green;
      bmiStatus = 'Normal';
    } else if (bmi >= 25 && bmi <= 29.9) {
      bmiColorValue = Colors.orange;
      bmiStatus = 'Overweight';
    } else {
      bmiColorValue = Colors.red;
      bmiStatus = 'Obese';
    }
  }

  void _showBMIInfo(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(5),
            child: Container(
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: url,
                  placeholder: (context, url) =>
                      new Center(child: CircularProgressIndicator()),
                ),
              ), //Center(child: Image.network(url)),
            ),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bmiColor(widget.bmi);
    return Container(
      width: 300,
      height: 90,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showBMIInfo(context),
        child: Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(),
              children: <TextSpan>[
                TextSpan(
                    text: 'BMI: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                      fontSize: 18,
                    )),
                TextSpan(
                    text: formatter.format(widget.bmi).toString() + " ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: bmiColorValue,
                      fontSize: 32,
                    )),
                TextSpan(
                    text: "(" + bmiStatus + ") (?)",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black38,
                      fontStyle: FontStyle.italic,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
