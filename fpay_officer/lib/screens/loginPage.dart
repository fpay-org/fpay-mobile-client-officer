// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart';
// import '../user.dart';

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: true, 
//         title: "login", 
//         home: new Page()
//         );
//   }
// }

// class Page extends StatefulWidget{
//   @override
//   _PageState createState() => new _PageState();
// }



// class _PageState extends State<Page> {
// final myControllerId = TextEditingController();
// final myControllerPass = TextEditingController();

// @override
// void dispose(){
//   myControllerId.dispose();
//   myControllerPass.dispose();
//   super.dispose();
// }


// String url = 'fds'; //url goes here
// String userId;
// String password;
// Map<String, String> headers = {"Content-type":"application/json"};

// _verifyUser() async {
//   User newUser = new User(userId: userId,password: password);
//   Response response = await post(url,headers:headers,body:newUser);
//   int statusCode = response.statusCode;
//   if(statusCode==200){
//     //navigateToHomePage(context);
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         resizeToAvoidBottomPadding: false,
//         body: Center(
//             child: Column(children: <Widget>[
//           Container(
//               padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
//               color: Colors.white,
//               child: new Container(
//                 child: new Center(
//                     child: new Column(children: [
//                   new Padding(padding: EdgeInsets.only(top: 165.0)),
//                   /*new Text('Beautiful Flutter TextBox',
//                        style: new TextStyle(color: Colors.blue, fontSize: 25.0),),*/
//                   new Padding(padding: EdgeInsets.only(top: 10.0)),
//                   new TextFormField(
//                     controller: myControllerId,
//                     onSaved: (input) => userId = input,
//                     decoration: new InputDecoration(
//                       labelText: "User ID",
//                       fillColor: Colors.white,
//                       border: new OutlineInputBorder(
//                         borderRadius: new BorderRadius.circular(25.0),
//                         borderSide: new BorderSide(),
//                       ),
//                       //fillColor: Colors.green
//                     ),
//                     validator: (val) {
//                       if (val.length == 0) {
//                         return "User ID cannot be empty";
//                       } else {
//                         return null;
//                       }
//                     },
//                     keyboardType: TextInputType.text,
//                     style: new TextStyle(
//                       fontFamily: "Poppins",
//                     ),
//                   ),
//                 ])),
//               )),
//           Container(
//               padding:
//                   const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10),
//               color: Colors.white,
//               child: new Container(
//                 child: new Center(
//                     child: new Column(children: [
//                   new Padding(padding: EdgeInsets.only(top: 0.0)),
//                   /*new Text('Beautiful Flutter TextBox',
//                        style: new TextStyle(color: Colors.blue, fontSize: 25.0),),*/
//                   new Padding(
//                       padding: EdgeInsets.only(left: 30.0, right: 30.0)),
//                   new TextFormField(
//                     controller: myControllerPass,
//                     onSaved: (input) => password = input,
//                     decoration: new InputDecoration(
//                       labelText: "Password",
//                       fillColor: Colors.white,
//                       border: new OutlineInputBorder(
//                         borderRadius: new BorderRadius.circular(25.0),
//                         borderSide: new BorderSide(),
//                       ),
//                       //fillColor: Colors.green
//                     ),
//                     validator: (val) {
//                       if (val.length == 0) {
//                         return "User ID cannot be empty";
//                       } else {
//                         return null;
//                       }
//                     },
//                     keyboardType: TextInputType.text,
//                     style: new TextStyle(
//                       fontFamily: "Poppins",
//                     ),
//                   ),
//                 ])),
//               )),
//           RaisedButton(
//             onPressed: () {
//               _verifyUser();
              
//             },
//             textColor: Colors.white,
//             child: const Text('Login', style: TextStyle(fontSize: 20)),
//             color: Colors.lightBlue,
//           ),
//         ])));
//   }
// }



