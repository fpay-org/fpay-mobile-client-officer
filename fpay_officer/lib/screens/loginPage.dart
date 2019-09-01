import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "login",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("appbar")
        ),
      ),
    );
  }
  
}