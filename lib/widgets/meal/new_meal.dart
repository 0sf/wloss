import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:wloss/model/meal_detail.dart';
import '../../data/picker_data.dart';
import '../../data/metrics.dart';
import '../../model/user.dart';
import '../../services/database.dart';

class NewMealItem extends StatefulWidget {
  final MealDetail meal;
  NewMealItem(this.meal);
  @override
  _NewMealItemState createState() => _NewMealItemState();
}

class _NewMealItemState extends State<NewMealItem> {
  bool loading = false;
  double amount = 0.0;

  final _amountController = TextEditingController();

  void _submitData(String uid) async {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = widget.meal.name;
    final enteredAmount = double.parse(_amountController.text);
    final perGram = widget.meal.portion;
    final perCalorie = widget.meal.calories;
    final foodURL = widget.meal.foodURL;
    double consumedCalorie = (perCalorie / perGram) * enteredAmount;

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        perGram <= 0 ||
        perCalorie <= 0) {
      return;
    }

    loading = true;
    await DatabaseService(uid: uid).updateMealData(
      DateTime.now(),
      enteredTitle,
      foodURL,
      enteredAmount,
      perCalorie,
      consumedCalorie,
    );
    Navigator.of(context).pop();
  }

  double convertedInput(List value) {
    double amount = double.parse(value[0]);
    double fraction = 1;
    if (value[1] == "--") {
      fraction = 1;
    } else {
      fraction = double.parse(value[1][0]) / double.parse(value[1][2]);
    }
    var val = value[2].toString();
    var index = Mes.keys.toList().indexOf(val);
    double unit = Mes.values.toList()[index];

    return amount * fraction * unit;
  }

  showPickerArray(BuildContext context) {
    double valueLable = 0;
    Picker(
        footer: Text("$valueLable"),
        adapter: PickerDataAdapter<String>(
          pickerdata: JsonDecoder().convert(PickerData),
          isArray: true,
        ),
        hideHeader: false,
        onSelect: (Picker picker, int i, List value) {
          setState(() {
            // print(picker.getSelectedValues());
            valueLable = double.parse(picker.getSelectedValues()[0]);
            // print(valueLable);
          });
        },
        selecteds: [0, 0, 0],
        title: Text("Please Select"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        cancel: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.cancel)),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          print(convertedInput(picker.getSelectedValues()));
        }).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Container(
            height: 400, child: Center(child: CircularProgressIndicator()))
        : SingleChildScrollView(
            child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Picker Show (Array)'),
                      onPressed: () {
                        showPickerArray(context);
                      },
                    ),
                    Text(
                      widget.meal.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Amount / g'),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitData(user.uid),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.button.color,
                      onPressed: () => _submitData(user.uid),
                      child: Text('Add Meal Item'),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
