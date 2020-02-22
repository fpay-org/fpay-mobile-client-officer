import 'package:FPay/routes/application.dart';
import 'package:FPay/routes/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class FPayOfficerApp extends StatelessWidget {
  FPayOfficerApp() {
    //configure routing using fluro plugin
    final router = Router();
    Routes.configureRouter(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    //main MaterialApp widget of the app
    return MaterialApp(
      title: "Officer App",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
    );
  }
}
