import 'package:flutter/material.dart';
import 'viewIssuedFines.dart';
import 'issueFine.dart';
import 'myProfile.dart';
import 'settings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/issueFine': (BuildContext) => new IssueFines(),
          '/viewFine': (BuildContext) => new ViewIssuedFines(),
          '/profile': (BuildContext) => new MyProfile(),
          '/settings': (BuildContext) => new Settings(),
        },
        debugShowCheckedModeBanner: false,
        title: 'ListViews',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Page());
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => new _PageState();
}

class _PageState extends State<Page> {
  int countValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Homepage'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: ()=> Navigator.pop(context,false),
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
                    Navigator.pushNamed(context, '/viewFine');
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
                    Navigator.pushNamed(context, '/issueFine');
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
                    //Insert event to be fired up when button is clicked here
                    //in this case, this increments our `countValue` variable by one.
                    //navigateToMyProfile(context);
                    Navigator.pushNamed(context, '/profile');
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
                    Navigator.pushNamed(context, '/settings');
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

