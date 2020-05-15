import 'dart:math';

import 'package:wloss/models/local_user.dart';

class Calc {
  LocalUser localUser;

  Calc(this.localUser);

  double bmi() {
    return (localUser.weight / pow(localUser.height/100, 2));
  }

  double bmr() {
    String gender = localUser.gender;
    double height = localUser.height;
    double weight = localUser.weight;
    int age = localUser.age;

    if (gender == "M") {
      var bmrF = (10 * weight) + (6.25 * height * 100) - (5 * age) + 5;
      return bmrF * 10000;
    } else if (gender == "F") {
      var bmrF = (10 * weight) + (6.25 * height * 100) - (5 * age) - 161;
      return bmrF * 10000;
    } else {
      return -1;
    }
  }

  double dailyCalorieCount() {
    return bmr() * localUser.activityFactor;
  }
}
