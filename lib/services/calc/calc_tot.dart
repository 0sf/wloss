import '../../model/meal.dart';

class TotalCalorieCount {
  final DateTime date;
  final List<Meal> meals;

  TotalCalorieCount(this.date, this.meals);

  double totalCalorie() {
    double totalCalorie = 0;

    for (var i = 0; i < meals.length; i++) {
      if (meals[i] != null) {
        if (date.day == meals[i].foodId.day &&
            date.month == meals[i].foodId.month &&
            date.year == meals[i].foodId.year) {
          totalCalorie += meals[i].calorieConsumed;
        }
      }
    }
    //print('totalCalorie' + totalCalorie.toString());
    return totalCalorie;
  }
}
