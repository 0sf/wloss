import 'dart:math';

import 'package:wloss/models/local_user.dart';

class Calc {
  LocalUser localUser;

  Calc(this.localUser);

  double bmi() {
    if(localUser.weight != 0.0 && localUser.height != 0.0) {
      return (localUser.weight / pow(localUser.height/100, 2));
    }else
    return -1;
  }

  double bmr() {
    String gender = localUser.gender;
    double height = localUser.height;
    double weight = localUser.weight;
    int age = localUser.age;

    if (gender == "M" && localUser.weight != 0.0 && localUser.height != 0) {
      var bmrF = (10 * weight) + (6.25 * height) - (5 * age) + 5;
      return bmrF;
    } else if (gender == "F" && localUser.weight != 0.0 && localUser.height != 0) {
      var bmrF = (10 * weight) + (6.25 * height) - (5 * age) - 161;
      return bmrF ;
    } else {
      return -1;
    }
  }

  double dailyCalorieCount() {
    if (bmr() == -1) {
      return -1;
    }
    return bmr() * localUser.activityFactor;
  }
}
