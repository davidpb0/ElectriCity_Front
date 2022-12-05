import 'dart:convert';

import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:electricity_front/core/models/station_list.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(body);
      bicingList.addAll(estaciones.getCoords());
      bicingStationList.addAll(estaciones.getBicingStations());
    }
    else {
      throw Exception('Error en función bicingApi');
    }
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
    }
    else {
      throw Exception('Error en función rechargeApi');
    }
  }

  personalUbi(String tit, String? desc, BuildContext context) async {
    String urlPrueba =
        "users/${UserController().currentUser.getUserId()}/locations";
    var data = {
      "id": 3000 + UserController().currentUser.getPersonalUbi().length,
      "latitude": coords.latitude,
      "longitude": coords.longitude,
      "title": tit,
      "description": desc
    };
    Response res = await ApiService().postPersonalUbi(data, urlPrueba);
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
      UserController().currentUser.addPersonalUbi(marker);
      UserController().currentUser.personalUbiBD.add(coords);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  routePainting(PointLatLng origin, PointLatLng destination) async {
    var data = {
      "latitudeA": origin.latitude,
      "longitudeA": origin.longitude,
      "latitudeB": destination.latitude,
      "longitudeB": destination.longitude,
      "numStations": 1
    };

    Response res = await _apiService.routePainting(data, 'route/station');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      List<PointLatLng> pointsList = <PointLatLng>[];
      for (int i = 0; i < body.length; ++i) {
        PointLatLng pointLatLng =
            PointLatLng(body[i]['latitude'], body[i]['longitude']);
        pointsList.add(pointLatLng);
      }
      return pointsList;
    }
    else {
      throw Exception(
          "Error in API request of creation of route painting, StatudCode: ${res.statusCode}"
      );
    }
  }

  void setGoogleMapaState(GoogleMapaState googleMapaState) {
    this.googleMapaState = googleMapaState;
  }

  GoogleMapaState getGoogleMapa() {
    return googleMapaState;
  }
}
