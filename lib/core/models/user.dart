import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/core/models/station_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/user_controller.dart';

class User {
  List<Marker> _personalUbi = [];
  List<LatLng> personalUbiBD = [];
  final List<Station> _favouriteBicingStation = [];
  final List<RechargeStation> _favouriteChargerStation = [];
  String _username = "";
  String _token = "";
  String _email = "";
  int _id = 0;

  User();

  User.fromJson(dynamic json) {
    _username = json['email'];
    _token = json['apiTokens'].last['token'];
    _id = json['id'];
    _email = json['email'];
    if (json['favouriteLocations'] != null) {
      _personalUbi = <Marker>[];
      for (int i = 0; i < json['favouriteLocations'].length; ++i) {
        _personalUbi.add(Marker(
            markerId: MarkerId(
                (json['favouriteLocations'][i]['id'] + 3000).toString()),
            position: LatLng(json['favouriteLocations'][i]['latitude'],
                json['favouriteLocations'][i]['longitude']),
            icon: UserController().personalMarker,
            infoWindow: InfoWindow(
              title: json['favouriteLocations'][i]['title'],
              snippet: json['favouriteLocations'][i]['description'],
            )));
      }
    }
  }

  getUserTkn() {
    return _token;
  }

  getUsername(){
    return _username;
  }

  getUserId() {
    return _id;
  }

  getEmail(){
    return _email;
  }

  addPersonalUbi(Marker marker) {
    _personalUbi.add(marker);
  }

  deletePersonalUbi(int index) {
    _personalUbi.removeAt(index);
  }

  getPersonalUbi() {
    return _personalUbi;
  }

  isFavouriteBicing(Station bicing) {
    return _favouriteBicingStation.contains(bicing);
  }

  isFavouriteCharger(RechargeStation charger) {
    return _favouriteChargerStation.contains(charger);
  }

  addFavBicing(Station bicing) {
    _favouriteBicingStation.add(bicing);
  }

  deleteFavBicing(Station bicing) {
    _favouriteBicingStation.remove(bicing);
  }

  addFavCharger(RechargeStation charger) {
    _favouriteChargerStation.add(charger);
  }

  deleteFavCharger(RechargeStation charger) {
    _favouriteChargerStation.remove(charger);
  }

  getFavBicing() {
    return _favouriteBicingStation;
  }

  getFavCharger() {
    return _favouriteChargerStation;
  }
}
