import 'package:FPay/config/config.dart';
import 'package:FPay/routes/application.dart';
import 'package:FPay/services/auth_service.dart';
import 'package:FPay/services/fine_service.dart';
import 'package:FPay/services/post_service.dart';
import 'package:FPay/services/profile_service.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:image_picker/image_picker.dart';
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
  bool isEnabaled;
  final _fineFormKey = new GlobalKey<FormState>();
  //String officer,
  String secondary_officer,
      vehicle_licence_number,
      officer_avatar_url,
      driver_nid;
  // String _driverId;
  // String _witnessId;
  // String _vehicleNo;
  List penalties;
  String fines;
  String officer;
  @override
  void initState() {
    super.initState();
    isEnabaled = true;
    penalties = [];
    fines = '';
    Logger().i("njdnvjkdnkn:::$officer");
  }

  //List<String> fines = ["mdkalf", "fjdkj"];
  var penalty;
  Future<String> _getId() async {
    Logger().i("got herer");
    return FineService().getId().then((res) {
      if (res != null) {
        Logger().i("Came here");
        Logger().i("$res");
        return res;
        //_handleFineIssueed(_driver_id, _witness_id, _fines);
      } else if (res == null) {
        Logger().i("chora");
      }
    });
  }

  File image;
  String image_path;
  Future getPhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      image = image;
      image_path = image.path;
    });
  }

  Future _handleFineIssueed(
      String officer,
      String driver_nid,
      String vehicle_license_number,
      String secondary_officer,
      List penalties,
      String image_path) async {
    await FineService()
        .isuseFine(officer, driver_nid, vehicle_license_number,
            secondary_officer, penalties, image_path)
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
                      Application.router.navigateTo(context, '/home');
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
                setState(() {
                  driver_nid = value;
                });
              },
              validator: (val) {
                // if (val.length != 8) {
                //   return "Invalid driver's licence number";
                // }
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
                setState(() {
                  vehicle_licence_number = value;
                });
              },
              validator: (val) {
                if (val.length == 0) {
                  return "Vehicle number cannot be null";
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
                setState(() {
                  secondary_officer = value;
                });
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
                  "index": "1",
                },
                {
                  "display": "Fine no 2",
                  "index": "2",
                },
                {
                  "display": "Fine no 3",
                  "index": "3",
                },
                {
                  "display": "Fine no 4",
                  "index": "4",
                }
              ],
              textField: 'display',
              valueField: 'index',
              okButtonLabel: 'Add',
              cancelButtonLabel: 'Cancel',
              hintText: 'please choose one or more',
              value: penalties,
              onSaved: (val) {
                if (val == null) {
                  Logger().i('val');
                  return;
                }

                setState(() {
                  penalties = val;
                  //penalties.map((_) => _.toString());
                  Logger().i('$penalties');
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
              onPressed: () async {
                if (isEnabaled) {
                  isEnabaled = false;
                  if (_fineFormKey.currentState.validate()) {
                    //Logger().i("Result");
                    Logger().i('mklanfddknaknkl:::::');

                    _getId().then((officer) {
                      if (officer != null) {
                        _handleFineIssueed(
                            officer,
                            driver_nid,
                            vehicle_licence_number,
                            secondary_officer,
                            penalties,
                            image_path);
                      }
                    });
                    isEnabaled = true;
                    
                  }
                } else {
                  return null;
                }
                //Logger().i("Result");
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
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //       child: Container(
  //           child: new SingleChildScrollView(
  //               child: Builder(
  //     builder: (context) => Form(
  //       //key: _formKey,
  //       child: new Column(
  //         children: <Widget>[
  //           TextFormField(
  //             decoration: InputDecoration(labelText: 'text'),
  //           ),
  //           DropdownButton<String>(
  //             items: <String>['A', 'B', 'C', 'D'].map((String value) {
  //               return new DropdownMenuItem<String>(
  //                 value: value,
  //                 child: new Text("y"),
  //               );
  //             }).toList(),
  //             onChanged: (_) {},
  //           )
  //         ],
  //       ),
  //     ),
  //   ))));
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FineService().getFines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          Logger().i("snap");
          Logger().i("snap-null: ${snapshot.data}");
          return Container(
            child: Center(
              child: Text("Loading..."),
            ),
          );
        } else {
          Logger().i("snapshotttttt: ${snapshot.data[0].fineId}");
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  "Fine ID: ${snapshot.data[index].fineId}",
                ),
                subtitle: Text(
                  "Value: ${snapshot.data[index].fineValue}",
                ),
                trailing: RaisedButton(
                  onPressed: () {
                    Application.router.navigateTo(
                        context, '/pay/${snapshot.data[index].fineId}');
                  },
                  child: Text("Pay"),
                  color: Colors.green,
                ),
              );
            },
          );
        }
      },

      // Card(
      //   Row(children: <Widget>[
      //     Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       const ListTile(
      //         title: Text('Fine ID: 3265'),
      //         title: Text("${snapshot.data[index].fineId}"
      //       ),
      //     ],),
      //     RaisedButton(
      //       onPressed: () {},
      //     )

      //   ],)
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       const ListTile(
      //         title: Text('Fine ID: 3265'),
      //         subtitle: Text('Fines: Crossing double line\novertaking on pedestrian crossing'),
      //       ),
      //     ],
      //   ),
      // )
    );
  }
}

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  File _image;
  String content;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<String> getId() async {
    Logger().i("got herer");
    return FineService().getId().then((res) {
      if (res != null) {
        Logger().i("Came here");
        Logger().i("$res");
        return res;
        //_handleFineIssueed(_driver_id, _witness_id, _fines);
      } else if (res == null) {
        Logger().i("chora");
      }
    });
  }

    Future publishPost(String content,String officer) async {
    await PostService()
        .publish(content,officer)
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
                      Application.router.navigateTo(context, '/home');
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
              //isShadow: false,
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
                  onPressed: () {
                    //sendPhoto(_image);
                    getId().then((officer) {
                      if (officer != null) {
                        publishPost(content,officer);
                      }
                    });
                  },
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

  sendPhoto(File _image) async {
    FormData data = FormData.fromMap({
      "officer_image": [
        await MultipartFile.fromFile(_image.path,
            filename: "Sankhaabcdefghijklmnopqrst.jpg")
      ]
    });
    Logger().i("${_image.path}");
    return Dio()
        .post('https://fpay-server.herokuapp.com/v1/fines/upload', data: data)
        .then((res) async {
      if (res.statusCode == 201) {
        return true;
      }
      return false;
    }).catchError((err) {
      Logger().i("$err");
      return false;
    });
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<Officer> details;

  @override
  initState() {
    super.initState();
    Logger().i("paa");
    details = _handleDetails();
    Logger().i("${details}");
    Logger().i("paa");
  }

  Future<Officer> _handleDetails() async {
    return await ProfService().getDetails();
  }

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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl =
        'https://pixel.nymag.com/imgs/daily/selectall/2017/12/26/26-eric-schmidt.w700.h700.jpg';
    TextStyle _style() {
      return TextStyle(
        //color:
        fontWeight: FontWeight.bold,
      );
    }

    //Image.network(imgUrl, fit: BoxFit.fill,),
    // BackdropFilter(
    //     filter: ui.ImageFilter.blur(
    //       sigmaX: 6.0,
    //       sigmaY: 6.0,
    //     ),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.all(Radius.circular(50.0)),
    //       ),
    //     )),
    return SingleChildScrollView(
        //drawer: Drawer(child: Container(),),
        //backgroundColor: Colors.transparent,

        child: FutureBuilder(
            future: details,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: <Widget>[
                  SizedBox(
                    height: _height / 12,
                  ),
                  CircleAvatar(
                    radius: _width < _height ? _width / 4 : _height / 4,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                  SizedBox(
                    height: _height / 25.0,
                  ),
                  Text(
                    '${snapshot.data.first_name} ${snapshot.data.last_name}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 15,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _height / 30, left: _width / 8, right: _width / 8),
                    // child:Text('Snowboarder, Superhero and writer.\nSometime I work at google as Executive Chairman ',
                    //   style: TextStyle(fontWeight: FontWeight.normal, fontSize: _width/25,color: Colors.white),textAlign: TextAlign.center,)
                  ),
                  // Divider(
                  //   height: _height / 30,
                  //   color: Colors.white,
                  // ),
                  // Row(
                  //   children: <Widget>[
                  //     rowCell(343, 'POSTS'),
                  //     rowCell(673826, 'FOLLOWERS'),
                  //     rowCell(275, 'FOLLOWING'),
                  //   ],
                  // ),
                  Divider(height: _height / 30, color: Colors.white),
                  Column(
                    children: <Widget>[
                      Text("Officer ID"),
                      Text('${snapshot.data.officer_id}', style: _style()),
                      SizedBox(
                        height: _height / 25.0,
                      ),
                      // Text("Email"),
                      // Text("cazci@gmail.com", style: _style()),
                      // SizedBox(
                      //   height: _height / 25.0,
                      // ),
                      // Text("Driver's Licence No"),
                      // Text('${snapshot.data.license_number}', style: _style()),
                      // SizedBox(
                      //   height: _height / 25.0,
                      // ),
                      // Text("Contact No"),
                      // Text('${snapshot.data.contact_number}', style: _style()),
                      SizedBox(
                        height: _height / 25.0,
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: _width / 8, right: _width / 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            _handleLogout(context);
                            //_handle();
                          },
                          textColor: Colors.white,
                          child: const Text('Logout',
                              style: TextStyle(fontSize: 20)),
                          color: Colors.red,
                        ),
                        RaisedButton(
                          onPressed: () {
                            Application.router.navigateTo(context, "/edit");
                          },
                          textColor: Colors.white,
                          child: const Text('Edit Details',
                              style: TextStyle(fontSize: 20)),
                          color: Colors.orange,
                        )
                      ],
                    ),
                  ),
                ]);
              } else {
                Logger().i("jblbnllnlk:::: $snapshot");
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              }
            }));
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
