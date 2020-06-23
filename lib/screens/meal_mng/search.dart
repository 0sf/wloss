import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:wloss/bloc/meal_bloc.dart';
import 'package:wloss/model/meal_detail.dart';
import 'package:wloss/widgets/meal/new_meal.dart';

class SearchAdd extends StatefulWidget {
  @override
  _SearchAddState createState() => _SearchAddState();
}

class _SearchAddState extends State<SearchAdd> {

    void _startAddNewMealItem(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewMealItem(),
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
    );
  }
}

class FoodSearch extends SearchDelegate<MealDetail> {
  final Stream<UnmodifiableListView<MealDetail>> meals;

  FoodSearch(this.meals);

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
            child: Text('No Data'),
          );
        }
        final results = snapshot.data
            .where((element) => element.name.toLowerCase().contains(query));
        return ListView(
          children: results
              .map<ListTile>((a) => ListTile(
                  title: Text(
                    a.name,
                    style: TextStyle(color: Colors.red),
                  ),
                  leading: Icon(Icons.fastfood),
                  subtitle: Text(a.calories.toString()),
                  onTap: () {
                    
                    close(context, a);
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
          return Center(
            child: Text('No Data'),
          );
        }
        final results = snapshot.data
            .where((element) => element.name.toLowerCase().contains(query));
        return ListView(
          children: results
              .map<ListTile>((a) => ListTile(
                  title: Text(
                    a.name,
                    style: TextStyle(color: Colors.red),
                  ),
                  leading: Icon(Icons.fastfood),
                  subtitle: Text(a.calories.toString()),
                  onTap: () {
                    close(context, a);
                  }))
              .toList(),
        );
      },
    );
  }
}
