import 'package:flutter/cupertino.dart';

class MealItem {
  final String id;
  final String title;
  final double perCalorieCount;
  final double perGramCount;
  final double amount;
  final double consumedCalorie;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.perCalorieCount,
    @required this.perGramCount,
    this.consumedCalorie = 0,
  });
}