import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"My profile",
      home: new Page(),
    );
  }

}

class Page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Profile"),
      ),
    );
  }

}


