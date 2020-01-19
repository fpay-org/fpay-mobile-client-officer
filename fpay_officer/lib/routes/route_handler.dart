import 'package:FPay/screens/auth/auth_screen.dart';
import 'package:FPay/screens/editdetails/change_pass.dart';
import 'package:FPay/screens/editdetails/edit.dart';
import 'package:FPay/screens/home/home_screen.dart';
import 'package:FPay/screens/home/tasks/issueFine.dart';
import 'package:FPay/screens/home/tasks/myProfile.dart';
import 'package:FPay/screens/home/tasks/viewIssuedFines.dart';
import 'package:FPay/screens/home/tasks/settings.dart';
import 'package:FPay/screens/splash/splash_screen.dart';
import 'package:flutter/foundation.dart';
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
  return HomePage();
});

var viewfineHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ViewIssuedFines();
});

var newfineHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return IssueFines();
});

var profileHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MyProfile();
});

var editHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EditDetails();
});

var changePassHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ChangePass(params['officer'][0]);
});
