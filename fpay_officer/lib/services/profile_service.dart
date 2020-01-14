import 'dart:async';
import 'package:FPay/config/config.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Officer{
  String first_name;
  String last_name;
  String officer_id;
  Officer(this.first_name,this.last_name, this.officer_id);

  // factory Driver.fromJson(Map<String, dynamic> json) {
  //   return Driver(
  //     name: json['first_name'],
  //     nid: json['nid'],
  //     //email: json['email'],
  //     email: "sashi@gmail.com",
  //     lno: json['licence_number'],
  //     pno: json['contact_number'],
  //   );
  // }
}
class ProfService {
  final baseUrl = Config.baseUrl;
  
  
 
  Future<Officer> getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    //List<Driver> driverDetails = [];
    Officer officer;
    Logger().i("pus ${token}");

   return Dio().get('$baseUrl/me?token=$token',).then((res) async {
      Logger().i("$res");
      
      if (res.statusCode == 200) {
        Logger().i("prof: ${res.data["data"]}");
        var f = res.data["data"];
        Logger().i("f: ${f["first_name"]}");
        //print(res);
        officer  = Officer(f["first_name"],f["last_name"],f["officer_id"]);
        Logger().i("d: ${officer}");
        //driver.add(driver);
        //String token = res.data["data"]["token"];
        //return driver;
        Logger().i("prof");
        return officer;
      }
    Logger().i("returned false");
      
      return officer;
    }).catchError((err) => officer);
  }
  
  Future<bool> _saveToken(String token) {
    return SharedPreferences.getInstance().then((instance) {
      return instance.setString("token", token);
    });
  }

  Future <String> _getToken(){
    return SharedPreferences.getInstance().then((instance) {
      return instance.getString("token");
    });
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

}

