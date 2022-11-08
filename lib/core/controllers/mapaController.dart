import 'dart:convert';

import 'package:electricity_front/core/models/StationList.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart';

import '../services/api_service.dart';

class MapaController {

  final ApiService _apiService = ApiService();
  late List<LatLng> Lista;

  factory MapaController(){
    if (_this == null) _this = MapaController._();
    return _this;
  }

  static MapaController _this = MapaController._();

  MapaController._();

  List<LatLng> markersBicing() {
    return Lista;
  }

  bicingApi() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(jsonDecode(res.body));
      Lista = estaciones.getCoords();
    } else {
      throw Exception('Algo falló');
    }
    print(res.statusCode);
  }





}