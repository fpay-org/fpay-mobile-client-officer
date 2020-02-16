import 'package:FPay/routes/application.dart';
import 'package:FPay/services/fine_service.dart';
import 'package:FPay/services/pref_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CreateSession extends StatefulWidget {
  @override
  _CreateSessionState createState() => _CreateSessionState();
}

class _CreateSessionState extends State<CreateSession> {
  bool isEnabaled;
  @override
  void initState() {
    isEnabaled = true;
    super.initState();
  }

  Future _handleSession(String secondary_officer) async {
    await FineService().setSessionToken(secondary_officer).then((res) async {
      if (res) {
        isEnabaled = true;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Okay"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Application.router.navigateTo(context, '/home');
                    },
                  )
                ],
              );
            });
      } else {
        isEnabaled = true;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
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

  final _sessionFormKey = new GlobalKey<FormState>();
  String secondary_officer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _sessionFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Text("Who are you with"),
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Supporting Police officer ID Number(Witness)",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    secondary_officer = value;
                  });
                },
                validator: (val) {
                  if (val.length == 0) {
                    return "Officer ID number cannot be empty";
                  }
                  if (val.length != 6) {
                    return "Invalid officer ID number";
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 50),
              RaisedButton(
                onPressed: () async {
                  if (isEnabaled) {
                    Logger().i("SEXY");
                    isEnabaled = false;
                    if (_sessionFormKey.currentState.validate()) {
                      _handleSession(secondary_officer);
                    }
                  } else {
                    return null;
                  }
                  //Logger().i("Result");
                },
                textColor: Colors.white,
                child: const Text('Create Sessionnnn',
                    style: TextStyle(fontSize: 20)),
                color: Colors.green,
              )
            ],
          )),
    );
  }
}
