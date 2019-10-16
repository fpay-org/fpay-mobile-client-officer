import 'package:flutter/material.dart';

class ViewIssuedFines extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"View fines",
      home: new Page(),
    );
  }

}

class Page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("View Fines"),
      ),
    );
  }

}
