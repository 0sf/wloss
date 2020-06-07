import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wloss/services/database.dart';
import '../../model/user.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  double _currentHeight;
  double _currentWeight;
  double _currentActivityFactor;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData.height.toString(),
                    decoration: InputDecoration(
                        labelText: 'Height',
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        )),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter height' : null,
                    onChanged: (val) =>
                        setState(() => _currentHeight = double.parse(val)),
                  ),
                  TextFormField(
                    initialValue: userData.weight.toString(),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter weight' : null,
                    onChanged: (val) =>
                        setState(() => _currentWeight = double.parse(val)),
                  ),
                  TextFormField(
                    initialValue: userData.activityFactor.toString(),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter activityfactor' : null,
                    onChanged: (val) => setState(
                        () => _currentActivityFactor = double.parse(val)),
                  ),
                  RaisedButton(
                    color: Colors.red.shade600,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          height: _currentHeight ?? userData.height,
                          weight: _currentWeight ?? userData.weight,
                          activityFactor:
                              _currentActivityFactor ?? userData.activityFactor,
                        );

                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
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
