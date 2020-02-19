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

  String secondary_officer,
      vehicle_licence_number,
      officer_avatar_url,
      driver_nid;
  List penalties;
  String fines;
  String officer;
  @override
  void initState() {
    super.initState();
    isEnabaled = true;
    penalties = [];
    fines = '';
  }

  var penalty;
  Future<String> _getId() async {
    Logger().i("got herer");
    return FineService().getId().then((res) {
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

  Future _handleFineIssueed(
      String officer,
      String driver_nid,
      String vehicle_license_number,
      String secondary_officer,
      List penalties,
      String image_path) async {
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
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            FineImage(),
            SizedBox(height: 50),
            RaisedButton(
              onPressed: () {
                FineService().isSession().then((_) {
                  if (_)
                    Application.router.navigateTo(context, '/fine');
                  else
                    Application.router.navigateTo(context, '/session');
                });
              },
              textColor: Colors.white,
              child: const Text('Start issue a fine',
                  style: TextStyle(fontSize: 20)),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class ViewFines extends StatefulWidget {
  @override
  _ViewFinesState createState() => _ViewFinesState();
}

class _ViewFinesState extends State<ViewFines> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FineService().getFines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text("Loading..."),
            ),
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.only(top: 20, bottom: 30),
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  "Fine Value: ${snapshot.data[index].fineValue}",
                ),
                subtitle: Text(
                  "location${snapshot.data[index].location} , \nDate and time: ${snapshot.data[index].date} , ${snapshot.data[index].time}",
                ),
              );
            },
          );
        }
      },
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
                      Application.router
                          .navigateTo(context, '/home', clearStack: true);
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "    Title",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.left,
            ),
          ),
          BeautyTextfield(
            width: double.maxFinite,
            height: 50,
            inputType: TextInputType.text,
            prefixIcon: Icon(Icons.work),
            placeholder: "Enter title",
            onChanged: (text) {
              title = text;
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "    Content",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.left,
            ),
          ),
          BeautyTextfield(
            width: double.maxFinite,
            height: 200,
            inputType: TextInputType.text,
            prefixIcon: Icon(Icons.person_outline),
            placeholder: "What is happening",
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
                    isEnabled = false;
                    getId().then((result) {
                      if (result != null) {
                        publishPost(result, content, title);
                      }
                    });
                  } else {
                    return null;
                  }
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
                  return Container(
                    child: Center(
                      child: Text("here..."),
                    ),
                  );
                } else {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(imgUrl),
                          ),
                          title: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("${snapshot.data[index].title}")),
                          subtitle: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${snapshot.data[index].content}",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "By ${snapshot.data[index].first_name} ${snapshot.data[index].last_name}",
                                  style: TextStyle(fontSize: 10),
                                ),
                              )
                            ],
                          ),
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
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;

  Future<Officer> details;
  bool isEnabled;
  @override
  initState() {
    isEnabled = true;
    super.initState();

    details = _handleDetails();
  }

  Future<Officer> _handleDetails() async {
    return await ProfService().getDetails();
  }

  Future _handleLogout(BuildContext context) async {
    await AuthService().logout().then((res) async {
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
      Logger().wtf(_profilePhoto.path);
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
                      // Image.asset(
                      //   'assets/images/gallery.png',
                      //   width: 50,
                      // ),
                      Text('Gallery'),
                    ],
                  ),
                  onPressed: _updateFromGallery //getGalleryImage,
                  ),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Column(
                    children: <Widget>[
                      // Image.asset(
                      //   'assets/images/take_picture.png',
                      //   width: 50,
                      // ),
                      Text('Take Photo'),
                    ],
                  ),
                  onPressed: () {} //getCameraImage,
                  ),
            ],
          );
        });
  }

  void _handleImageSelect() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
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

    return SingleChildScrollView(
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
                        top: _height / 100,
                        left: _width / 8,
                        right: _width / 8),
                  ),
                  Divider(height: _height / 30, color: Colors.white),
                  Column(
                    children: <Widget>[
                      Text("Officer ID"),
                      Text('${snapshot.data.officer_id}', style: _style()),
                      SizedBox(
                        height: _height / 30.0,
                      ),
                      Text("Officer's Current Police station"),
                      Text('${snapshot.data.police_station}', style: _style()),
                      SizedBox(
                        height: _height / 30.0,
                      ),
                      Text("Officer NIC"),
                      Text('${snapshot.data.nic}', style: _style()),
                      SizedBox(
                        height: _height / 30.0,
                      ),
                      Text("Officer Email"),
                      Text('${snapshot.data.email}', style: _style()),
                      SizedBox(
                        height: _height / 30.0,
                      ),
                      Text("Officer Mobile Number"),
                      Text('${snapshot.data.contact_number}', style: _style()),
                      SizedBox(
                        height: _height / 30.0,
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
                            if (isEnabled) {
                              _handleLogout(context);
                            } else {
                              return null;
                            }
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
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              }
            }));
  }

  void _updateFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      Logger().e(_image);
    });

    Navigator.pop(context);

    _handleUpdate(_image);
  }

  void _handleUpdate(File image) {
    ProfService().updateAvatar(image).then((_) {
      if (_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Success!"),
            );
          },
        );
      }
    });
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

class FineImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('lib/images/fineissue.png');
    Image image = Image(
      image: assetImage,
      width: 200,
      height: 200,
    );
    return Container(
      child: image,
      margin: EdgeInsets.only(top: 200),
    );
  }
}
