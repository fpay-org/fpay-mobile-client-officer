import 'package:FPay/config/config.dart';
import 'package:FPay/routes/application.dart';
import 'package:FPay/screens/auth/auth_screen.dart';
import 'package:FPay/screens/homePage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final baseUrl = Config.baseUrl;

  Future<AuthScreen> login(String email, String password,BuildContext context) {
    return Dio().post('$baseUrl/user/login',
        data: {"email": email, "password": password}).then((res) async {
      if (res.statusCode == 200) {
          navigateHomePage(context);
          print(1564615646554545645);

        return saveToken(res.data['token']);
      } else {
       // _showErrorDialog(context);
        Logger().e("Error on status code");
        print(1564615646554545645);
      }
    }).catchError((error) => Logger().e(error));
  }

  Future saveToken(String token) {
    return SharedPreferences.getInstance().then((instance) {
      return instance.setString("token", token);
    });
  }

  void logout(){
    
  }

  


}

Future navigateHomePage(BuildContext context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
}

