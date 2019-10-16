import 'package:FPay/config/config.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AuthService {
  final baseUrl = Config.baseUrl;

  Future login(String email, String password) {
    Dio().post('$baseUrl/user/login',
        data: {"email": email, "password": password}).then((res) {
      if (res.statusCode == 200) {
        Logger().i(res.data);
      }
    });
  }

  Future saveToken(String token) {}
}
