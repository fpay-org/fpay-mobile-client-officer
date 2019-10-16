import 'package:flutter/material.dart';
import 'viewIssuedFines.dart';
import 'issueFine.dart';
import 'myProfile.dart';
import 'settings.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                  child: Text(
                    "Select a task",
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.brown
                    ),),
                ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                
                GestureDetector(
              onTap: () {

                navigateToViewFinePage(context);
              },
              child: CircleAvatar(
                backgroundImage: ExactAssetImage('lib/images/officer.png'),
                minRadius: 50,
                maxRadius: 80,
              ),
            ),
            GestureDetector(
              onTap: () {
                navigateToIssueFinePage(context);
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
                navigateToMyProfile(context);
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
                navigateToSettings(context);
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
}

Future navigateToViewFinePage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewIssuedFines()));
}
Future navigateToIssueFinePage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => IssueFines()));
}
Future navigateToMyProfile(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
}
Future navigateToSettings(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
}