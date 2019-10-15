import 'package:FPay/routes/application.dart';
import 'package:FPay/routes/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class FPayOfficerApp extends StatelessWidget {
  FPayOfficerApp() {
    final router = Router();
    Routes.configureRouter(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Officer App",
    );
  }
}
