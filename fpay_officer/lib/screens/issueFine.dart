import 'package:flutter/material.dart';

class IssueFines extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Issue a new fine",
      home: new Page(),
    );
  }

}

class Page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("New Fine"),
      ),
    );
  }

}
