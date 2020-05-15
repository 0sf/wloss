import 'package:flutter/material.dart';
import 'package:wloss/dashboard.dart';
import 'package:wloss/models/meal_item.dart';
import 'package:wloss/widgets/calc_totcal.dart';
import 'package:wloss/widgets/meal_list.dart';
import 'package:wloss/widgets/new_meal_item.dart';
import 'package:wloss/widgets/total_calorie_count.dart';

class MealPicker extends StatefulWidget {
  @override
  _MealPickerState createState() => _MealPickerState();
}

class _MealPickerState extends State<MealPicker> {
  final List<MealItem> _mealIngredients = [];

  void _deleteMealItem(String id) {
    setState(() {
      _mealIngredients.removeWhere((tx) => tx.id == id);
    });
  }

  void _addNewMealItem(
    String txTitle,
    double txAmount,
    double txPerCalAm,
    double txPerGrmCut,
    double txCons,
  ) {
    final newTx = MealItem(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      perCalorieCount: txPerCalAm,
      perGramCount: txPerGrmCut,
      consumedCalorie: txCons,
    );

    setState(() {
      _mealIngredients.add(newTx);
    });
  }

  void _startAddNewMealItem(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewMealItem(_addNewMealItem),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Data"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  0.1,
              child: TotalCalorieCount(TotalCalorieCalc(_mealIngredients).totalCalorie()),
            ),
            Container(
              height: (MediaQuery.of(context).size.height * 0.8),
              child: MealList(_mealIngredients, _deleteMealItem),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          padding: EdgeInsets.only(left:10, right:10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "backToDash",
                  child: Icon(Icons.navigate_before), onPressed: () {
                    Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
                  }),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => _startAddNewMealItem(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
