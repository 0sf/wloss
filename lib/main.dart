import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './services/auth.dart';
import './screens/wrapper.dart';
import './model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().user,
        ),
      ],
      child: MaterialApp(
        title: "WLoss",
        theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Lato',
            textTheme: const TextTheme(
                headline1: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ))),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {},
      ),
    );
  }
}
