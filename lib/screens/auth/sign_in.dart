// @dart=2.9
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/error/loading.dart';
import '../../services/auth.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/sign-in';
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  // text field status
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                TextButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Register'),
                    onPressed: () {
                      widget.toggleView();
                    })
              ],
              title: Text('SignIn | WLoss'),
              elevation: 0.0,
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
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.email),
                            hintText: 'Email',
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
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.visibility),
                            hintText: 'Password',
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
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink.shade400, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            child: Text(
                              'Sign In',
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
                                    .signInWithEmailAndPassword(
                                        email.trim(), password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Credential Error';
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
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(text: 'Don\'t have an account yet? '),
                                TextSpan(
                                    text: 'Register',
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () => widget.toggleView(),
                                    style: TextStyle(
                                        color: Colors.blue[200],
                                        fontWeight: FontWeight.bold)),
                              ]),
                        )
                      ],
                    ),
                  )),
            ),
          );
  }
}
