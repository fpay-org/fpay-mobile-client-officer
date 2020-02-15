import 'package:FPay/routes/application.dart';
import 'package:FPay/routes/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class FPayOfficerApp extends StatelessWidget {
  FPayOfficerApp() {
    final router = Router();
    Routes.configureRouter(router);
    Application.router = router;
    if(true){
      print("dja vk");
    }
  }

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Officer App",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
    );
  }
}
  