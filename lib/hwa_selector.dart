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
                  subtitle: "cm",
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
