import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wloss/widgets/dash/weightTrack.dart';

import '../../widgets/dash/exercise.dart';
import '../../services/calc/calc_tot.dart';
import '../../model/meal.dart';
import '../../widgets/dash/cgraph.dart';
import '../../widgets/dash/bmir.dart';
import '../../services/calc/calc.dart';
import '../../model/user.dart';
import '../../services/database.dart';

class Temp extends StatefulWidget {
  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            final meals = Provider.of<List<Meal>>(context) ?? [];

            Calc c = Calc(userData);
            TotalCalorieCount tot = TotalCalorieCount(DateTime.now(), meals);

            final double pct = (tot.totalCalorie() / c.dailyCalorieCount());

            final double dif = (c.dailyCalorieCount() - tot.totalCalorie());

            return (c.bmi() == -1 ||
                    c.bmr() == -1 ||
                    c.dailyCalorieCount() == -1)
                ? Center(
                    child: Text(
                    'Please enter a valid height, weight and a gender',
                    softWrap: true,
                    style:
                        TextStyle(fontSize: 18, color: Colors.purple.shade600),
                  ))
                : Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        BMRI(
                          bmi: c.bmi(),
                          bmr: c.bmr(),
                        ),
                        CGraph(pct: pct, dif: dif),
                        ShowExcercise(dif, userData.favoriteExcercise),
                        WeightTracker(
                          userData: userData,
                        )
                      ],
                    ),
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
