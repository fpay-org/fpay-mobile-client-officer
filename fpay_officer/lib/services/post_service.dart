import 'dart:async';
import 'package:FPay/config/config.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Post {
  String title;
  String content;
  String first_name;
  String last_name;
  //DateTime posted_at;
  Post(this.title, this.content, this.first_name, this.last_name);
}

class PostService {
  final baseUrl = Config.baseUrl;

  Future<Position> _getCurrentLocation() async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<Post>> getPosts() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //String officer = prefs.getString("officer");
    //Logger().i('$officer');
    return await Dio().get('$baseUrl/dashboard',).then((res) async {
      Logger().i("$res");
      List<Post> posts = [];
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
          Logger().i("here baby");
          Post post = Post(f["title"], f["content"], f["first_name"],f["last_name"]); //need to add other parameters
          posts.add(post);
          Logger().i("safaf0{$posts.length}");
        }

        return posts;
      }
      Logger().i("return false");
      return false;
    }).catchError((err) => false);
  }

  Future<bool> publishPost(String officer, String content , String title) async {
    Logger().i("possst");
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
    Logger().i('$officer');
    Logger().i('$content');
    Logger().i('$title');

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

    // return Dio().post('$baseUrl/fines', data: {}).then((res) async {
    //   if (res.statusCode == 201) {
    //     Logger().i("${res.statusCode}");
    //     return true;
    //   }
    //   return false;
    // }).catchError((err) {
    //   Logger().i("$err");
    //   return false;
    // });

    return Dio().post('$baseUrl/dashboard/post', data: {
      "title": title,
      "first_name": "",
      "last_name": "",
      "content": content,
      "officer": officer, //get current user id
      "location": {"name": address, "longitude": long, "latitude": lat},
      "image_url": ""
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

  Future<String> _getToken() {
    return SharedPreferences.getInstance().then((instance) {
      return instance.getString("token");
    });
  }
}
