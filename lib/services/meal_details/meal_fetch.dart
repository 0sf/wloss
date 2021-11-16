// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wloss/model/meal_detail.dart';

Future<MealDetailState> fetchMeal() async {
  final response = await http.get('http://localhost:3000/meals');
  if (response.statusCode == 200) {
    return MealDetailState.fromJson(json.decode(response.body));
  } else {
    throw Exception('Couldnt get data');
  }
}

class MealDetailState {
  final MealDetail md;
  MealDetailState({this.md});
  factory MealDetailState.fromJson(Map<String, dynamic> json) {
    return MealDetailState(md: MealDetail.fromJson(json['meals']));
  }
}
