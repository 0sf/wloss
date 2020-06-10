import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/error/loading.dart';
import '../../widgets/multi_chip.dart';
import '../../model/key_value.dart';
import '../../shared/constants.dart';
import '../../services/auth.dart';
import '../../services/calc/age_cal.dart';

class Register extends StatefulWidget {
  static const routeName = '/sign-up';
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Activity Factor
  List<KeyValueModel> datas = [
    KeyValueModel(key: "Sedentary", value: 1.200),
    KeyValueModel(key: "Lightly Active", value: 1.375),
    KeyValueModel(key: "Moderately Active", value: 1.550),
    KeyValueModel(key: "Very Active", value: 1.725),
    KeyValueModel(key: "Extra Active", value: 1.900),
  ];

  List<String> excercisesList = [
    "Jogging",
    "Running",
    "Yoga",
    "Swimming",
    "Walking",
    "Aerobics"
  ];

  // Controller values
  bool loading = false;
  String selectedValue = "Activity factor";
  String iniGender = "Male";
  String error = "";

  // Form values
  String email = "";
  String password = "";
  String firstName = "";
  String lastName = "";
  String gender = "";
  DateTime _dob;
  double height;
  double weight;
  double activityFactor;
  List<String> favoriteExcercise = List();

  String labVal(double val) {
    for (int i = 0; i < datas.length; i++) {
      if (datas[i].value == val) {
        return datas[i].key;
      }
    }
  }

  _showExcerciseDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Select Excercies"),
            content: MultiSelectChip(
              excercisesList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  favoriteExcercise = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Select"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
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
        _dob = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green.shade100,
            appBar: AppBar(
              title: Text("SignUp | WLoss"),
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 50,
              ),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: "Email",
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter a valid email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: "Password",
                          ),
                          validator: (value) => value.length < 6
                              ? 'Enter a valid password'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "First Name"),
                          validator: (value) =>
                              value.length == 0 ? 'Enter a valid name' : null,
                          onSaved: (value) => firstName = value,
                          onChanged: (value) {
                            setState(() {
                              firstName = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Last Name"),
                          validator: (value) =>
                              value.length == 0 ? 'Enter a valid name' : null,
                          onSaved: (value) => lastName = value,
                          onChanged: (value) {
                            setState(() {
                              lastName = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(_dob == null
                                    ? 'Select Your Date of Birth'
                                    : 'Date of Birth: ${DateFormat.yMd().format(_dob)}'),
                              ),
                              FlatButton(
                                textColor: Theme.of(context).primaryColor,
                                onPressed: _presentDatePicker,
                                child: Text(
                                  'Choose Date',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Gender'),
                            new DropdownButton<String>(
                              value: iniGender,
                              hint: Text('Gender'),
                              items: <String>['Male', 'Female']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                  iniGender = value;
                                });
                              },
                            ),
                          ],
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Height (cm)'),
                          validator: (value) => (value.length == 0)
                              ? 'Enter a valid value'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              height = double.parse(value);
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Weight (kg)"),
                          validator: (value) => (value.length == 0)
                              ? 'Enter a valid value'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              weight = double.parse(value);
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // TextFormField(
                        //   keyboardType: TextInputType.number,
                        //   decoration:
                        //       InputDecoration(hintText: "Activity Factor"),
                        //   validator: (value) =>
                        //       value.length == 0 ? 'Enter a valid value' : null,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       activityFactor = double.parse(value);
                        //     });
                        //   },
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              textColor: Theme.of(context).primaryColor,
                              child: Text(
                                "Excercises",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              onPressed: () => _showExcerciseDialog()(),
                            ),
                            Text(favoriteExcercise.join(" , ")),
                          ],
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
                                  activityFactor = double.parse(val);
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
                        RaisedButton(
                            color: Colors.pink.shade400,
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  loading = true;
                                });

                                dynamic result = await _authService
                                    .registerWithEmailAndPassword(
                                  email: email.trim(),
                                  password: password,
                                  firstName: firstName,
                                  lastName: lastName,
                                  dob: _dob,
                                  gender: gender,
                                  age: AgeCalc.ageCalculator(_dob),
                                  height: height,
                                  weight: weight,
                                  activityFactor: activityFactor,
                                  favoriteExcercise: favoriteExcercise.isEmpty
                                      ? [
                                          "You don't have any favorite excercies"
                                        ]
                                      : favoriteExcercise,
                                );

                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply a valid email' +
                                        result.toString();
                                    loading = false;
                                  });
                                }
                              }
                            }),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          );
  }
}
