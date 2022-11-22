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

  bicingApi() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    print(res.statusCode.toString());
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(body);
      bicingList = estaciones.getCoords();
      bicingStationList = estaciones.getBicingStations();
      //print("Estacions Bicing");
      //print(bicingList.length);
      //print(bicingList.getRange(0, 10));
    } else {
      throw Exception('Algo falló');
    }
    //print(res.statusCode);
    //print(body);
  }

  rechargeApi() async {
    Response res = await _apiService.getData('recharge_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      RechargeStationList rcSt = RechargeStationList.fromJson(body);
      cargaList = rcSt.getCoordsRcSt();
      chargerStationList = rcSt.getChargerStations();
      //print("Estacions carga");
      //print(cargaList.length);
      //print(cargaList.getRange(0, 10));
    } else {
      throw Exception('Algo falló');
    }
    //print(res.statusCode);
    //print(body);
  }

  personalUbi(String tit, String? desc, BuildContext context) {
    Marker marker = Marker(
      markerId: MarkerId(
          (3000 + UserController().currentUser.personalUbi.length)
              .toString()),
      position: coords,
      icon: personalMarker,
      infoWindow: InfoWindow(
        title: tit,
        snippet: desc,
      ),
    );
    UserController().currentUser.personalUbi.add(marker);
    UserController().currentUser.personalUbiBD.add(coords);
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void setGoogleMapaState(GoogleMapaState googleMapaState) {
    this.googleMapaState = googleMapaState;
  }

  GoogleMapaState getGoogleMapa() {
    return googleMapaState;
  }

}
