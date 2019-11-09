import 'package:FPay/config/config.dart';
import 'package:FPay/routes/application.dart';
import 'package:FPay/screens/auth/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final baseUrl = Config.baseUrl;

//   Future<AuthScreen> login(

//       String email, String password, BuildContext context) {
//     return Dio().post('$baseUrl/user/login',
//         data: {"email": email, "password": password}).then((res) {
//           //print(1564615646554545645);
//       if (res.statusCode == 200) {
//         //print(1564615646554545645);
// Application.router.navigateTo(context, '/home',replace: true);

//         return saveToken(res.data['token']);
//       }
//       else {
//         // _showErrorDialog(context);
//         Logger().e("Error on status code");
//         print(1564615646554545645);
//       }
//     }).catchError((error) => Logger().e(error));
//   }

//   Future saveToken(String token) {
//     return SharedPreferences.getInstance().then((instance) {
//       return instance.setString("token", token);
//     });
//   }

  Future<bool> login(String email, String password) {
    Dio().post('$baseUrl/user/login',
        data: {"email": email, "password": password}).then((res) {
      Logger().i("Result: $res");

      if (res.statusCode == 200) {
        return _saveToken(res.data['token']).then((res) {
          if (!!res) return true;
          return false;
        });
      }

      return false;
    });
  }

  Future<bool> _saveToken(String token) {
    return SharedPreferences.getInstance().then((instance) {
      return instance.setString("token", token);
    });
  }

  void logout() {}
}
