import 'dart:convert';

import 'package:FPay/config/config.dart';
import 'package:FPay/routes/application.dart';
import 'package:FPay/screens/auth/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

String officer;

class AuthService {
  final baseUrl = Config.baseUrl;
  Future<bool> login(String id, String password) {
    officer = id;
    Logger().i('$id');
    Logger().i('$password');
    Logger().i( 'Uri $baseUrl/auth/officer/login?officer_id=$id&password=$password');
    return Dio().get(
      '$baseUrl/auth/officer/login?officer_id=$id&password=$password',
      // data: {
      //   "officerID": id, 
      //   "password": password,
      // },
    ).then((res) async {
      Logger().i('$res');
      if (res.statusCode == 200) {
        print(res);
        String token = res.data["data"]["token"];
        return await _saveToken(token);
      }
      return false;
    }).catchError((err) => false);
  }

  Future<bool> logout()  async {
    //BuildContext context;
    await SharedPreferences.getInstance().then((prefs){
          prefs.remove("token");
          //Application.router.navigateTo(context,'/',clearStack: true);
          
    });
Logger().i("logout");
    return true;
  }

  Future<bool> _saveToken(String token) async {
    return await SharedPreferences.getInstance().then((instance) {
      //Logger().i('$token');
      print(token);
      instance.setString("officer", officer);
      instance.setString("token", token);
      return true;
    }).catchError((err) => false);
  }
}