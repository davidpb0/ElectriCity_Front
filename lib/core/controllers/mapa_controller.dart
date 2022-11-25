import 'dart:convert';

import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:electricity_front/core/models/StationList.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

import '../../ui/views/mapa.dart';
import '../services/api_service.dart';

class MapaController {
  final ApiService _apiService = ApiService();
  late List<LatLng> bicingList = <LatLng>[];
  late List<Station> bicingStationList = <Station>[];
  late List<RechargeStation> chargerStationList = <RechargeStation>[];
  late List<LatLng> cargaList = <LatLng>[];

  late LatLng coords;
  late BitmapDescriptor personalMarker;

  late GoogleMapaState googleMapaState;

  factory MapaController() {
    return _this;
  }

  static final MapaController _this = MapaController._();

  MapaController._();

  Future<List<LatLng>> markersBicing() async {
    //print(bicingList.length);
    return bicingList;
  }

  initBD() async {
    await _apiService.getData('station_bicing');
  }

  bicingApi(int numPage) async {
    if (numPage == 1) {
      bicingStationList.clear();
      bicingList.clear();
    }
    Response res = await _apiService.getData('bicing_stations?page=$numPage');
    var body = json.decode(res.body);
    //print(res.statusCode.toString());
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(body);
      bicingList.addAll(estaciones.getCoords());
      bicingStationList.addAll(estaciones.getBicingStations());
      //print("Estacions Bicing");
      //print(bicingList.length);
      //print(bicingList.getRange(0, 10));

    } else {
      throw Exception('Algo falló');
    }
    //print(res.statusCode);
    //print(body);
  }

  rechargeApi(int numPage) async {
    if (numPage == 1) {
      chargerStationList.clear();
      cargaList.clear();
    }
    Response res = await _apiService.getData('recharge_stations?page=$numPage');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      RechargeStationList rcSt = RechargeStationList.fromJson(body);
      cargaList.addAll(rcSt.getCoordsRcSt());
      chargerStationList.addAll(rcSt.getChargerStations());
      //print("Estacions carga");
      //print(cargaList.length);
      //print(cargaList.getRange(0, 10));
    } else {
      throw Exception('Algo falló');
    }
    //print(res.statusCode);
    //print(body);
  }

  personalUbi(String tit, String? desc, BuildContext context) async {
    String urlPrueba = "https://localhost/users/" +
        UserController().currentUser.getUserId().toString() +
        "/locations";
    var data = {
      "id": 3000 + UserController().currentUser.personalUbi.length,
      "latitude": coords.latitude,
      "longitude": coords.longitude,
      "title": tit,
      "description": desc
    };
    Response res = await ApiService().postPersonalUbi(data, urlPrueba);
    print(UserController().currentUser.getUserId().toString());
    var body = jsonDecode(res.body);
    if (res.statusCode == 201) {
      Marker marker = Marker(
        markerId:
            MarkerId((body['favouriteLocations'].last['id'] + 3000).toString()),
        position: coords,
        icon: personalMarker,
        infoWindow: InfoWindow(
          title: tit,
          snippet: desc,
        ),
      );
      UserController().currentUser.personalUbi.add(marker);
      UserController().currentUser.personalUbiBD.add(coords);
      print(res.statusCode.toString());
      Navigator.of(context).pushReplacementNamed('/home');
    }

  }

  void setGoogleMapaState(GoogleMapaState googleMapaState) {
    this.googleMapaState = googleMapaState;
  }

  GoogleMapaState getGoogleMapa() {
    return googleMapaState;
  }
}
