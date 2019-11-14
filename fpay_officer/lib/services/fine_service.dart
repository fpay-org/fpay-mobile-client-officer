import 'package:FPay/config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class FineService {
  final baseUrl = Config.baseUrl;
  var now = DateTime.now();
  String id = "456"; // get current user id
  var error;
  static Future<Position> getLocation() async {
    Position location =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return location;
  }
  Position location = getLocation() as Position;
  

  Future<bool> isuseFine(String _officer_id, String _driver_id,
          String _witness_id, List _fines) async =>
      Dio().post('$baseUrl/user/', data: {
        "main_officer_id": id,//get current user id
        "witness_officer_id": _officer_id,
        "driver_id": _driver_id,
        "fine_list": _fines,
        "time_stamp:": now,
        "location":location,
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
