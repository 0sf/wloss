// @dart=2.9
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';

import '../model/meal_detail.dart';

class SearchBloc {
  final _mealSubject = BehaviorSubject<UnmodifiableListView<MealDetail>>();

  var _meals = <MealDetail>[];

  SearchBloc() {
    _fetchMeal().then((_) {
      _mealSubject.add(UnmodifiableListView(_meals));
    }).catchError((Object o, StackTrace s) {
      print("Network Error!\n Object: " +
          o.toString() +
          " Stack: " +
          s.toString());
    });

    // _fetchMeal().then((_) {
    //   _mealSubject.add(UnmodifiableListView(_meals));
    // });
  }

  Stream<UnmodifiableListView<MealDetail>> get meals => _mealSubject.stream;

  Future<Null> _fetchMeal() async {
    // http.Client client --> http.Client()
    //var url1 = Uri.parse('https://wloss-app.firebaseio.com/meals.json');
    final url1 = "https://wloss-app.firebaseio.com/meals.json";
    // final url2 = "https://meals.free.beeceptor.com/meals";

    //final response = await http.get(url1);
    //http.Response response =
    //    await http.get('https://wloss-app.firebaseio.com/meals.json');

    // var dio = Dio();
    // Response response =
    //     await dio.get('https://wloss-app.firebaseio.com/meals.json');

    // final response = await client
    //     .get(Uri.parse('https://wloss-app.firebaseio.com/meals.json'));

    // HttpClient httpClient = new HttpClient();
    // HttpClientRequest request = await httpClient
    //     .getUrl(Uri.parse('https://wloss-app.firebaseio.com/meals.json'));
    // HttpClientResponse response = await request.close();
    // String reply = await response.transform(utf8.decoder).join();

    final response = await http.get(url1).catchError((Object o, StackTrace s) {
      print(
          "HTTP Error!\n Object: " + o.toString() + " Stack: " + s.toString());
    });

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
