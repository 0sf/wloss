// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wloss/screens/home/home.dart';

import './services/auth.dart';
import './screens/wrapper.dart';
import './model/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Home().init();
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
            textTheme: TextTheme(
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
