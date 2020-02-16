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
  //Officer data;
  bool isEnabled;
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  String init_email;
  @override
  initState() {
    super.initState();
    isEnabled = true;
    details = ProfService().getDetails();

    details.then((goo) {
      Logger().i("is this good ${goo.email}");
      emailController.text = goo.email;
      // init_email = goo.email;
      contactController.text = goo.contact_number;
    }, onError: (e) {
      print(e);
    });
  }

  showDialogBox(String email, String contact_number) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter your password'),
            content: TextField(
              //controller: _textFieldController,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(hintText: "Current password"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CONTINUE'),
                onPressed: () {
                  editDetails(officer, first_name, last_name, email,
                      contact_number, nic, police_station, password);
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

  Future editDetails(
      String officer,
      String first_name,
      String last_name,
      String email,
      String contact_number,
      String nic,
      String police_station,
      String password) async {
    // final form = _formKey.currentState;
    ProfService()
        .editDetails(officer, first_name, last_name, email, contact_number, nic,
            police_station, password)
        .then((res) {
      if (res) {
        isEnabled = true;
        Application.router.navigateTo(context, '/home');
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

  static final _regFormKey = new GlobalKey<FormState>();
  String first_name, last_name, password, license_id, email, nic;
  String contact_number = "stupid";
  String officer, police_station;
  String new_email, new_contact;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: FutureBuilder(
              //future: ProfService().getDetails(),
              future: details,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  last_name = snapshot.data.last_name;
                  first_name = snapshot.data.first_name;
                  email = snapshot.data.email;
                  contact_number = snapshot.data.contact_number;
                  officer = snapshot.data.officer_id;
                  police_station = snapshot.data.police_station;
                  nic = snapshot.data.nic;

                  Logger().i('$last_name');
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
                                      initialValue: first_name,
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
                                      controller: emailController,
                                      //initialValue: emailController.text,
                                      obscureText: false,
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                          //Logger().i("SEXY SANKHA", email);
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
                                      controller: contactController,
                                      //initialValue: contact_number,
                                      obscureText: false,
                                      onChanged: (value) {
                                        setState(() {
                                          contact_number = value;
                                        });
                                        Logger().i(
                                            "New contact number", new_contact);
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
                                      readOnly: true,
                                      initialValue: nic,
                                      obscureText: false,
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

                            // Center(
                            //     child: Container(
                            //         width: 320,
                            //         child: TextFormField(
                            //           obscureText: false,
                            //           onChanged: (value) {
                            //             setState(() {
                            //               password = value;
                            //             });
                            //           },
                            //           validator: (val) {
                            //             String pattern =
                            //                 r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                            //             RegExp regExp = new RegExp(pattern);
                            //             bool validateStructure =
                            //                 regExp.hasMatch(val);
                            //             if (val.length == 0) {
                            //               return "Password cannot be empty";
                            //             } else if (val.length < 8) {
                            //               return "Password too short";
                            //             } else if (!validateStructure) {
                            //               return "please follow the constraints";
                            //             }
                            //           },
                            //           decoration: InputDecoration(
                            //             labelText:
                            //                 "New Password (min 8 characters)",
                            //             hintText:
                            //                 "one uppercase/lowercase/special character/number",
                            //             hintStyle: TextStyle(fontSize: 13),
                            //           ),
                            //           keyboardType: TextInputType.text,
                            //           style: new TextStyle(
                            //             fontFamily: "Poppins",
                            //           ),
                            //         ))),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Container(
                                    width: 320,
                                    child: TextFormField(
                                      initialValue: police_station,
                                      readOnly: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: "Police station",
                                        hintStyle: TextStyle(fontSize: 13),
                                      ),
                                      keyboardType: TextInputType.text,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ))),

                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.green)),
                              onPressed: () {
                                if(isEnabled){
                                  isEnabled = false;
                                  print(email);
                                Logger().i("SEXY", emailController.text);
                                if (_regFormKey.currentState.validate()) {
                                  showDialogBox(emailController.text, contactController.text);
                                }
                                }
                                else{
                                  return null;
                                }
                                
                              },
                              textColor: Colors.white,
                              child: const Text('Update Details',
                                  style: TextStyle(fontSize: 20)),
                              color: Colors.green,
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.orange)),
                              onPressed: () {
                                if(isEnabled){
                                  Application.router.navigateTo(context, '/pass/$officer');
                                }
                                
                              },
                              textColor: Colors.white,
                              child: const Text('Change Password',
                                  style: TextStyle(fontSize: 20)),
                              color: Colors.orange,
                            ),
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
