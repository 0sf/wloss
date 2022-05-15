import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wloss/model/user.dart';
import '../../services/database.dart';

class FeedBack extends StatefulWidget {
  const FeedBack();

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final _nameController = TextEditingController();
  final _feedbackController = TextEditingController();

  void _updateFeedback(String uid) async {
    print('I run!!');
    if (_nameController.text.isEmpty || _feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
        content: Text('Please fill all fields.'),
      ));
      return;
    }

    await DatabaseService(uid: uid).sendFeedback(
      DateTime.now(),
      _nameController.text,
      _feedbackController.text,
    );

    _nameController.clear();
    _feedbackController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
        content: Text('Feedback Sent! '),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Name '),
              controller: _nameController,
              keyboardType: TextInputType.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Feedback '),
              controller: _feedbackController,
              keyboardType: TextInputType.name,
              maxLines: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Send'),
                onPressed: () => _updateFeedback(user.uid),
              ),
            ),
          )
        ],
      ),
    );
  }
}
