import 'package:FPay/routes/application.dart';
import 'package:FPay/services/auth_service.dart';
import 'package:FPay/services/profile_service.dart';
import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  ChangePass(String officer);
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  bool isEnabled;

  @override
  void initState() {
    super.initState();
    isEnabled = true;
  }
   Future changePassword(String officer,String current_pass,String new_pass) async {
    // final form = _formKey.currentState;

    ProfService().changePass(officer,current_pass,new_pass).then((res) {
      if (res) {
        isEnabled = true;
        Application.router.navigateTo(context, '/home',clearStack: true);
      } else {
        isEnabled = true;
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

  static final _passFormKey = new GlobalKey<FormState>();
  String current_pass, new_pass, re_new_pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: _passFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 75,
              ),
              Text(
                "Change your password here",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              Center(
                  child: Container(
                      width: 320,
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            current_pass = value;
                          });
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return "Password cannot be empty";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Current Password",
                        ),
                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ))),
              SizedBox(
                height: 8,
              ),
              Center(
                  child: Container(
                      width: 320,
                      child: TextFormField(
                        obscureText: true,
                        //enabled: false,

                        onChanged: (value) {
                          setState(() {
                            new_pass = value;
                          });
                        },
                        validator: (val) {
                          String pattern =
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                          RegExp regExp = new RegExp(pattern);
                          bool validateStructure = regExp.hasMatch(val);
                          if (val.length == 0) {
                            return "Password cannot be empty";
                          } else if (val.length < 8) {
                            return "Password too short";
                          } else if (!validateStructure) {
                            return "please follow the constraints.\nMust include a capital letter,a number,a symbol and a \nlowercase letter.";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "New Password",
                        ),
                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ))),
              SizedBox(
                height: 8,
              ),
              Center(
                  child: Container(
                      width: 320,
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            re_new_pass = value;
                          });
                        },
                        validator: (val) {
                          if (re_new_pass != new_pass) {
                            return "Password doesn't match";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Re enter the New Password",
                        ),
                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ))),
              SizedBox(
                height: 18,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)),
                onPressed: () {
                  if(isEnabled){
                    if (_passFormKey.currentState.validate()) {
                    changePassword(officer,current_pass,new_pass);
                  }
                  }else{
                    return null;
                  }
                  
                },
                textColor: Colors.white,
                child: const Text('Change Password',
                    style: TextStyle(fontSize: 20)),
                color: Colors.red,
              ),
            ],
          ),
        ));
  }
}
