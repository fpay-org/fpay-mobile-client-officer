// import "package:flutter/material.dart";
// //import 'loginPage.dart';
// import 'auth/auth_screen.dart';

// class StartApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: {
//         //'/': (BuildContext) => new StartApp(),
//         '/login': (BuildContext) => new AuthScreen(),
//       },
//       debugShowCheckedModeBanner: false,
//       title: "Online fine payment mobile appliction",
//       home: new Page());
//   }
// }

// class Page extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               Logo(),
//               Text(
//                 "Welcome to FPay",
//                 textDirection: TextDirection.ltr,
//                 style: TextStyle(
//                   decoration: TextDecoration.none,
//                   fontSize: 30,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               RaisedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/login');
//                   //Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
//                 },
//                 textColor: Colors.white,
//                 padding: const EdgeInsets.all(0.0),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: <Color>[
//                         Color(0xFF0D47A1),
//                         Color(0xFF1976D2),
//                         Color(0xFF42A5F5),
//                       ],
//                     ),
//                   ),
//                   padding: const EdgeInsets.only(
//                       left: 20.0, right: 20.0, top: 8, bottom: 8),
//                   child: const Text('Login Here', style: TextStyle(fontSize: 20)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//   }

// }

// class Logo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     AssetImage assetImage = AssetImage('lib/images/logo.png');
//     Image image = Image(
//       image: assetImage,
//       width: 100,
//       height: 100,
//     );
//     return Container(
//       child: image,
//       margin: EdgeInsets.only(top: 200),
//     );
//   }
// }

   