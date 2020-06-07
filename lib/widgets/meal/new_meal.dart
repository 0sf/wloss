import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/user.dart';
import '../../services/database.dart';

class NewMealItem extends StatefulWidget {
  @override
  _NewMealItemState createState() => _NewMealItemState();
}

class _NewMealItemState extends State<NewMealItem> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _perCalorieController = TextEditingController();
  final _perGramController = TextEditingController();

  void _submitData(String uid) async {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    final perGram = double.parse(_perGramController.text);
    final perCalorie = double.parse(_perCalorieController.text);
    double consumedCalorie = (perCalorie / perGram) * enteredAmount;

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        perGram <= 0 ||
        perCalorie <= 0) {
      return;
    }

    await DatabaseService(uid: uid).updateMealData(
      DateTime.now(),
      enteredTitle,
      perGram,
      perCalorie,
      consumedCalorie,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SingleChildScrollView(
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Food Item'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(user.uid),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount / g'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(user.uid),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Serving Size / g'),
                controller: _perGramController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(user.uid),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Calories in Serving Size / Kcal'),
                controller: _perCalorieController,
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
