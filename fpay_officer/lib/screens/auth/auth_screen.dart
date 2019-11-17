import 'package:FPay/routes/application.dart';
import 'package:FPay/services/auth_service.dart';
import 'package:FPay/services/fine_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _id, _password;
  static final _formKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future _handleLogin(
    String _id,
    String _password,
    BuildContext context,
  ) async {
    // final form = _formKey.currentState;

    AuthService().login(_id, _password).then((res) {
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

  Future _handle() async {
    Logger().i("Result:");
    await FineService().getId().then((ret) async {
      Logger().i("Result: ${ret}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        // resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset("lib/images/officer_login.png"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    _id = value;
                  });
                },
                decoration: new InputDecoration(
                  labelText: "Officer ID",
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
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _handleLogin(_id, _password, context);
                    //_handle();
                  }
                },
                textColor: Colors.white,
                child: const Text('Login', style: TextStyle(fontSize: 20)),
                color: Colors.lightBlue,
              ),
              Expanded(
                child: Container(),
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
