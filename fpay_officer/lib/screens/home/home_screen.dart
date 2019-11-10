import 'package:FPay/routes/application.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>{

  int _selectedIndex = 0;
 TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
 List<Widget> _widgetOptions = <Widget>[
   
  Center(
    
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
                    Application.router.navigateTo(context, '/newfine',);
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
                    Application.router.navigateTo(context, '/profile');
                  },
                  child: CircleAvatar(
                    backgroundImage: ExactAssetImage('lib/images/officer.png'),
                    minRadius: 50,
                    maxRadius: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Application.router.navigateTo(context, '/settings');
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
        )),
  Text(
     'Index 1: Business',
     //style: optionStyle,
  ),
  Text(
     'Index 2: School',
     //style: optionStyle,
  ),
  Center(
    child: Column(children: <Widget>[],),
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
    appBar: AppBar(
      title: const Text('Home Page'),
    ),
    body: Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car),
          title: Text('Tasks')
          ,
        ),
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
// class _HomePageState extends State<HomePage> {
//   int countValue = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Homepage'),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: ()=> Navigator.pop(context,true),
//           ),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(MdiIcons.logout),
//               onPressed: () => _handleLogout(),
//             )
//           ],
//         ),
//         body: );
//   }

//   void _handleLogout() {}
//  }
