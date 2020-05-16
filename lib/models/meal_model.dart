import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'meal_model.g.dart';

@HiveType(typeId: 1)
class MealModel {
  @HiveField(0)
  final DateTime id;

  @HiveField(1)
  final String foodTitle;

  @HiveField(2)
  final double portion;

  @HiveField(3)
  final double calories;

  @HiveField(4)
  final double amount;

  @HiveField(5)
  double consumedCalorie;

  @HiveField(6)
  String mealType;

  MealModel({
    @required this.id,
    @required this.foodTitle,
    @required this.portion,
    @required this.calories,
    @required this.amount,
    this.consumedCalorie,
    this.mealType,
  });
}
