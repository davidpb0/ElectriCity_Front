import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/user_controller.dart';

class User {
  List<Marker> personalUbi = [];
  List<LatLng> personalUbiBD = [];
  String username = "";
  String token = "";
  String email = "";
  int _id = 0;
  String tokenGoogle =
      "d8f2ac7af9bc7a48fd595dace56e49bd833ec008e45cfe90d775033c9ad6de4f1d11ce062268137f41f3d39d9528f8fe59110261783bfc8cbc2d7179e52a477cbf6ccc2e22b0e7de230025a517b31c16ea945c2ac3b1049a78599c5489287e12cc761f3919592b2e38d5f53353dd2970934aebcb1bf4e2b7db8b4dc639";

  User();

  User.fromJson(dynamic json) {
    username = json['email'];
    token = json['apiTokens'].last['token'];
    _id = json['id'];
    email = json['email'];
    if (json['favouriteLocations'] != null) {
      personalUbi = <Marker>[];
      for (int i = 0; i < json['favouriteLocations'].length; ++i) {
        personalUbi.add(Marker(
            markerId: MarkerId(
                (json['favouriteLocations'][i]['id'] + 3000).toString()
            ),
            position: LatLng(json['favouriteLocations'][i]['latitude'],
                json['favouriteLocations'][i]['longitude']
            ),
            icon: UserController().personalMarker,
            infoWindow: InfoWindow(
              title: json['favouriteLocations'][i]['title'],
              snippet: json['favouriteLocations'][i]['description'],
            )
        ));
      }
    }
  }

  Map toJson() {
    return {'email': email, 'id': _id};
  }

  getUserTkn() {
    return token;
  }

  getUserId() {
    return _id;
  }

  deletePersonalUbi(int index) {
    personalUbi.removeAt(index);
  }
}
