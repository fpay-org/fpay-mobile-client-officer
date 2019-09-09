import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'regPage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true, title: "login", home: new Page());
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
            child: Column(children: <Widget>[
          Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
              color: Colors.white,
              child: new Container(
                child: new Center(
                    child: new Column(children: [
                  new Padding(padding: EdgeInsets.only(top: 165.0)),
                  /*new Text('Beautiful Flutter TextBox',
                       style: new TextStyle(color: Colors.blue, fontSize: 25.0),),*/
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  new TextFormField(
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
          RaisedButton(
            onPressed: () {
              navigateToRegPage(context);
            },
            textColor: Colors.white,
            child: const Text('Login', style: TextStyle(fontSize: 20)),
            color: Colors.lightBlue,
          ),
        ])));
  }
}

Future navigateToRegPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => RegPage()));
}
