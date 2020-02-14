import 'dart:async';
import 'package:FPay/config/config.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Officer{
  String first_name;
  String last_name;
  String officer_id;
  String email;
  String contact_number;
  String nic;
  String police_station;
  Officer(this.first_name,this.last_name, this.officer_id,this.email,this.contact_number,this.nic,this.police_station);

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


  Future<bool> changePass(String officer,String current_password,String new_password){
     Logger().i("$officer");
    Logger().i("$current_password");
    Logger().i("$new_password");

    return Dio().post('$baseUrl/fines', data: {
      "officer":officer,
     // "",
      
    }).then((res) async {
      if (res.statusCode == 201) {
        Logger().i("${res.statusCode}");
        return true;
      }
      return false;
    }).catchError((err) {
      Logger().i("$err");
      return false;
    });
  }
  
  Future<bool> editDetails(String officer,String first_name,String last_name,String email,String contact_nummber,String nic,String police_station,String password,){


    Logger().i("$officer");
    Logger().i("$first_name");
    Logger().i("$last_name");
    Logger().i("$email");
    Logger().i("$contact_nummber");
    Logger().i("$nic");
    Logger().i("$police_station");
    Logger().i("$password");


    return Dio().post('$baseUrl/officer/222222', data: {
      "officer":officer,
      "first_name":first_name,
      "last_name":last_name,
      "email":email,
      "contact_number":contact_nummber,
      "nic":nic,
      "police_station":police_station,
      "password":password

      
    }).then((res) async {
      if (res.statusCode == 202) {
        Logger().i("${res.statusCode}");
        return true;
      }
      return false;
    }).catchError((err) {
      Logger().i("$err");
      return false;
    });
  }
 
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
        officer  = Officer(f["first_name"],f["last_name"],f["officer_id"],f["email"],f["contact_number"],f["nic"],f["police_station"]);
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

