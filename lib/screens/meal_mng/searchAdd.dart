// @dart=2.9
import 'dart:collection';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:wloss/bloc/meal_bloc.dart';
import 'package:wloss/model/meal_detail.dart';
import 'package:wloss/widgets/meal/custom_meal.dart';
import 'package:wloss/widgets/meal/meal_list.dart';
import 'package:wloss/widgets/meal/new_meal.dart';

class SearchAdd extends StatefulWidget {
  @override
  _SearchAddState createState() => _SearchAddState();
}

class _SearchAddState extends State<SearchAdd> {
  void _customMealAdd(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: CustomMeal(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final shbloc = SearchBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text('Search your meal'),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: FoodSearch(shbloc.meals),
                );
              })
        ],
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _customMealAdd(context);
                  },
                  child:
                      const Text('Manual Add', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
          ),
          Expanded(child: Container(child: MealList(DateTime.now()))),
        ],
      ),
    );
  }
}

class FoodSearch extends SearchDelegate<MealDetail> {
  final Stream<UnmodifiableListView<MealDetail>> meals;

  FoodSearch(this.meals);

  void _startAddNewMealItem(BuildContext ctx, MealDetail a) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewMealItem(a),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<UnmodifiableListView<MealDetail>>(
      stream: meals,
      builder: (BuildContext context,
          AsyncSnapshot<UnmodifiableListView<MealDetail>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final results = snapshot.data
            .where((element) => element.name.toLowerCase().contains(query));
        return ListView(
          children: results
              .map<ListTile>((a) => ListTile(
                  title: Text(
                    a.name,
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(Icons.fastfood),
                  onTap: () {
                    _startAddNewMealItem(context, a);
                  }))
              .toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<UnmodifiableListView<MealDetail>>(
      stream: meals,
      builder: (BuildContext context,
          AsyncSnapshot<UnmodifiableListView<MealDetail>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final results = snapshot.data
            .where((element) => element.name.toLowerCase().contains(query));

        return ListView(
          children: results
              .map<ListTile>((a) => ListTile(
                  title: Text(
                    a.name,
                    style: TextStyle(color: Colors.blue),
                  ),
                  leading: Container(
                    padding: EdgeInsets.all(2),
                    height: 100,
                    width: 100,
                    child: CachedNetworkImage(
                      imageUrl: a.foodURL,
                      placeholder: (_, __) => Icon(Icons.fastfood),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  onTap: () {
                    _startAddNewMealItem(context, a);
                  }))
              .toList(),
        );
      },
    );
  }
}
