import 'package:FPay/routes/application.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static String _officer_id;
  static String _driver_id;
  static String _witness_id;
  static List _fines;
  
  static final _fineFormKey = new GlobalKey<FormState>();
  List<Widget> _widgetOptions = <Widget>[
    Scaffold(
        appBar: AppBar(
          title: Text("New Fine"),
        ),
        body: Container(
            child: SingleChildScrollView(
               child:Form(
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
                  onChanged: (value){
                      _driver_id = value;  
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
                    labelText: "Police officer ID Number(Witness)",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onChanged: (value){
                      _witness_id = value;  
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
                    titleText: "Select ",
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
                      _fines = value;
                    }),
                    SizedBox(
                  height: 50,
                ),
                    RaisedButton(
                onPressed: () {
                  if (_fineFormKey.currentState.validate()) {
                    //function
                  }
                },
                textColor: Colors.white,
                child: const Text('Issue Fine', style: TextStyle(fontSize: 20)),
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
