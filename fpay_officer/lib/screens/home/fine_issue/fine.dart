import 'package:FPay/routes/application.dart';
import 'package:FPay/services/fine_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'dart:async';
import 'dart:io';

class Fine extends StatefulWidget {
  @override
  _FineState createState() => _FineState();
}

class _FineState extends State<Fine> {
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
    // FineService().isSession().then((_) {
    //     if (_)
    //       Application.router.navigateTo(context, '/home', clearStack: true);
    //     else{}
    //       //Application.router.navigateTo(context, '/auth', clearStack: true);
    //   });
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

  Future changeSession() async {
    await FineService().endSession().then((res) async {
      Logger().i("true");
      if (res) {
        isEnabaled = true;
        Application.router.navigateTo(context, '/session');
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

  //  Widget showImage() {
  //   return FutureBuilder<File>(
  //     future: image,
  //     builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done &&
  //           snapshot.data != null) {
  //         return Image.file(
  //           snapshot.data,
  //           width: 300,
  //           height: 300,
  //         );
  //       } else if (snapshot.error != null) {
  //         return const Text(
  //           'Error Picking Image',
  //           textAlign: TextAlign.center,
  //         );
  //       } else {
  //         return const Text(
  //           'No Image Selected',
  //           textAlign: TextAlign.center,
  //         );
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
            ),
            RaisedButton(
              onPressed: () {
                if (isEnabaled) {
                  changeSession();
                } else {
                  return null;
                }
              },
              textColor: Colors.white,
              child:
                  const Text('Change Session', style: TextStyle(fontSize: 20)),
              color: Colors.orange,
            )
          ],
        ),
      ),
    )));
  }
}
