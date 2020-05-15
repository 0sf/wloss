import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/local_user.dart';
import 'widgets/input_box.dart';

class HWASelector extends StatefulWidget {
  @override
  _HWASelectorState createState() => _HWASelectorState();
}

class _HWASelectorState extends State<HWASelector> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final afactorController = TextEditingController();

  final userBox = Hive.box('userInfo');

  void _updateUser(
    double uheight,
    double uweight,
    double uafactor,
  ) {
    final user = userBox.getAt(0) as LocalUser;
    print(
        'Before: ${user.id}, ${user.name}, ${user.age.toString()}, ${user.gender}, ${user.height.toString()}, ${user.weight.toString()}, ${user.activityFactor.toString()}');
    userBox.putAt(
      0,
      LocalUser(
        id: user.id,
        name: user.name,
        age: user.age,
        gender: user.gender,
        height: uheight,
        weight: uweight,
        activityFactor: uafactor,
      ),
    );
    final user2 = userBox.getAt(0) as LocalUser;
    print(
        'After: ${user2.id}, ${user2.name}, ${user2.age.toString()}, ${user2.gender}, ${user2.height.toString()}, ${user2.weight.toString()}, ${user2.activityFactor.toString()}');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                InputBox(
                  title: "Height",
                  ctr: heightController,
                  subtitle: "m",
                ),
                InputBox(
                  title: "Weight",
                  ctr: weightController,
                  subtitle: "kg",
                ),
                InputBox(
                  title: "Activity Factor",
                  ctr: afactorController,
                  subtitle: "?",
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          child: RaisedButton(
            onPressed: () => {
              _updateUser(
                double.parse(heightController.text),
                double.parse(weightController.text),
                double.parse(afactorController.text),
              )
            },
            child: Text('Add'),
          ),
        ),
      ],
    );
  }
}
