import 'package:flutter/material.dart';
import 'package:wloss/shared/constants.dart';
import 'package:intl/intl.dart';

import '../../services/auth.dart';

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

  bool loading = false;

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
  double favoriteExcercise;
  String error = "";
  String _iniGender = "Male";

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
        print(_ageCalculator(_dob));
      });
    });
  }

  int _ageCalculator(DateTime birthDate) {
    var currentDate = DateTime.parse(DateTime.now().toString());
    var birthDatep = DateTime.parse(birthDate.toString());
    int age = currentDate.year - birthDatep.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
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
                                    ? 'Date of Birth'
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
                        DropdownButton<String>(
                          value: _iniGender,
                          hint: Text('Gender'),
                          items: <String>['Male', 'Female'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            gender = value;
                            _iniGender = value;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: "Height"),
                          validator: (value) =>
                              value.length == 0 ? 'Enter a valid value' : null,
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
                          decoration: InputDecoration(hintText: "Weight"),
                          validator: (value) =>
                              value.length == 0 ? 'Enter a valid value' : null,
                          onChanged: (value) {
                            setState(() {
                              weight = double.parse(value);
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: "Activity Factor"),
                          validator: (value) =>
                              value.length == 0 ? 'Enter a valid value' : null,
                          onChanged: (value) {
                            setState(() {
                              activityFactor = double.parse(value);
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
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
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authService
                                    .registerWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                  firstName: firstName,
                                  lastName: lastName,
                                  dob: _dob,
                                  gender: gender,
                                  age: _ageCalculator(_dob),
                                  height: height,
                                  weight: weight,
                                  activityFactor: activityFactor,
                                  favoriteExcercise: favoriteExcercise,
                                );

                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply a valid email';
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
