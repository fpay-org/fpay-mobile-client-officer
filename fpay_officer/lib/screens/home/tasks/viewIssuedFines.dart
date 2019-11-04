import 'package:FPay/user.dart';
import 'package:flutter/material.dart';
import 'viewIssuedFines.dart';
import 'issueFine.dart';
import 'myProfile.dart';
import 'settings.dart';
import 'package:flutter/material.dart';

// class ViewIssuedFines extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'ListViews',
//         theme: ThemeData(
//           primarySwatch: Colors.teal,
//         ),
//         home: Page());
//   }
// }

class ViewIssuedFines extends StatefulWidget {
  @override
  _ViewIssuedFinesState createState() => new _ViewIssuedFinesState();
}

class _ViewIssuedFinesState extends State<ViewIssuedFines> {
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
