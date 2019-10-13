import 'package:flutter/material.dart';

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
                //Insert event to be fired up when button is clicked here
                //in this case, this increments our `countValue` variable by one.
                setState(() => countValue += 1);
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
                setState(() => countValue += 1);
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
                setState(() => countValue += 1);
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
                setState(() => countValue += 1);
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
