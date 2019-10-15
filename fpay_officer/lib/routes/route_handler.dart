import 'package:FPay/screens/auth/auth_screen.dart';
import 'package:FPay/screens/home/home_screen.dart';
import 'package:FPay/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

var splashHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashScreen();
});

var authHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AuthScreen();
});

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeScreen();
});
