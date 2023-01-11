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

  int _electricoins = 0;
  int _theme = 0;
  int _avatar = 0;
  var _rawAwards;
  final List<bool> _themesUnlocked = [true, false, false, false, false, false, false, false];
  final List<bool> _avatarsUnlocked = [true, false, false, false, false, false, false, false, false, false, false, false];


  User();

  User.fromJson(dynamic json) {
    _username = json['username'];
    _id = json['id'];
    _email = json['email'];
    _electricoins = json['electryCoins'];
    _theme = json['skinPalette'] ?? 0;
    _avatar = json['skinAvatar'] ?? 0;
    _rawAwards = json['awards'];
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


    if (json['awards'] != null) {
      for (int i = 0; i < json['awards'].length; ++i) {
        String split = (json['awards'][i]['nameAward']).split('_');
        if(split[0] == 'avatar'){
          _avatarsUnlocked[int.parse(split[1])-1] = true;
        }
        else{
          _themesUnlocked[int.parse(split[1])-1] = true;
        }
      }

    }
  }

  getUserTkn() {
    return _token;
  }

  getUsername() {
    return _username;
  }

  getElectricoins() {
    return _electricoins;
  }
  setElectricoins(int value) {
    _electricoins = value;
  }

  setUsername(String username) {
    _username = username;
  }

  getUserId() {
    return _id;
  }

  getEmail() {
    return _email;
  }


  setToke(String tkn) {
    _token = tkn;
   }

  setEmail(String email) {
    _email = email;
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

  getUnlockedThemes() {
    return _themesUnlocked;
  }

  getUnlockedAvatars() {
    return _avatarsUnlocked;
  }

  getAvatar() {
    return _avatar;
  }

  getTheme() {
    return _theme;
  }

  getRawAwards(){
    return _rawAwards;
  }

  void unlockAvatar(int index){
    _avatarsUnlocked[index] = true;
  }

  void setAvatar(int index){
    _avatar = index;
  }

  void setRawAwards(var awards){
    _rawAwards = awards;
  }

  void unlockTheme(int index){
    _themesUnlocked[index] = true;
  }

  void setTheme(int index){
    _theme = index;
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
