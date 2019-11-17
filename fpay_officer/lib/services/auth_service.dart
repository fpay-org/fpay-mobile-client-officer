import 'package:FPay/config/config.dart';
import 'package:FPay/routes/application.dart';
import 'package:FPay/screens/auth/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final baseUrl = Config.baseUrl;

  Future<bool> login(String id, String password) {
    return Dio().post(
      '$baseUrl/auth/officer/login',
      data: {
        "officerID": id,
        "password": password,
      },
    ).then((res) async {
      if (res.statusCode == 200) {
        return await _saveToken(res.data['token']);
      }
      return false;
    }).catchError((err) => false);
  }

  Future<bool> _saveToken(String token) {
    return SharedPreferences.getInstance().then((instance) {
      instance.setString("token", token);
      return true;
    }).catchError((err) => false);
  }

  void logout() {}
}
