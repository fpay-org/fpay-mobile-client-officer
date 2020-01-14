import 'dart:async';
import 'package:FPay/config/config.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PostService {
  final baseUrl = Config.baseUrl;

  Future<Position> _getCurrentLocation() async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> publish(String officer, String content) async {
    Position _currentPosition = await _getCurrentLocation();
    Logger().i('start');
    String lat = _currentPosition.latitude.toString();
    String long = _currentPosition.longitude.toString();
    //List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat,long);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);
    Placemark place = placemark[0];
    String address = "${place.locality},${place.postalCode},${place.country}";
    Logger().i('${address}');
    Logger().i('$long');

    //String penalties_string = penalties.toString();

    Object location_string =
        {"name": address, "longitude": long, "latitude": lat}.toString();

    Logger().i('$location_string');

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

    return Dio().post('$baseUrl/fines', data: {}).then((res) async {
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

  Future<String> _getToken() {
    return SharedPreferences.getInstance().then((instance) {
      return instance.getString("token");
    });
  }
}
