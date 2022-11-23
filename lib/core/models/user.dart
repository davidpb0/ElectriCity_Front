import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  List<Marker> personalUbi = [];
  List<LatLng> personalUbiBD = [];
  String username = "";
  String token = "";
  String email = "";
  int id = 0;

  String tokenGoogle =
      "d8f2ac7af9bc7a48fd595dace56e49bd833ec008e45cfe90d775033c9ad6de4f1d11ce062268137f41f3d39d9528f8fe59110261783bfc8cbc2d7179e52a477cbf6ccc2e22b0e7de230025a517b31c16ea945c2ac3b1049a78599c5489287e12cc761f3919592b2e38d5f53353dd2970934aebcb1bf4e2b7db8b4dc639";

  User();

  User.fromJson(dynamic json) {
    username = json['email'];
    token = json['apiTokensValues'].last;
    id = json['id'];
    email = json['email'];

  }

  Map toJson() {
    return {'email': email, 'id' : id };
  }

  getUserTkn() {
    return token;
  }

}
