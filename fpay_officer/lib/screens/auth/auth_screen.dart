import 'package:FPay/routes/application.dart';
import 'package:FPay/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:email_validator/email_validator.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _email, _password;
  static final _formKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future _handleLogin(
    String email,
    String password,
    BuildContext context,
  ) async {
    final form = _formKey.currentState;
    await AuthService().login(email, password).then((res) async {
      if (res) {
        Application.router.navigateTo(context, '/home');
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Invalid credentials"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Okay"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
              ),
              TextFormField(
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                decoration: new InputDecoration(
                  labelText: "Email",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Empty!!';
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                decoration: new InputDecoration(
                  labelText: "Password",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Password cannot be empty";
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                height: 5,
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _handleLogin(_email, _password, context);
                  }
                },
                textColor: Colors.white,
                child: const Text('Login', style: TextStyle(fontSize: 20)),
                color: Colors.lightBlue,
              )
            ],
          ),
        ));
  }
}

void _showErrorDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Material Dialog'),
          content: Text('This is the content of the material dialog'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  _dismissDialog(context);
                },
                child: Text('Close')),
            FlatButton(
              onPressed: () {
                print('HelloWorld!');
                _dismissDialog(context);
              },
              child: Text('Print HelloWorld!'),
            )
          ],
        );
      });
}

_dismissDialog(BuildContext context) {
  Navigator.pop(context);
}
