import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/core/models/station_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/user_controller.dart';

class User {
  List<Marker> _personalUbi = [];
  List<LatLng> personalUbiBD = [];
  final List<Station> _favouriteBicingStation = [];
  final List<RechargeStation> _favouriteChargerStation = [];
  final List<String> _favouriteBicingStationIndex = [];
  final List<String> _favouriteChargerStationIndex = [];
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
            )
        ));
      }
    }

    if (json['favouriteBicingStations'] != null) {
      for (int i = 0; i < json['favouriteBicingStations'].length; ++i) {
        String id = json['favouriteBicingStations'][i];
        id = id.split("/").last;
        _favouriteBicingStationIndex.add(id);
      }
    }

    if (json['favouriteRechargeStations'] != null) {
      for (int i = 0; i < json['favouriteRechargeStations'].length; ++i) {
        String id = json['favouriteRechargeStations'][i].toString();
        id = id.split("/").last;
        _favouriteChargerStationIndex.add(id);
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

  ///Aqui empiezan funciones con Lista Indice a conservar

  getFavouriteBicingStations() {
    return _favouriteBicingStationIndex;
  }

  getFavouriteRechargeStations() {
    return _favouriteChargerStationIndex;
  }

  isFavouriteBicingStationIndex(String index) {
    return _favouriteBicingStationIndex.contains(index);
  }

  isFavouriteRechargeStationIndex(String index) {
    return _favouriteChargerStationIndex.contains(index);
  }

  addFavouriteBicingStationIndex(String index) {
    _favouriteBicingStationIndex.add(index);
  }

  addFavouriteRechargeStationIndex(String index) {
    _favouriteChargerStationIndex.add(index);
  }

  deleteFavouriteBicingStationIndex(String idStation) {
    return _favouriteBicingStationIndex.remove(idStation);
  }

  deleteFavouriteRechargeStationIndex(String idStation) {
    return _favouriteChargerStationIndex.remove(idStation);
  }

}
