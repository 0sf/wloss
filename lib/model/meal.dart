class Meal {
  final String documentID;
  final DateTime foodId;
  final String foodName;
  final String foodURL;
  final double portion;
  final double caloriePortion;
  final double calorieConsumed;

  Meal({
    this.documentID,
    this.foodId,
    this.foodName,
    this.foodURL,
    this.portion = 0,
    this.caloriePortion = 0,
    this.calorieConsumed = 0,
  });
}

class MealItem {
  final String foodId;
  final double portion;

  MealItem({
    this.foodId,
    this.portion,
  });
}
