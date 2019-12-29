import 'package:FPay/routes/application.dart';
import 'package:FPay/services/auth_service.dart';
import 'package:FPay/services/fine_service.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class NewFine extends StatefulWidget {
  @override
  _NewFineState createState() => _NewFineState();
}

class _NewFineState extends State<NewFine> {
  final _fineFormKey = new GlobalKey<FormState>();
  String _officerId;
  String _driverId;
  String _witnessId;
  String _vehicleNo;
  List _fines;
  String fines;
  @override
  void initState() {
    super.initState();
    _fines = [];
    fines = '';
  }

  //List<String> fines = ["mdkalf", "fjdkj"];
  var penalty;
  Future _getId() async {
    Logger().i("got herer");
    FineService().getId().then((res) {
      Logger().i("got null");
      if (res) {
        Logger().i("Came here");
        Logger().i("$res");
        //_handleFineIssueed(_driver_id, _witness_id, _fines);
      } else if (res == false) {
        Logger().i("NULL");
      }
    });
  }

  File _image;

  Future getPhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future _handleFineIssueed(String _driverId, String _vehicleNo,
      String witnessId, List _fines) async {
    await FineService()
        .isuseFine(_driverId, _vehicleNo, witnessId, _fines)
        .then((res) async {
      if (res) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
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
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            child: SingleChildScrollView(
      child: Form(
        key: _fineFormKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Driver's Licenece Number",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              onChanged: (value) {
                _driverId = value;
              },
              validator: (val) {
                if (val.length != 8) {
                  return "Invalid driver's licence number";
                }
                if (val.length == 0) {
                  return "Driver's licence number cannot be null";
                }
              },
              //keyboardType: TextInputType.emailAddress,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Vehicle Number",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              onChanged: (value) {
                _vehicleNo = value;
              },
              validator: (val) {},
              //keyboardType: TextInputType.emailAddress,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Supporting Police officer ID Number(Witness)",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              onChanged: (value) {
                _witnessId = value;
              },
              validator: (val) {
                if (val.length == 0) {
                  return "Officer ID number cannot be null";
                }
                if (val.length != 6) {
                  return "Invalid officer ID number";
                }
              },
              keyboardType: TextInputType.emailAddress,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //       Container(
            //   padding: new EdgeInsets.all(32.0),
            //   child: new Center(
            //     child: new Column(
            //       children: <Widget>[
            //         new Checkbox(value: _value1, onChanged: _value1Changed),
            //         new CheckboxListTile(
            //             value: _value2,
            //             onChanged: _value2Changed,
            //             title: new Text('Hello World'),
            //             controlAffinity: ListTileControlAffinity.leading,
            //             subtitle: new Text('Subtitle'),
            //             secondary: new Icon(Icons.archive),
            //             activeColor: Colors.red,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // MultiSelect(
            //   autovalidate: false,
            //   titleText: "Fine list",
            //   validator: (value) {
            //     if (value == null) {
            //       Logger().i('$value');
            //       return 'Please select one or more option(s)';
            //     }
            //   },
            //   errorText: 'Please select one or more option(s)',
            //   dataSource: [
            //     {"display": "Fine No 1", "index": 1, "value": 5000},
            //     {"display": "Fine no 2", "index": 2, "value": 2500},
            //     {"display": "Fine no 3", "index": 3, "value": 1000},
            //     {"display": "Fine no 4", "index": 4, "value": 500}
            //   ],
            //   textField: 'display',
            //   valueField: 'index',
            //   filterable: true,
            //   required: true,
            //   value: null,
            //   onSaved: (values) {
            //     Logger().i('$values');
            //     _fines = values;
            //     print(_fines);
            //   },

            // ),
            MultiSelectFormField(
              autovalidate: false,
              titleText: 'Fines',
              validator: (value) {
                if (value == null || value.length == 0) {
                  return "please select one or more options";
                }
              },
              dataSource: [
                {
                  "display": "Fine No 1",
                  "index": 1,
                },
                {
                  "display": "Fine no 2",
                  "index": 2,
                },
                {
                  "display": "Fine no 3",
                  "index": 3,
                },
                {
                  "display": "Fine no 4",
                  "index": 4,
                }
              ],
              textField: 'display',
              valueField: 'index',
              okButtonLabel: 'Add',
              cancelButtonLabel: 'Cancel',
              hintText: 'please choose one or more',
              value: _fines,
              onSaved: (val) {
                if (val == null) {
                  Logger().i('val');
                  return;
                }

                setState(() {
                  _fines = val;
                  Logger().i('$val');
                });
              },
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Add supporting officer's photo"),
                IconButton(
                    icon: Icon(Icons.camera_alt),
                    tooltip: "Add a photo",
                    onPressed: () {
                      getPhoto();
                    }),
              ],
            ),

            RaisedButton(
              onPressed: () {
                //Logger().i("Result");
                if (_fineFormKey.currentState.validate()) {
                  //Logger().i("Result");
                  _getId();
                  _handleFineIssueed(_driverId, _vehicleNo, _witnessId, _fines);
                }
              },
              textColor: Colors.white,
              child: const Text('Issue Fine', style: TextStyle(fontSize: 20)),
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    )));
  }
}

class ViewFines extends StatefulWidget {
  @override
  _ViewFinesState createState() => _ViewFinesState();
}

class _ViewFinesState extends State<ViewFines> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            child: new SingleChildScrollView(
                child: Builder(
      builder: (context) => Form(
        //key: _formKey,
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

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  final _dashboardFormKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            child: SingleChildScrollView(
      child: Form(
        key: _dashboardFormKey,
        child: Column(
          children: <Widget>[
            BeautyTextfield(
              width: double.maxFinite,
              height: 200,
              //duration: Duration(milliseconds: 300),
              inputType: TextInputType.text,
              prefixIcon: Icon(Icons.person_outline),
              //suffixIcon: Icon(Icons.remove_red_eye),
              placeholder: "What is happening",
              onTap: () {
                print('Click');
              },
              onChanged: (text) {
                print(text);
              },
              onSubmitted: (data) {
                print(data.length);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.photo),
                        tooltip: "Add a photo",
                        onPressed: () {
                          setState(() {
                            getImage();
                          });
                        }),
                    Text("Add a photo"),
                  ],
                ),
                RaisedButton(
                  onPressed: () {},
                  child: const Text('Publish Post',
                      style: TextStyle(fontSize: 20)),
                )
              ],
            )
          ],
        ),
      ),
    )));
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future _handleLogout(BuildContext context) async {
    await AuthService().logout().then((res) async {
      Logger().i("true");
      if (res) {
        Application.router.navigateTo(context, '/', clearStack: true);
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                _handleLogout(context);
                //_handle();
              },
              textColor: Colors.white,
              child: const Text('Logout', style: TextStyle(fontSize: 20)),
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  //static _HomePageState obj = _HomePageState();

  List<Widget> _widgetOptions = <Widget>[
    NewFine(),
    ViewFines(),
    DashBoard(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            title: Text('New fine'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit), title: Text('View Fines')),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            title: Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
