import 'package:wloss/models/meal_item.dart';

class TotalCalorieCalc {
  
  final List<MealItem> mealList;

  TotalCalorieCalc(this.mealList);

  double totalCalorie() {
    double totalCalorie = 0;
    for (var i = 0; i < mealList.length; i++) {
      totalCalorie += mealList[i].consumedCalorie;
    }
    return totalCalorie;
  }
}
