import 'package:FPay/routes/application.dart';
import 'package:FPay/services/profile_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class EditDetails extends StatefulWidget {
  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  Future<Officer> details;
  bool isEnabled = true;
  @override
  initState() {
    super.initState();
    Logger().i("paa");
    //details = _handleDetails();
    Logger().i("helloowwww$details");
    Logger().i("paa");
  }

    Future editDetails(String officer,String new_password,String old_password,String email,String mobile_no,String nid) async {
    // final form = _formKey.currentState;
      ProfService().editDetails(officer,new_password,old_password,email,mobile_no,nid).then((res) {
      if (res) {
        Application.router.navigateTo(context, '/home');
      } else {
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
    isEnabled = true;
  }

  static final _regFormKey = new GlobalKey<FormState>();
  String first_name, last_name, password, license_id, email;
  String mobile_no, nid;
  String officer,old_password;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: ProfService().getDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String last_name = snapshot.data.last_name;
                  String first_name = snapshot.data.first_name;
                  //String email = snapshot.data.email;
                  //String mobile_no = snapshot.data.mobile_no;
                  String officer = snapshot.data.officer_id;
                  return Column(children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Edit your details here",
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
                                      //enabled: false,
                                      readOnly: true,
                                      initialValue:first_name,
                                      // onChanged: (value) {
                                      //   setState(() {
                                      //     email = value;
                                      //   });
                                      // },
                                      // validator: (val) {
                                      //   bool emailValid = RegExp(
                                      //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      //       .hasMatch(val);
                                      //   if (val.length == 0) {
                                      //     return "Email cannot be empty";
                                      //   }
                                      //   if (!emailValid) {
                                      //     return "Not a valid email";
                                      //   }
                                      // },
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
                                      initialValue: last_name,
                                      readOnly: true,
                                      // onChanged: (value) {
                                      //   setState(() {
                                      //     email = value;
                                      //   });
                                      // },
                                      // validator: (val) {
                                      //   bool emailValid = RegExp(
                                      //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      //       .hasMatch(val);
                                      //   if (val.length == 0) {
                                      //     return "Email cannot be empty";
                                      //   }
                                      //   if (!emailValid) {
                                      //     return "Not a valid email";
                                      //   }
                                      // },
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
                                      initialValue: officer,
                                      readOnly: true,
                                      obscureText: false,
                                      onChanged: (value) {
                                        setState(() {
                                          officer = value;
                                        });
                                      },
                                      validator: (val) {
                                        if (val.length == 0) {
                                          return "Officer id cannot be empty";
                                        } else if (val.length != 6) {
                                          return "Invalid officer id number";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Officer ID",
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
                                      initialValue: null,
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
                                        bool validateStructure =
                                            regExp.hasMatch(val);
                                        if (val.length == 0) {
                                          return "Password cannot be empty";
                                        } else if (val.length < 8) {
                                          return "Password too short";
                                        } else if (!validateStructure) {
                                          return "please follow the constraints";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        labelText:
                                            "New Password (min 8 characters)",
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
                                if (!_regFormKey.currentState.validate()) {
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Enter your current password'),
                                          content: TextField(
                                            //controller: _textFieldController,
                                            onChanged: (value) {
                                        setState(() {
                                          old_password = value;
                                        });
                                      },
                                            decoration: InputDecoration(
                                                hintText: "Current password"),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('CONTINUE'),
                                              onPressed: () {
                                                
                                              },
                                            ),
                                            FlatButton(
                                              child: Text('CANCEL'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });
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
                  ]);
                } else {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                }
              }),
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
