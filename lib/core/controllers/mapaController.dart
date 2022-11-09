import 'dart:convert';

import 'package:electricity_front/core/models/StationList.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart';

import '../services/api_service.dart';

class MapaController {

  final ApiService _apiService = ApiService();
  late List<LatLng> Lista = <LatLng>[];

  factory MapaController(){
    if (_this == null) _this = MapaController._();
    return _this;
  }

  static MapaController _this = MapaController._();

  MapaController._();

  Future <List<LatLng>> markersBicing() async{
    print(Lista.length);
    return Lista;
  }

  bicingApi() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(body);
      Lista = estaciones.getCoords();
      print(Lista.length);
      print(Lista.getRange(0, 10));
    } else {
      throw Exception('Algo falló');
    }
    print(res.statusCode);
    print(body);
  }





}