import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        title: "login",
        home: new Material(
            child: Column(
          children: <Widget>[
            Expanded(
                child: new Container(
                    padding: const EdgeInsets.all(30.0),
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
                    ))),
            Expanded(
                child: new Container(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    color: Colors.white,
                    child: new Container(
                      child: new Center(
                          child: new Column(children: [
                        new Padding(padding: EdgeInsets.only(top: 0.0)),
                        /*new Text('Beautiful Flutter TextBox',
                       style: new TextStyle(color: Colors.blue, fontSize: 25.0),),*/
                        new Padding(padding: EdgeInsets.only(left: 30.0, right: 30.0)),
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
                    )))
                    Expanded(
                      child: RaisedButton(
                        
                      ),
                    )
          ],
        )));
  }
}
