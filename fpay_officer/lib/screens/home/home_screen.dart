import 'package:FPay/routes/application.dart';
import 'package:flutter/material.dart';
// import 'viewIssuedFines.dart';
// import 'issueFine.dart';
// import 'myProfile.dart';
// import 'settings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         routes: {
//           'issueFine': (BuildContext) => new IssueFines(),
//           'viewFine': (BuildContext) => new ViewIssuedFines(),
//           'profile': (BuildContext) => new MyProfile(),
//           'settings': (BuildContext) => new Settings(),
//         },
//         debugShowCheckedModeBanner: false,
//         title: 'ListViews',
//         theme: ThemeData(
//           primarySwatch: Colors.teal,
//         ),
//         home: Page());
//   }
// }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int countValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Homepage'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: ()=> Navigator.pop(context,true),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(MdiIcons.logout),
              onPressed: () => _handleLogout(),
            )
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Text(
                "Select a task",
                style: TextStyle(fontSize: 50, color: Colors.brown),
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //navigateToViewFinePage(context);
                   // Navigator.pushNamed(context, 'viewFine');
                    //Navigator.push(context,MaterialPageRoute(builder: (context)=>ViewIssuedFines())); 
                    //navigateto(context);
                    Application.router.navigateTo(context, '/viewfine',);
                  },
                  child: CircleAvatar(
                    backgroundImage: ExactAssetImage('lib/images/officer.png'),
                    minRadius: 50,
                    maxRadius: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //navigateToIssueFinePage(context);
                    Navigator.pushNamed(context, '/newfine');
                    //Navigator.push(context,MaterialPageRoute(builder: (context)=>IssueFines()));
                  },
                  child: CircleAvatar(
                    backgroundImage: ExactAssetImage('lib/images/officer.png'),
                    minRadius: 50,
                    maxRadius: 80,
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //navigateToMyProfile(context);
                   // Navigator.pushNamed(context, 'profile');
                    //Navigator.push(context,MaterialPageRoute(builder: (context)=>MyProfile()));
                    Application.router.navigateTo(context, "/viewfine");
                  },
                  child: CircleAvatar(
                    backgroundImage: ExactAssetImage('lib/images/officer.png'),
                    minRadius: 50,
                    maxRadius: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //Insert event to be fired up when button is clicked here
                    //in this case, this increments our `countValue` variable by one.
                    //navigateToSettings(context);
                    //Navigator.pushNamed(context, 'settings');
                    //Navigator.push(context,MaterialPageRoute(builder: (context)=>Settings()));
                  },
                  child: CircleAvatar(
                    backgroundImage: ExactAssetImage('lib/images/officer.png'),
                    minRadius: 50,
                    maxRadius: 80,
                  ),
                )
              ],
            )
          ],
        )));
  }

  void _handleLogout() {}
}

// Future navigateto(BuildContext context) async {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewIssuedFines()));
// }