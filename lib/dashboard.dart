import 'package:flutter/material.dart';
import 'package:wloss/meal_picker.dart';
import 'package:wloss/widgets/para_display.dart';
import 'package:wloss/widgets/user_info.dart';
import 'hwa_selector.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  void _startHWAInput(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(5),
            child: HWASelector(),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('WLoss'),
            IconButton(
                icon: Icon(Icons.face),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new UserInfo()));
                })
          ],
        ),
      ),
      body: ParaDisplay(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "HWA",
              child: Icon(Icons.face),
              onPressed: () => _startHWAInput(context),
            ),
            FloatingActionButton(
                heroTag: "MealPicker",
                child: Icon(
                  Icons.navigate_next,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MealPicker()));
                }),
          ],
        ),
      ),
    );
  }
}
