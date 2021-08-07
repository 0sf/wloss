import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import '../model/meal_detail.dart';

class SearchBloc {
  final _mealSubject = BehaviorSubject<UnmodifiableListView<MealDetail>>();

  var _meals = <MealDetail>[];

  SearchBloc() {
    _fetchMeal().then((_) {
      _mealSubject.add(UnmodifiableListView(_meals));
    });
  }

  Stream<UnmodifiableListView<MealDetail>> get meals => _mealSubject.stream;

  Future<Null> _fetchMeal() async {
    final url1 = "https://wloss-app.firebaseio.com/meals.json";
    // final url2 = "https://meals.free.beeceptor.com/meals";
    final response = await http.get(url1);
    if (response.statusCode == 200) {
      _meals = parseMeal(response.body);
    } else {
      throw Exception('Couldnt get data');
    }
  }

  List<MealDetail> parseMeal(String response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    return parsed.map<MealDetail>((json) => MealDetail.fromJson(json)).toList();
  }
}
