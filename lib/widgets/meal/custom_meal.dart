// @dart=2.9
import 'package:flutter/material.dart';
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

  double amount = 0.0;
  double portion = 0.0;
  int calories = 0;
  String title = "";

  final _amountController = TextEditingController();
  final _nameController = TextEditingController();

  void _submitData(String uid) async {
    if (_amountController.text.isEmpty && amount == 0.0) {
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
        content: Text('Meal Added! '),
      ),
    );
    Navigator.of(context).pop();
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
                    TextField(
                      decoration: InputDecoration(labelText: 'Food Item: '),
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      onSubmitted: (_) => _submitData(user.uid),
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor, // background
                        textStyle: TextStyle(
                          color: Theme.of(context).textTheme.button.color,
                        ),
                        onPrimary: Colors.white, // foreground
                      ),
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
