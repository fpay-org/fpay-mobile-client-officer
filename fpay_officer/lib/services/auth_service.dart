import 'package:FPay/config/config.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final baseUrl = Config.baseUrl;

  Future login(String email, String password) {
    return Dio().post('$baseUrl/user/login',data: {"email": email, "password": password}).then((res){
      if (res.statusCode == 200) {
        return saveToken(res.data['token']);
      } else {
        Logger().e("Error on status code");
      }
    }).catchError((error) => Logger().e(error));
  }

  Future saveToken(String token) {
    return SharedPreferences.getInstance().then((instance) {
      return instance.setString("token", token);
    });
  }
}
