import 'package:FPay/config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as prefix0;
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FineService {
  final baseUrl = Config.baseUrl;
  var now = DateTime.now();
  String id = "456"; // get current user id
  var error; 
  
  //var logger = Logger();
  
  //logger.e("Logger is working!");

  Future getId() async{
  String prefs = await SharedPreferences.getInstance().then((instance){
    return instance.getString('token');
  });
    Logger().i('$prefs'); 
    await Dio().get('$baseUrl/me/$prefs').then((res) async {
      
      if(res.statusCode==200){
        Logger().i("$res");
        return res;
      }
      return false;
    }).catchError((err)=>false);
}
  // static Future<Position> getLocation() async {
  //   Position location =  await Geolocator().getCurrentPosition(desiredAccuracy:prefix0.LocationAccuracy.high);
  //   return location;
  // }
  // var location = getLocation();



// var location = new Location();

// // Platform messages may fail, so we use a try/catch PlatformException.
// Future<LocationData> locale() async {
//     LocationData currentLocation;
// try {
//   currentLocation = await location.getLocation();
// } on PlatformException catch (e) {
//   if (e.code == 'PERMISSION_DENIED') {
//     error = 'Permission denied';
//   }
//   currentLocation = null;
// }

// return currentLocation;

// }

  //LocationData currentLocation = locale() as LocationData;
  Future<bool> isuseFine(String _officer_id, String _driver_id,
          String _witness_id, List _fines) async =>
      Dio().post('$baseUrl/user/', data: {
        "main_officer_id": id,//get current user id
        "witness_officer_id": _officer_id,
        "driver_id": _driver_id,
        "fine_list": _fines,
        "time_stamp:": now,
        //"location":location,
      }).then((res) async {
        Logger().i("Result: ${res.statusCode}");

        try {
          if (res.statusCode == 200) {
            //code here
          }
        } on DioError catch (e) {
          print(e);
          return false;
        }
      });
}
