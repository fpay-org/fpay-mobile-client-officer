import 'package:FPay/config/config.dart';
import 'package:FPay/routes/application.dart';
import 'package:FPay/screens/auth/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final baseUrl = Config.baseUrl;

  Future<bool> login(String email, String password) async =>
    Dio().post('$baseUrl/user/login',
        data: {"email": email, "password": password}).then((res) async {
      
      Logger().i("Result: ${res.statusCode}");

      
      try{if (res.statusCode == 200) {
        
        return await _saveToken(res.data['token']).then((res) {
          return res;
        });
      }}
      on DioError catch (e){
        print(e);
        return false;
      }
    });
    
  
  Future<bool> _saveToken(String token) {
    return SharedPreferences.getInstance().then((instance) {
      return instance.setString("token", token);
    });
  }

  void logout() {}
}
