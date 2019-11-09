import 'package:FPay/routes/application.dart';
import 'package:FPay/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          //'/issueFine': (BuildContext) => new IssueFines(),
        },
        debugShowCheckedModeBanner: false,
        title: 'ListViews',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Page());
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => new _PageState();
}

class _PageState extends State<Page> {
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10),
        child: Column(
          children: <Widget>[
            //SizedBox(height: 20.0),
            //SizedBox(height: 20.0),
            //Spacer(),
            Container(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
                color: Colors.white,
                child: new Container(
                  child: new Center(
                      child: new Column(children: [
                    new Padding(padding: EdgeInsets.only(top: 165.0)),
                    /*new Text('Beautiful Flutter TextBox',
                       style: new TextStyle(color: Colors.blue, fontSize: 25.0),),*/
                    new Padding(padding: EdgeInsets.only(top: 10.0)),
                    new TextFormField(
                      //obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      // controller: myControllerId,
                      // onSaved: (input) => userId = input,
                      decoration: new InputDecoration(
                        labelText: "User ID",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "User ID cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ])),
                )),
            Container(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10),
                color: Colors.white,
                child: new Container(
                  child: new Center(
                      child: new Column(children: [
                    new Padding(padding: EdgeInsets.only(top: 0.0)),
                    /*new Text('Beautiful Flutter TextBox',
                       style: new TextStyle(color: Colors.blue, fontSize: 25.0),),*/
                    new Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0)),
                    new TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      //controller: myControllerPass,
                      //onSaved: (input) => password = input,
                      decoration: new InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "User ID cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ])),
                )),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: () => _handleLogin(_email, _password),
              textColor: Colors.white,
              child: const Text('Login', style: TextStyle(fontSize: 20)),
              color: Colors.lightBlue,
            )
          ],
        ),
      ),
    );
  }

  void _handleLogin(String email, String password) {
    AuthService().login(email, password).then((res) {
      if (res)
        // TODO: Set path here
        Application.router.navigateTo(context, '');
      else {
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
