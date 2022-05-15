// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../services/database.dart';

class CustomMeal extends StatefulWidget {
  const CustomMeal({Key key}) : super(key: key);
  @override
  _CustomMealState createState() => _CustomMealState();
}

class _CustomMealState extends State<CustomMeal> {
  bool loading = false;

  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime foodID = DateTime.now();
  double amount = 0.0;
  double portion = 0.0;
  int calories = 0;
  String title = "";

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _calorieController = TextEditingController();
  final _calorieGramController = TextEditingController();

  void _submitData(String uid, BuildContext context) async {
    print(">>>>>" +
        "title: " +
        title +
        "portion: " +
        amount.toString() +
        "calories: " +
        calories.toString());

    if (_amountController.text.isEmpty && amount == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
        content: Text('Please fill all fields.'),
      ));
      return;
    }

    final enteredTitle = title;
    final enteredAmount = amount; //double.parse(_amountController.text);
    final perGram = portion;
    final perCalorie = calories;
    final foodURL = ""; // Check

    double consumedCalorie = (perCalorie / perGram) * enteredAmount;

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        perGram <= 0 ||
        perCalorie <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
        content: Text('Please fill all fields.'),
      ));
      return;
    }

    loading = true;

    await DatabaseService(uid: uid).updateMealData(
      foodID,
      enteredTitle,
      foodURL,
      enteredAmount,
      perCalorie,
      consumedCalorie,
    );

    await DatabaseService(uid: uid).updateNewMealData(
      foodID,
      enteredTitle,
      perCalorie,
      consumedCalorie,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
        content: Text('Meal Added! '),
      ),
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        print("Before: " + foodID.toString());
        foodID = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            foodID.hour,
            foodID.minute,
            foodID.second,
            foodID.millisecond,
            foodID.microsecond);
        print("After: " + foodID.toString());
      });
    });
  }

  _setTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    // Goes here.
    setState(() {
      print("Before: " + foodID.toString());
      foodID = DateTime(
          foodID.year,
          foodID.month,
          foodID.day,
          timeOfDay.hour,
          timeOfDay.minute,
          foodID.second + 1,
          foodID.millisecond + 1,
          foodID.microsecond + 1);
      print("After: " + foodID.toString());
    });
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date'),
                        TextButton(
                            onPressed: _presentDatePicker,
                            child: Text(DateFormat('d/M/y').format(foodID)))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Time'),
                        TextButton(
                          onPressed: () {
                            _setTime(context);
                          },
                          child: Text(DateFormat('kk:mm:a').format(foodID)),
                        )
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Food Item: '),
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      onChanged: (value) => title = value,
                      onSubmitted: (_) => _submitData(user.uid, context),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Amount / g'),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => amount = double.parse(value),
                      onSubmitted: (_) => _submitData(user.uid, context),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Calorie / kcal'),
                      controller: _calorieController,
                      onChanged: (value) => calories = int.parse(value),
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitData(user.uid, context),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration:
                          InputDecoration(labelText: 'Calorie Portion / g'),
                      controller: _calorieGramController,
                      onChanged: (value) => portion = double.parse(value),
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitData(user.uid, context),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor, // background
                        textStyle: TextStyle(
                          color: Theme.of(context).textTheme.button.color,
                        ),
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () => _submitData(user.uid, context),
                      child: Text('Add Meal Item'),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
