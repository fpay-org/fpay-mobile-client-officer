import 'package:FPay/routes/application.dart';
import 'package:FPay/services/fine_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _handleFineIssueed(
      String _driver_id, String _witness_id, List _fines) async {
    await FineService()
        .isuseFine(_officer_id, _driver_id, _witness_id, _fines)
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

  int _selectedIndex = 2;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  String _officer_id = "";
  String _driver_id = "";
  String _witness_id = "";
  List _fines = [];
  static _HomePageState obj = _HomePageState();
  static final _fineFormKey = new GlobalKey<FormState>();
  List<Widget> _widgetOptions = <Widget>[
    Scaffold(
        appBar: AppBar(
          title: Text("New Fine"),
        ),
        body: Container(
            child: SingleChildScrollView(
          child: Form(
            key: _fineFormKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
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
                    obj._driver_id = value;
                    //_driver_id = value;
                  },
                  validator: (val) {
                    if (val.length == 8) {
                      return "Invalid entry";
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
                   // _witness_id = value;
                  },
                  validator: (val) {
                    if (val.length == 0) {
                      return "Invalid entry";
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
                        return 'Please select one or more option(s)';
                      }
                    },
                    errorText: 'Please select one or more option(s)',
                    dataSource: [
                      {
                        "display": "Fine No 1",
                        "value": 1,
                      },
                      {
                        "display": "Fine no 2",
                        "value": 2,
                      },
                      {
                        "display": "Fine no 3",
                        "value": 3,
                      },
                      {
                        "display": "Fine no 4",
                        "value": 4,
                      }
                    ],
                    textField: 'display',
                    valueField: 'value',
                    filterable: true,
                    required: true,
                    value: null,
                    onSaved: (value) {
                      obj._fines = value;
                    }),
                SizedBox(
                  height: 50,
                ),
                RaisedButton(
                  onPressed: () {
                    //Logger().i("Result");
                    if (_fineFormKey.currentState.validate()) {
                      //Logger().i("Result");
                      _getId();
                      // _handleFineIssueed(_officer_id,_driver_id,_witness_id,_fines);

                    }
                  },
                  textColor: Colors.white,
                  child:
                      const Text('Issue Fine', style: TextStyle(fontSize: 20)),
                  color: Colors.redAccent,
                )
              ],
            ),
          ),
        ))),
    Scaffold(
        body: Container(
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
    )))),
    Text(
      'Index 2: Dashboard',
      //style: optionStyle,
    ),
    Scaffold(
      appBar: AppBar(
        title: new Text("Profile"),
      ),
      body: Column(
        children: <Widget>[
          prefix0.SizedBox(
            height: 100,
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                _handleLogout();
                //_handle();
              },
              textColor: Colors.white,
              child: const Text('Logout', style: TextStyle(fontSize: 20)),
              color: Colors.red,
            ),
          )
        ],
      ),
    )
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

void _handleLogout() {}

Future _getId() async {
  Logger().i("got herer");
  FineService().getId().then((res) {
    //Logger().i("got null");
    if (res) {
      Logger().i("$res");
      //_handleFineIssueed(res, _driver_id, _witness_id, _fines)
    } else if (res == false) {
      Logger().i("NULL");
    }
  });
}
