import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wloss/dashboard.dart';

class DashLaunch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox('mealInfo0'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return new Dashboard();
          } else
            return Text('Wait...');
        });
  }
}
