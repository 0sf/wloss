import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wloss/dash_launch.dart';
import 'package:wloss/dashboard.dart';
import 'package:wloss/models/local_user.dart';
import 'package:hive/hive.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _genderController = TextEditingController();
  DateTime _dob;
  String dropdownValue = "Male";

  Widget _entryField(
    String title, {
    bool isPassword = false,
    TextEditingController ctr,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            obscureText: isPassword,
            controller: ctr,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.grey.shade300,
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return RaisedButton(
        child: Text('Register'),
        onPressed: () {
          if (_genderController.text.isEmpty) {
            return;
          }
          final newUser = LocalUser(
            id: DateTime.now().toString(),
            name: _nameController.text,
            age: _ageCalculator(_dob),
            gender: _genderController.text,
          );
          addUser(newUser);
        });
  }

  void addUser(LocalUser puser) {
    final userBox = Hive.box('userInfo');
    userBox.putAt(
      0,
      LocalUser(
        id: puser.id,
        name: puser.name,
        age: puser.age,
        gender: puser.gender,
      ),
    );
    print('User Added!');
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new DashLaunch()));
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
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

  Widget _emailPasswordWidget() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _entryField("Name", ctr: _nameController),
          _entryField("Email", ctr: _emailController),
          _entryField("Password", isPassword: true, ctr: _pwdController),
          _entryField("Gender", ctr: _genderController),

          DropdownButton<String>(
            value: dropdownValue,
            hint: Text('Gender'),
            icon: Icon(Icons.arrow_downward),
            iconSize: 16,
            elevation: 20,
            style: TextStyle(color: Colors.deepPurple),

            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['Male', 'Female',]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Stack(
        children: <Widget>[
          _emailPasswordWidget(),
          Container(
            padding: EdgeInsets.only(bottom: 50),
            child: _submitButton(),
            alignment: Alignment.bottomCenter,
          ),
          _loginAccountLabel()
        ],
      ),
    );
  }
}
