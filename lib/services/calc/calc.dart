import 'dart:math';

import '../../model/user.dart';
import '../../enum/enums.dart';

class Calc {
  UserData user;

  Calc(this.user);

  // Calculate BMI
  double bmi() {
    if (user.weight != 0.0 && user.height != 0.0) {
      return (user.weight / pow(user.height / 100, 2));
    } else {
      return -1;
    }
  }

  BMIWeightClass bmiWeightClass(double bmi) {
    if (bmi > 0 && bmi <= 18.4) {
      //'Underweight';
      return BMIWeightClass.underweight;
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      //'Normal';
      return BMIWeightClass.normal;
    } else if (bmi >= 25 && bmi <= 29.9) {
      //'Overweight';
      return BMIWeightClass.overweight;
    } else {
      //'Obese';
      return BMIWeightClass.obese;
    }
  }

  // Calculate BMR
  double bmr() {
    String gender = user.gender;
    double height = user.height;
    double weight = user.weight;
    int age = user.age;

    if (gender == "Male" &&
        user.weight != 0.0 &&
        user.height != 0 &&
        user.age != 0) {
      var bmrF = (10 * weight) + (6.25 * height) - (5 * age) + 5;
      return bmrF;
    } else if (gender == "Female" &&
        user.weight != 0.0 &&
        user.height != 0 &&
        user.age != 0) {
      var bmrF = (10 * weight) + (6.25 * height) - (5 * age) - 161;
      return bmrF;
    } else {
      return -1;
    }
  }

  double dailyCalorieCount() {
    if (bmr() == -1) {
      return -1;
    }
    return bmr() * user.activityFactor;
  }
}
