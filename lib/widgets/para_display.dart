import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wloss/models/local_user.dart';
import '../calc_bmi.dart';

class ParaDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
        box: Hive.box('userInfo'),
        builder: (context, userInf) {
          final userDetails = userInf.getAt(0) as LocalUser;
          final calcUser = new Calc(userDetails);
          return Container(
              child: (calcUser.bmi() == -1 ||
                      calcUser.bmr() == -1 ||
                      calcUser.dailyCalorieCount() == -1)
                  ? Text('Give Height Weight')
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('BMI: ' + calcUser.bmi().toString()),
                        Text('BMR: ' + calcUser.bmr().toStringAsFixed(2)),
                        Text('DCC: ' + calcUser.dailyCalorieCount().toString()),
                      ],
                    ));
        });
  }
}
