import 'package:FPay/config/config.dart';
import 'package:FPay/routes/application.dart';
import 'package:FPay/services/auth_service.dart';
import 'package:FPay/services/fine_service.dart';
import 'package:FPay/services/post_service.dart';
import 'package:FPay/services/profile_service.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

  Future<File> image;
  String image_path;
  Future getPhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
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
        isEnabaled = true;
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
        isEnabaled = true;
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

  Widget showImage() {
    return FutureBuilder<File>(
      future: image,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
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
                  return "Driver's licence number cannot be empty";
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
                  return "Vehicle number cannot be empty";
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
                  return "Officer ID number cannot be empty";
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
                  "display": "Identification plates",
                  "index": "1",
                },
                {
                  "display": "Not carrying revenue licence",
                  "index": "2",
                },
                {
                  "display": "Contraventing revenue licence provisions",
                  "index": "3",
                },
                {
                  "display":
                      "Driving emergency service vehicles & public service vehicle without driving licence",
                  "index": "4",
                },
                {
                  "display":
                      "Driving special purpose vehicles without a licence",
                  "index": "5",
                },
                {
                  "display":
                      "Driving a vehicle loaded with chemicals/hazardous waste without a licence",
                  "index": "6",
                },
                {
                  "display":
                      "Not having a licence to drive a specific class of vehicles",
                  "index": "7",
                },
                {
                  "display": "Not carrying a driving licence",
                  "index": "8",
                },
                {
                  "display": "Not having an instructor's licence",
                  "index": "9",
                },
                {
                  "display": "Contravening speed limit",
                  "index": "10",
                },
                {
                  "display": "Disobeying road rules",
                  "index": "11",
                },
                {
                  "display":
                      "Activities obstructing control of the motor vehicle",
                  "index": "12",
                },
                {
                  "display": "Signals by driver",
                  "index": "13",
                },
                {
                  "display": "Reversing for a long distance",
                  "index": "14",
                },
                {
                  "display": "Sound or light warnings",
                  "index": "15",
                },
                {
                  "display": "Excessive emmision of smoke. etc",
                  "index": "16",
                },
                {
                  "display": "Riding on running boards",
                  "index": "17",
                },
                {
                  "display": "No of persons in front seats",
                  "index": "18",
                },
                {
                  "display": "",
                  "index": "19",
                },
                {
                  "display": "Not wearing protective helmets",
                  "index": "20",
                },
                {
                  "display": "Distribution of advertisements",
                  "index": "21",
                },
                {
                  "display": "Excessive use of noice",
                  "index": "22",
                },
                {
                  "display":
                      "Disobeying directions & signals of police officers/Trafic wardens",
                  "index": "23",
                },
                {
                  "display": "non compliance with traffic signals",
                  "index": "24",
                },
                {
                  "display":
                      "failure to take precautions when discharging fuel into tank",
                  "index": "25",
                },
                {
                  "display": "Halting or parking",
                  "index": "26",
                },
                {
                  "display": "Non use of precaution when parking",
                  "index": "27",
                },
                {
                  "display":
                      "Excessive carriage of persons in motor car or private coach",
                  "index": "28",
                },
                {
                  "display": "Carriage of passengers in excess in buses",
                  "index": "29",
                },
                {
                  "display":
                      "Carriage on lorry or motor tricycle van of goods in excess",
                  "index": "30",
                },
                {
                  "display":
                      "Carriage on lorry or motor tricycle van of goods in excess",
                  "index": "30",
                },
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
                //showImage(),
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
                    if (isEnabaled) {
                      //Logger().i("Result");
                      Logger().i('mklanfddknaknkl:::::');
                      isEnabaled = false;
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
                    }

                    //isEnabaled = true;
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
                // trailing: RaisedButton(
                //   onPressed: () {
                //     Application.router.navigateTo(
                //         context, '/pay/${snapshot.data[index].fineId}');
                //   },
                //   child: Text("Pay"),
                //   color: Colors.green,
                // ),
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
  bool isEnabled;
  @override
  void initState() {
    super.initState();
    isEnabled = true;
  }

  File _image;
  String content, title;
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

  Future publishPost(String officer, String content, String title) async {
    await PostService().publishPost(officer, content, title).then((res) async {
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
        isEnabled = true;
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
        isEnabled = true;
      }
    });
  }

  final _dashboardFormKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final String imgUrl =
        'https://pixel.nymag.com/imgs/daily/selectall/2017/12/26/26-eric-schmidt.w700.h700.jpg';
    // return Container(
    //     child: Container(
    //   child: Form(
    //     key: _dashboardFormKey,
    //     child: Column(
    //       children: <Widget>[
    //         BeautyTextfield(
    //           //isShadow: false,
    //           width: double.maxFinite,
    //           height: 300,
    //           //duration: Duration(milliseconds: 300),
    //           inputType: TextInputType.text,
    //           prefixIcon: Icon(Icons.person_outline),
    //           //suffixIcon: Icon(Icons.remove_red_eye),
    //           placeholder: "What is happening",
    //           onTap: () {
    //             print('Click');
    //           },
    //           onChanged: (text) {
    //             print(text);
    //           },
    //           onSubmitted: (data) {
    //             print(data.length);
    //           },
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: <Widget>[
    //             Column(
    //               children: <Widget>[
    //                 IconButton(
    //                     icon: Icon(Icons.photo),
    //                     tooltip: "Add a photo",
    //                     onPressed: () {
    //                       setState(() {
    //                         getImage();
    //                       });
    //                     }),
    //                 Text("Add a photo"),
    //               ],
    //             ),
    //             RaisedButton(
    //               onPressed: () {
    //                 //sendPhoto(_image);
    //                 getId().then((officer) {
    //                   if (officer != null) {
    //                     publishPost(content, officer);
    //                   }
    //                 });
    //               },
    //               child: const Text('Publish Post',
    //                   style: TextStyle(fontSize: 20)),
    //             )
    //           ],
    //         ),
    //         Divider(
    //           color: Colors.black,
    //           indent: 10,
    //           endIndent: 10,
    //           thickness: 1,
    //         ),
    //         SingleChildScrollView(
    //           child: FutureBuilder(
    //             future: FineService().getFines(),
    //             builder: (BuildContext context, AsyncSnapshot snapshot) {
    //               if (snapshot.data == null) {
    //                 Logger().i("snap");
    //                 Logger().i("snap-null: ${snapshot.data}");
    //                 return Container(
    //                   child: Center(
    //                     child: Text("Loading..."),
    //                   ),
    //                 );
    //               } else {
    //                 Logger().i("snapshotttttt: ${snapshot.data[0].fineId}");
    //                 return ListView.builder(
    //                   shrinkWrap: true,
    //                   itemCount: snapshot.data.length,
    //                   itemBuilder: (BuildContext context, int index) {
    //                     return ListTile(
    //                       title: Text(
    //                         "Fine ID: ${snapshot.data[index].fineId}",
    //                       ),
    //                       subtitle: Text(
    //                         "Value: ${snapshot.data[index].fineValue}",
    //                       ),
    //                       trailing: RaisedButton(
    //                         onPressed: () {
    //                           Application.router.navigateTo(context,
    //                               '/pay/${snapshot.data[index].fineId}');
    //                         },
    //                         child: Text("Pay"),
    //                         color: Colors.green,
    //                       ),
    //                     );
    //                   },
    //                 );
    //               }
    //             },

    //             // Card(
    //             //   Row(children: <Widget>[
    //             //     Column(
    //             //     mainAxisSize: MainAxisSize.min,
    //             //     children: <Widget>[
    //             //       const ListTile(
    //             //         title: Text('Fine ID: 3265'),
    //             //         title: Text("${snapshot.data[index].fineId}"
    //             //       ),
    //             //     ],),
    //             //     RaisedButton(
    //             //       onPressed: () {},
    //             //     )

    //             //   ],)
    //             //   child: Column(
    //             //     mainAxisSize: MainAxisSize.min,
    //             //     children: <Widget>[
    //             //       const ListTile(
    //             //         title: Text('Fine ID: 3265'),
    //             //         subtitle: Text('Fines: Crossing double line\novertaking on pedestrian crossing'),
    //             //       ),
    //             //     ],
    //             //   ),
    //             // )
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // ));
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          Text(
            "Write post",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 20),
          BeautyTextfield(
            //isShadow: false,
            width: double.maxFinite,
            height: 50,
            //duration: Duration(milliseconds: 300),
            inputType: TextInputType.text,
            prefixIcon: Icon(Icons.work),
            //suffixIcon: Icon(Icons.remove_red_eye),
            placeholder: "Enter title",
            onTap: () {
              print('Click');
            },
            onChanged: (text) {
              title = text;
            },
          ),
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
              content = text;
            },
          ),
          SizedBox(height: 10),
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
                  if (isEnabled) {
                    getId().then((officer) {
                      if (officer != null) {
                        isEnabled = false;
                        publishPost(officer, content, title);
                      }
                    });
                  } else {
                    return null;
                  }
                  //sendPhoto(_image);
                },
                child:
                    const Text('Publish Post', style: TextStyle(fontSize: 20)),
              )
            ],
          ),
          Divider(
            color: Colors.black,
            indent: 10,
            endIndent: 10,
            thickness: 1,
          ),
          FutureBuilder(
              future: PostService().getPosts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  Logger().i("snap");
                  Logger().i("snap-null: ${snapshot.data}");
                  return Container(
                    child: Center(
                      child: Text("here..."),
                    ),
                  );
                } else {
                  Logger().i("snapshotttttt: ${snapshot.data[0].first_name}");

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return ListTile(
                      //   leading: CircleAvatar(
                      //     backgroundImage: NetworkImage(""),
                      //   ),
                      //   title: Text(
                      //     "Fine ID: ${snapshot.data[index].fineId}",
                      //   ),
                      //   subtitle: Text(
                      //     "Value: ${snapshot.data[index].fineValue}",
                      //   ),
                      //   trailing: RaisedButton(
                      //     onPressed: () {
                      //       Application.router.navigateTo(
                      //           context, '/pay/${snapshot.data[index].fineId}');
                      //     },
                      //     child: Text("Pay"),
                      //     color: Colors.green,
                      //   ),
                      // );
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(imgUrl),
                          ),
                          title: Text("${snapshot.data[index].title}"),
                          subtitle: Column(
                            children: <Widget>[
                              Text(
                                "${snapshot.data[index].content}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                "By ${snapshot.data[index].first_name} ${snapshot.data[index].last_name} at 2017-02-14 at 9.30 am",
                                style: TextStyle(fontSize: 8),
                              )
                            ],
                          ),
                          //Text(),
                          trailing: Icon(Icons.more_vert),
                          isThreeLine: true,
                        ),
                      );
                    },
                  );
                }
              })
        ],
      ),
    ));
  }

  // sendPhoto(File _image) async {
  //   FormData data = FormData.fromMap({
  //     "officer_image": [
  //       await MultipartFile.fromFile(_image.path,
  //           filename: "Sankhaabcdefghijklmnopqrst.jpg")
  //     ]
  //   });
  //   Logger().i("${_image.path}");
  //   return Dio()
  //       .post('https://fpay-server.herokuapp.com/v1/fines/upload', data: data)
  //       .then((res) async {
  //     if (res.statusCode == 201) {
  //       return true;
  //     }
  //     return false;
  //   }).catchError((err) {
  //     Logger().i("$err");
  //     return false;
  //   });
  // }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<Officer> details;
  bool isEnabled;
  @override
  initState() {
    isEnabled = true;
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

  File _profilePhoto;
  Future updatePhoto() async {
    var profilePhoto = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _profilePhoto = profilePhoto;
    });
  }

  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/gallery.png',
                        width: 50,
                      ),
                      Text('Gallery'),
                    ],
                  ),
                  onPressed: () {} //getGalleryImage,
                  ),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/take_picture.png',
                        width: 50,
                      ),
                      Text('Take Photo'),
                    ],
                  ),
                  onPressed: () {} //getCameraImage,
                  ),
            ],
          );
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
                Logger().i('${snapshot.data.avatar_url}');
                String avatar_url = snapshot.data.avatar_url;
                return Column(children: <Widget>[
                  SizedBox(
                    height: _height / 12,
                  ),

                  CircleAvatar(
                    radius: _width < _height ? _width / 4 : _height / 4,
                    backgroundImage: NetworkImage(avatar_url),
                    //   child: _profilePhoto == null
                    //       ? Text('No image selected.')
                    //       : Image.file(_profilePhoto),
                  ),
                  ButtonTheme(
                    height: 20,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black)),
                      onPressed: () {
                        _onAlertPress();
                      },
                      textColor: Colors.black,
                      child: const Text('Change Photo',
                          style: TextStyle(fontSize: 12)),
                      color: Colors.white,
                    ),
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
                      Text("Officer's Current Police station"),
                      Text('${snapshot.data.police_station}', style: _style()),
                      SizedBox(
                        height: _height / 25.0,
                      ),
                      Text("Officer NIC"),
                      Text('${snapshot.data.nic}', style: _style()),
                      SizedBox(
                        height: _height / 25.0,
                      ),
                      Text("Officer Email"),
                      Text('${snapshot.data.email}', style: _style()),
                      SizedBox(
                        height: _height / 25.0,
                      ),
                      Text("Officer Mobile Number"),
                      Text('${snapshot.data.contact_number}', style: _style()),
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
                            if (isEnabled) {
                              _handleLogout(context);
                            }
                            else{
                              return null;
                            }

                            //_handle();
                          },
                          textColor: Colors.white,
                          child: const Text('Logout',
                              style: TextStyle(fontSize: 20)),
                          color: Colors.red,
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (isEnabled) {
                              Application.router.navigateTo(context, "/edit");
                            } else {
                              return null;
                            }
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
