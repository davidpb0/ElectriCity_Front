import 'dart:convert';

import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart';

import '../services/api_service.dart';

class MapaController {

  final ApiService _apiService = ApiService();

  factory MapaController(){
    if (_this == null) _this = MapaController._();
    return _this;
  }

  static MapaController _this = MapaController._();

  MapaController._();

  List<LatLng>? markersBicing() {
    List<LatLng>? lista;
    return lista;
  }

  bicingAPi() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    if (body['message'] == 'Successfull login'){

    };
    print(res.statusCode);
    print(res.body.toString());
    // print(_loggedUser?.username);

  }



}