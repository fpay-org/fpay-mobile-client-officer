import 'package:FPay/user.dart';
import 'package:flutter/material.dart';
import 'viewIssuedFines.dart';
import 'issueFine.dart';
import 'myProfile.dart';
import 'settings.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final _formKey = GlobalKey();
  final _user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: new SingleChildScrollView(
                child: Builder(
      builder: (context) => Form(
        key: _formKey,
        child: new Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'text'),
            ),
            DropdownButton<String>(
              items: <String>['A', 'B', 'C', 'D'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text("y"),
                );
              }).toList(),
              onChanged: (_) {},
            )
          ],
        ),
      ),
    ))));
  }
}
