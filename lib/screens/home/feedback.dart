import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  const FeedBack();

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
    );
  }
}
