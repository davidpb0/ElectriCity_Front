import 'package:google_maps_flutter/google_maps_flutter.dart';

class User{
  String? username;
  String? token;
  List<Marker> personal_ubi = [];

  User();

  User.fromJson(dynamic json){
      username = json['user']['email'];
      //token = json['user']['tokens'].first;
  }

Map toJson(){
  return{'email': username, 'token': token};
}

  printData(){
    print(username);
  }
}
