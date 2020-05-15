import 'package:flutter/material.dart';

class NewMealItem extends StatefulWidget {
  final Function addMl;

  NewMealItem(this.addMl);

  @override
  _NewMealItemState createState() => _NewMealItemState();
}

class _NewMealItemState extends State<NewMealItem> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _perCalorieController = TextEditingController();
  final _perGramController = TextEditingController();

  void _submitData() {
    
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

    widget.addMl(
      enteredTitle,
      enteredAmount,
      perCalorie,
      perGram,
      consumedCalorie,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount / g'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Serving Size / g'),
                controller: _perGramController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Calories in Serving Size / Kcal'),
                controller: _perCalorieController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
                child: Text('Add Meal Item'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
