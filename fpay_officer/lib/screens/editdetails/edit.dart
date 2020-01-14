import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditDetails extends StatefulWidget {
  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  static final _regFormKey = new GlobalKey<FormState>();
  String first_name, last_name, password, license_id, email;
  String mobile_no, nid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Welcome to FPay",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Form(
                key: _regFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                        child: Container(
                            width: 320,
                            child: TextFormField(
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  first_name = value;
                                });
                              },
                              validator: (val) {
                                if (val.length == 0) {
                                  return "First name cannot be empty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "First Name",
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
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  last_name = value;
                                });
                              },
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Last name cannot be empty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Last Name",
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
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              validator: (val) {
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val);
                                if (val.length == 0) {
                                  return "Email cannot be empty";
                                }
                                if (!emailValid) {
                                  return "Not a valid email";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Email",
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
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  mobile_no = value;
                                });
                              },
                              validator: (val) {
                                bool isNumeric(String s) {
                                  if (s == null) {
                                    return false;
                                  }
                                  return double.tryParse(s) != null;
                                }

                                if (val.length == 0) {
                                  return "Mobile number cannot be empty";
                                } else if (val.length != 10 ||
                                    !isNumeric(val)) {
                                  return "Invalid mobile number";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Mobile Number",
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
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  license_id = value;
                                });
                              },
                              validator: (val) {
                                if (val.length == 0) {
                                  return "License number cannot be empty";
                                } else if (val.length != 8) {
                                  return "Invalid license number";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "License ID",
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
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  nid = value;
                                });
                              },
                              validator: (val) {
                                if (val.length == 0) {
                                  return "NIC cannot be empty";
                                } else if (val.length != 10) {
                                  return "Not a valid NIC number";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "NIC Number",
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
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  password = value;
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
                                  return "please follow the constraints";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Password (min 8 characters)",
                                hintText:
                                    "one uppercase/lowercase/special character/number",
                                hintStyle: TextStyle(fontSize: 13),
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green)),
                      onPressed: () {
                        if (_regFormKey.currentState.validate()) {
                          _handleRegistration(nid, first_name, last_name, email,
                              mobile_no, license_id, password);
                        }
                      },
                      textColor: Colors.white,
                      child: const Text('Register',
                          style: TextStyle(fontSize: 20)),
                      color: Colors.green,
                    )
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  Future _handleRegistration(
      String nid,
      String first_name,
      String last_name,
      String email,
      String contact_number,
      String license_number,
      String password) async {
    final form = _regFormKey.currentState;
  }

}