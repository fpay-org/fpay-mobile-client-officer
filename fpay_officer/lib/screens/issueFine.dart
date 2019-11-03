import 'package:flutter/material.dart';

class IssueFines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Issue a new fine",
      home: new Page(),
    );
  }
}

class Page extends StatelessWidget {
  final _formKey = GlobalKey();
  //final _user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("New Fine"),
        ),
        body: Container(
            child: new SingleChildScrollView(
                child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                SizedBox(height: 20,),
                TextFormField(
                  decoration: new InputDecoration(
                        labelText: "Fine Id",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if(val.length==0) {
                          return "Email cannot be empty";
                        }else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: new InputDecoration(
                        labelText: "Enter Email",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if(val.length==0) {
                          return "Email cannot be empty";
                        }else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                ),
                SizedBox(height: 20,),
                
                DropdownButton<String>(
                  disabledHint: Text("Select the fine"),
                  isExpanded: true,
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
