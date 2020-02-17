//import 'dart:html';
import 'dart:io';
//import 'package:path/path.dart';
import 'package:FPay/services/pref_service.dart';
import 'package:image_picker/image_picker.dart';
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


class Fine{
  String fineId;
  int fineValue;
  bool isPaid;
  Fine(this.fineId,this.fineValue,this.isPaid);
  
}

class FineService {
  final baseUrl = Config.baseUrl;
  DateTime now = DateTime.now();
  String officer; // get current user id
  //var error;
  int value;
  //var logger = Logger();

  //logger.e("Logger is working!");

  Future<List<Fine>> getFines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String officer = prefs.getString("officer");
    Logger().i('$officer');
    return await Dio()
        .get(
      '$baseUrl/fines/officer/$officer',
    ).then((res) async {
      Logger().i("$res");
      List<Fine> fines = [];
      Logger().i("here: ${res.data["data"]}");
      int length = res.data["data"].length;
      if (res.statusCode == 200) {
        Logger().i("$length");
        //Logger().i("nlknklnlk${res.data["data"]["fines"]}");
        Logger().i("vdjskbvjkdsbvkbdskvbds");

        //List<Fine> e_fines = [];
        for (int i = 0; i < length; i++) {
          var f = res.data["data"][i];
          Logger().i("huk    ${f["_id"]}");
          Logger().i("here");
          Fine fine = Fine(f["_id"], f["total_value"],
              f["is_payed"]); //need to add other parameters
          fines.add(fine);
          Logger().i("safaf0{$fines.length}");
        }

        return fines;
      }
      Logger().i("return false");
      return false;
    }).catchError((err) => false);
  }

  Future<List> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result  = new List();
    result[0] = prefs.getString("officer");
    result[1] = prefs.getString("officer");
    Logger().i('$officer');
    return result;
    //return await _saveToken(token);
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

  Future<Position> _getCurrentLocation() async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: prefix0.LocationAccuracy.high);
  }

  //LocationData currentLocation = locale() as LocationData;
  Future<bool> isuseFine(
      String officer,
      String driver_nid,
      String vehicle_license_number,
      String secondary_officer,
      List penalties,String iamge_path) async {
    Position _currentPosition = await _getCurrentLocation();
    Logger().i('start');
    String lat = _currentPosition.latitude.toString();
    String long = _currentPosition.longitude.toString();
    //List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat,long);
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates( 52.2165157, 6.9437819);
    Placemark place = placemark[0];
    String address = "${place.locality},${place.postalCode},${place.country}";
    Logger().i('${address}');
    Logger().i('$long');
    value = 0;
    
    Logger().i('$driver_nid');
    Logger().i('$value');
    Logger().i('$officer');
    //String penalties_string = penalties.toString();
    String penalties_string = penalties.join(',');
    Object location_string = {
       "name": address, "longitude": long, "latitude": lat
    }.toString();
    Logger().i('fines:$penalties_string');
    Logger().i('$location_string');
    if (secondary_officer == officer) {
      return false;
    }

    // FormData data = FormData.fromMap({
    //   "total_value": 10000,
    //   "currency": "lkr",
    //   "penalties": "1,2,3",
    //   "driver_nid": "961881579v",
    //   "officer": "222222",
    //   "secondary_officer": "222223",
    //   "location": "{\"name\":\"2nd common\",\"longitude\":\"25.987355\",\"latitude\":\"98.668262\"}",
    //   "vehicle_license_number": "AA-1234",
    //   "officer_image": [await MultipartFile.fromFile(iamge_path, filename: "Sankhaabcdefghijklmnopqrst.jpg")]
    // });

    //   return Dio().post('$baseUrl/fines',data: data).then((res) async {
    //     if(res.statusCode==201){
    //       return true;
    //   }
    //   return false;
    //   }).catchError((err){
    //     Logger().i("$err");
    //     return false;
    //   });
      
    return Dio().post('$baseUrl/fines', data: {
      "total_value": 17000,
      "currency": "lkr",
      "penalties": penalties,
      "driver_nid": driver_nid,
      "officer": officer, //get current user id
      "secondary_officer": secondary_officer,
      "location": {"name": address, "longitude": long, "latitude": lat},
      "vehicle_license_number": vehicle_license_number,
      "officer_avatar-url": ""
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

  Future<bool> isSession() {
    return PrefService()
        .getSession()
        .then((token) => (token != null) ? true : false)
        .catchError((error) => Logger().e(error));
  }

  Future<bool> setSessionToken(String officerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isSession", true);
    prefs.setString("secondaryOfficer", officerId);
    return true;
  }

  Future<bool> endSession()  async {
    //BuildContext context;
    await SharedPreferences.getInstance().then((prefs){
          prefs.remove("secondaryOfficer");
          prefs.setBool("isSession", false);
          
          //Application.router.navigateTo(context,'/',clearStack: true);
          
    });
    
  Logger().i("logout");
    return true;
  }
}
  