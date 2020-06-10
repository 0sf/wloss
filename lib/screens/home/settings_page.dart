import 'package:flutter/material.dart';
import 'package:wloss/widgets/settings_form.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wloss | Update Info'),
      ),
      body: SettingsForm(),
    );
  }
}
