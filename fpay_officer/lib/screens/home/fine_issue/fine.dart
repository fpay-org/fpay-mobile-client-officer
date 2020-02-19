import 'package:FPay/routes/application.dart';
import 'package:FPay/services/fine_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'dart:async';
import 'dart:io';

class OfficerIDValidator {
  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
}

class Fine extends StatefulWidget {
  @override
  _FineState createState() => _FineState();
}

class _FineState extends State<Fine> {
  bool isEnabaled;
  final _fineFormKey = new GlobalKey<FormState>();

  String secondary_officer,
      vehicle_licence_number,
      officer_avatar_url,
      driver_nid;

  List penalties;
  String fines;
  String officer;

  @override
  void initState() {
    isEnabaled = true;
    Logger().i("njdnvjkdnkn");

    super.initState();
    penalties = [];
    fines = '';
  }

  var penalty;
  Future<String> _getId() async {
    Logger().i("got herer");
    return FineService().getId().then((res) {
      Logger().i("$res");
      if (res != null) {
        Logger().i("Came here");
        Logger().i("$res");
        return res;
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

  Future _handleFineIssueed(String officer, String driver_nid,
      String vehicle_license_number, List penalties, String image_path) async {
    await FineService()
        .isuseFine(
            officer, driver_nid, vehicle_license_number, penalties, image_path)
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
                      Application.router
                          .navigateTo(context, '/home', clearStack: true);
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
        Application.router.navigateTo(context, '/session', clearStack: true);
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
            Text(
              "Fill in the details to issue a fine",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Driver's NID",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  driver_nid = value;
                });
              },
              validator: (val) {
                if (val.length == 0) {
                  return "Driver's nid number cannot be empty";
                } else if (val.length != 10 || val.length != 12) {
                  return "Driver's nid number not valid";
                }
              },
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
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
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
                  "display": "Identification plates(හඳුනාගැනීමේ තහඩු)",
                  "index": "1",
                },
                {
                  "display":
                      "Not carrying revenue licence(ආදායම් බලපත්‍රය රැගෙන නොයෑම)",
                  "index": "2",
                },
                {
                  "display":
                      "Contraventing revenue licence provisions(ආදායම් බලපත්‍ර ප්‍රතිපාදන උල්ලංගනය කිරීම)",
                  "index": "3",
                },
                {
                  "display":
                      "Driving emergency service vehicles & public service vehicle without driving licence(රියදුරු බලපත්‍රයක් නොමැතිව හදිසි සේවා වාහන සහ රාජ්‍ය සේවා වාහන ධාවනය කිරීම)",
                  "index": "4",
                },
                {
                  "display":
                      "Driving special purpose vehicles without a licence(බලපත්‍රයක් නොමැතිව විශේෂ කාර්ය වාහන ධාවනය කිරීම)",
                  "index": "5",
                },
                {
                  "display":
                      "Driving a vehicle loaded with chemicals/hazardous waste without a licence(රසායනික ද්‍රව්‍ය / අන්තරායකර අපද්‍රව්‍ය පටවා ඇති වාහනයක් බලපත්‍රයක් නොමැතිව ධාවනය කිරීම)",
                  "index": "6",
                },
                {
                  "display":
                      "Not having a licence to drive a specific class of vehicles(නිශ්චිත පන්තියේ වාහන ධාවනය කිරීමට බලපත්‍රයක් නොමැති වීම)",
                  "index": "7",
                },
                {
                  "display":
                      "Not carrying a driving licence(රියදුරු බලපත්‍රයක් රැගෙන නොයෑම)",
                  "index": "8",
                },
                {
                  "display":
                      "Not having an instructor's licence(උපදේශක බලපත්‍රයක් නොමැති වීම)",
                  "index": "9",
                },
                {
                  "display":
                      "Contravening speed limit(වේග සීමාව උල්ලංගනය කිරීම)",
                  "index": "10",
                },
                {
                  "display": "Disobeying road rules(මාර්ග නීති උල්ලංගනය කිරීම)",
                  "index": "11",
                },
                {
                  "display":
                      "Activities obstructing control of the motor vehicle(මෝටර් වාහනය පාලනය කිරීමට බාධා කරන ක්‍රියාකාරකම්)",
                  "index": "12",
                },
                {
                  "display": "Signals by driver",
                  "index": "13",
                },
                {
                  "display":
                      "Reversing for a long distance(දිගු දුරක් ආපසු හැරවීම)",
                  "index": "14",
                },
                {
                  "display":
                      "Sound or light warnings(ශබ්ද හෝ සැහැල්ලු අනතුරු ඇඟවීම්)",
                  "index": "15",
                },
                {
                  "display":
                      "Excessive emmision of smoke. etc(දුම අධික ලෙස පිට කිරීම. යනාදිය)",
                  "index": "16",
                },
                {
                  "display":
                      "Riding on running boards(ධාවන පුවරු මත ධාවනය කිරීම)",
                  "index": "17",
                },
                {
                  "display":
                      "No of persons in front seats(ඉදිරිපස ආසනවල සිටින පුද්ගලයින්ගේ ගණන)",
                  "index": "18",
                },
                {
                  "display": "",
                  "index": "19",
                },
                {
                  "display":
                      "Not wearing protective helmets(ආරක්ෂිත හිස් ආවරණ පැළඳ නොසිටීම)",
                  "index": "20",
                },
                {
                  "display":
                      "Distribution of advertisements(දැන්වීම් බෙදා හැරීම)",
                  "index": "21",
                },
                {
                  "display":
                      "Excessive use of noice(ශබ්දය අධික ලෙස භාවිතා කිරීම)",
                  "index": "22",
                },
                {
                  "display":
                      "Disobeying directions & signals of police officers/Trafic wardens(පොලිස් නිලධාරීන්ගේ හෝ රථවාහන පාලකයන්ගේ උපදෙස් වලට අකීකරු වීම)",
                  "index": "23",
                },
                {
                  "display":
                      "non compliance with traffic signals(මාර්ග සංකේත වලට අනුකූල නොවීම)",
                  "index": "24",
                },
                {
                  "display":
                      "failure to take precautions when discharging fuel into tank(ටැංකියට ඉන්ධන බැහැර කිරීමේදී පූර්වාරක්ෂාව ගැනීමට අපොහොසත් වීම)",
                  "index": "25",
                },
                {
                  "display": "Halting or parking(නැවැත්වීම හෝ වාහන නැවැත්වීම)",
                  "index": "26",
                },
                {
                  "display":
                      "Non use of precaution when parking(වාහන නැවැත්වීමේදී පූර්වාරක්ෂාව භාවිතා නොකිරීම)",
                  "index": "27",
                },
                {
                  "display":
                      "Excessive carriage of persons in motor car or private coach(මෝටර් කාර් හෝ පෞද්ගලික පුහුණුකරු තුළ පුද්ගලයින් අධික ලෙස ප්‍රවාහනය කිරීම)",
                  "index": "28",
                },
                {
                  "display":
                      "Carriage of passengers in excess in buses(බස්රථවල අතිරික්ත මගීන් ප්‍රවාහනය කිරීම)",
                  "index": "29",
                },
                {
                  "display":
                      "Carriage on lorry or motor tricycle van of goods in excess(භාණ්ඩවල ලොරි හෝ මෝටර් ට්‍රයිසිකල් වෑන් රථයක් ප්‍රවාහනය කිරීම)",
                  "index": "30",
                },
                {
                  "display":
                      "Carriage on lorry or motor tricycle van of goods in excess(භාණ්ඩවල ලොරි හෝ මෝටර් ට්‍රයිසිකල් වෑන් රථයක් ප්‍රවාහනය කිරීම)",
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
                if (_fineFormKey.currentState.validate()) {
                  if (isEnabaled) {
                    isEnabaled = false;

                    

                    _getId().then((result) {
                      if (result != null) {
                        _handleFineIssueed(result, driver_nid,
                            vehicle_licence_number, penalties, image_path);
                      }
                    });
                  }
                } else {
                  return null;
                }
              },
              textColor: Colors.white,
              child: const Text('Issue Fine', style: TextStyle(fontSize: 20)),
              color: Colors.redAccent,
            ),
            RaisedButton(
              onPressed: () {
                if (isEnabaled) {
                  Logger().i('fine issue start');
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
