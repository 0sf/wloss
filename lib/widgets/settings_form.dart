// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/database.dart';
import '../../model/key_value.dart';
import '../model/user.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // Activity Factor
  List<KeyValueModel> datas = [
    KeyValueModel(key: "Sedentary", value: 1.200),
    KeyValueModel(key: "Lightly Active", value: 1.375),
    KeyValueModel(key: "Moderately Active", value: 1.550),
    KeyValueModel(key: "Very Active", value: 1.725),
    KeyValueModel(key: "Extra Active", value: 1.900),
  ];

  // Activty
  String selectedValue = "Activity factor";

  // Data fields
  String firstName;
  String lastName;
  String gender;
  DateTime dob;
  int age;
  double _currentHeight;
  double _currentWeight;
  double _currentActivityFactor;

  String labVal(double val) {
    for (int i = 0; i < datas.length; i++) {
      if (datas[i].value == val) {
        return datas[i].key;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            String _iniGender = userData.gender;

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: userData.firstName.toString(),
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          enabledBorder: new UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter your first name' : null,
                        onChanged: (val) => setState(() => firstName = val),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: userData.lastName.toString(),
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          enabledBorder: new UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter your last name' : null,
                        onChanged: (val) => setState(() => lastName = val),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: userData.age.toString(),
                        decoration: InputDecoration(
                          labelText: 'Age',
                          enabledBorder: new UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter your age' : null,
                        onChanged: (val) =>
                            setState(() => age = int.parse(val)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: userData.height.toString(),
                        decoration: InputDecoration(
                          labelText: 'Height (cm)',
                          enabledBorder: new UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter height' : null,
                        onChanged: (val) =>
                            setState(() => _currentHeight = double.parse(val)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Weight (kg)',
                          enabledBorder: new UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: userData.weight.toString(),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter weight' : null,
                        onChanged: (val) =>
                            setState(() => _currentWeight = double.parse(val)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Activity Factor: '),
                          new DropdownButton<String>(
                            hint: Text(selectedValue),
                            items: datas
                                .map((data) => DropdownMenuItem<String>(
                                      child: new Text(data.key),
                                      value: data.value.toString(),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _currentActivityFactor = double.parse(val);
                                selectedValue = labVal(double.parse(val));
                              });
                            },
                            //value: selectedValue,
                            // hint: Text('Activity Factor'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Gender'),
                          StatefulBuilder(builder: (BuildContext context,
                              StateSetter dropDownState) {
                            return DropdownButton<String>(
                              value: _iniGender,
                              hint: Text('Gender'),
                              items: <String>['Male', 'Female']
                                  .map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String value) {
                                dropDownState(() {
                                  _iniGender = value;
                                  gender = value;
                                });
                              },
                            );
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade600, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print(age);
                            await DatabaseService(uid: user.uid)
                                .updateUserData(
                                  lastName: lastName ?? userData.lastName,
                                  firstName: firstName ?? userData.firstName,
                                  dob: dob ?? userData.dob,
                                  gender: gender ?? "Male",
                                  favoriteExcercise: userData.favoriteExcercise,
                                  age: age ?? userData.age,
                                  height: _currentHeight ?? userData.height,
                                  weight: _currentWeight ?? userData.weight,
                                  activityFactor: _currentActivityFactor ??
                                      userData.activityFactor,
                                )
                                .onError((error, stackTrace) => print(
                                    "Settings Faild:" +
                                        error.toString() +
                                        " Stack: " +
                                        stackTrace.toString()));

                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
