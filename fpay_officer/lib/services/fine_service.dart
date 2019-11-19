import 'package:FPay/config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as prefix0;
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FineService {
  final baseUrl = Config.baseUrl;
  DateTime now = DateTime.now();
  String officerid; // get current user id
  //var error; 
  int value;
  //var logger = Logger();
  
  //logger.e("Logger is working!");

Future getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token");
  Logger().i('$token');
    return Dio().get(
      '$baseUrl/me/$token',
    ).then((res) async {
      
      if (res.statusCode == 200) {
        //Logger().i('$res.data["token"]');
        //String toke = res.data['token'];
        //final js = json.decode(res.data);
        Logger().i("$res");
        //print(res);
        officerid = res.data["data"]["officerID"];
        Logger().i('id:$officerid');
        //print(m);
        //Logger().i('$token');
        return true;
        //return await _saveToken(token);
      }
      Logger().i('puk');
      return false;
      
    }).catchError((err) => false);
  }

//   Future getId() async{
//     String id = "0";
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String token = prefs.getString("token");
//     Logger().i('$token'); 
//     final res = await Dio().get('$baseUrl/me/$token');
      
//       if(res.statusCode == 200){
//         Logger().i("$res");
//         id = res.data["data"]["officerID"];
//         Logger().i('id:$id');
//          //await _saveID(id);
//           return id;

//          }
//          return false;
//         // if(id != null){
//         //   Logger().i("id:$id");
//         //   return id;
//         // }
//       //return false;
//       ///Logger().i('$id');
//       // if(id=="0")
//       //   return true;
//       // else
//       //   return false;
//     //}).catchError((err)=>false);
// }

Future<bool> _saveID(String id) async {
    return await SharedPreferences.getInstance().then((instance) {
      //Logger().i('$token');
      print(id);
      instance.setString("id", id);
      return true;
    }).catchError((err) => false);
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


Future<Position> _getCurrentLocation()async {
return await Geolocator().getCurrentPosition(desiredAccuracy: prefix0.LocationAccuracy.high);

}


  //LocationData currentLocation = locale() as LocationData;
  Future<bool> isuseFine(String _driver_id,String _witness_id, List _fines) async {
  Position _currentPosition = await _getCurrentLocation();
  
  String lat = _currentPosition.latitude.toString();
  String long = _currentPosition.longitude.toString();
  List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
  Placemark place = placemark[0];
  String address = "${place.locality},${place.postalCode},${place.country}";
  Logger().i('${address}');
  Logger().i('$lat');
  value = 0;
  Logger().i('fines:$_fines');
  
  Logger().i('$value');
  
  if(_witness_id == officerid){
    return false;
  }
      return Dio().post('$baseUrl/user/', 
      // headers:{
        //add token here
      // },
      data: {
        "value":value,
        "penalies": _fines,
        "officer": officerid,//get current user id
        "secondary_officer": _witness_id,
        "driver": _driver_id,
        "fine_list": _fines,
        "time_stamp:": now,
        "location":[lat,long],
        "address":address,
      },
      ).then((res) async {
        Logger().i("Result: ${res.statusCode}");
          if (res.statusCode == 200) {
            return true;
          }
          return false;
        }).catchError((err)=>false);
      }
}
