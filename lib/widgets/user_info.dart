import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wloss/models/local_user.dart';

class UserInfo extends StatelessWidget {
  final userBox = Hive.box('userInfo');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: userBox.length,
            itemBuilder: (context, index) {
              final user = userBox.getAt(index) as LocalUser;
              return ListTile(
                title: Text(user.id.toString()),
                subtitle: Column(
                  children: <Widget>[
                    Text('Name: ' + user.name.toString()),
                    Text('Name: ' + user.gender.toString()),
                    Text('Age: ' + user.age.toString()),
                    Text('AF: ' + user.activityFactor.toString()),
                    Text('Height' + user.height.toString()),
                    Text('Weight:' + user.weight.toString()),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
