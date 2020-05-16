import 'package:hive/hive.dart';

class TotalCalorieCalc {
  DateTime date;

  TotalCalorieCalc(this.date);

  final mealBox = Hive.box('mealInfo0');

  double totalCalorie() {
    
    double totalCalorie = 0;

    for (var i = 0; i < mealBox.length; i++) {
      if (date.day == mealBox.get(i).id.day &&
          date.month == mealBox.get(i).id.month &&
          date.year == mealBox.get(i).id.year)
        totalCalorie += mealBox.getAt(i).consumedCalorie;
    }
    return totalCalorie;
  }
}
