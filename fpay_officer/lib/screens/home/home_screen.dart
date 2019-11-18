import 'package:FPay/routes/application.dart';
import 'package:FPay/screens/home/tasks/issueFine.dart';
import 'package:FPay/services/auth_service.dart';
import 'package:FPay/services/fine_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:dropdownfield/dropdownfield.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class NewFine extends StatefulWidget {
  @override
  _NewFineState createState() => _NewFineState();
}

class _NewFineState extends State<NewFine> {
  final _fineFormKey = new GlobalKey<FormState>();
  String _officer_id;
  String _driver_id;
  String _witness_id;
  List<int> _fines;
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

  Future _handleFineIssueed(
      String _driver_id, String _witness_id, List _fines) async {
    await FineService()
        .isuseFine(_driver_id, _witness_id, _fines)
        .then((res) async {
      if (res) {
        showDialog(
            context: null,
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
            context: null,
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
                _driver_id = value;
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
                labelText: "Supporting Police officer ID Number(Witness)",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              onChanged: (value) {
                _witness_id = value;
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
            MultiSelect(
              autovalidate: false,
              titleText: "Fine list",
              validator: (value) {
                if (value == null) {
                  Logger().i('$value');
                  return 'Please select one or more option(s)';
                }
              },
              errorText: 'Please select one or more option(s)',
              dataSource: [
                {"display": "Fine No 1", "index": 1, "value": 5000},
                {"display": "Fine no 2", "index": 2, "value": 2500},
                {"display": "Fine no 3", "index": 3, "value": 1000},
                {"display": "Fine no 4", "index": 4, "value": 500}
              ],
              textField: 'display',
              valueField: 'index',
              filterable: true,
              required: true,
              value: null,
              change: (values) {
                Logger().i('gooooooo');
                _fines = values;
                print(_fines);
              },
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: () {
                //Logger().i("Result");
                if (_fineFormKey.currentState.validate()) {
                  //Logger().i("Result");
                  _getId();
                  _handleFineIssueed(_driver_id, _witness_id, penalty);
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
  @override
  Widget build(BuildContext context) {
    return Text(
      'Index 2: Dashboard',
      //style: optionStyle,
    );
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
  int _selectedIndex = 2;
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
