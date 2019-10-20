 import 'package:flutter/material.dart';

 class ViewIssuedFines extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"View fines",
      //home: new Page(),
    );
  }

}

// class Page extends StatefulWidget{
//   @override
//     _PageState createState() => new _PageState();
  
// }
// /*class _PageState extends State<Page> {
//   @override
//   Widget build(BuildContext context) {
//     retain
//   }

// }

// }*/

// class _ViewIssuedFinesState extends State<ViewIssuedFines> {
//   @override
//   void initState() {
//     _getThingsOnStartup().then((value){
//       print('Async done');
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
//   Future _getThingsOnStartup() async {
//     await Future.delayed(Duration(seconds: 2));
//   }
// }