import 'dart:convert';
import 'package:electricity_front/core/models/RechargeStation.dart';
import 'package:electricity_front/core/models/StationList.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart';
import '../services/api_service.dart';

class MapaController {

  final ApiService _apiService = ApiService();
  late List<LatLng> BicingList = <LatLng>[];
  late List<Station> BicingStationList = <Station>[];
  late List<RechargeStation> ChargerStationList = <RechargeStation>[];
  late List<LatLng> CargaList = <LatLng>[];


  factory MapaController(){
    if (_this == null) _this = MapaController._();
    return _this;
  }

  static MapaController _this = MapaController._();

  MapaController._();

  Future <List<LatLng>> markersBicing() async{
    print(BicingList.length);
    return BicingList;
  }

  bicingApi() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(body);
      BicingList = estaciones.getCoords();
      BicingStationList = estaciones.getBicingStations();
      print("Estacions Bicing");
      print(BicingList.length);
      print(BicingList.getRange(0, 10));
    } else {
      throw Exception('Algo falló');
    }
    print(res.statusCode);
    print(body);
  }

  rechargeApi() async {
    Response res = await _apiService.getData('recharge_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      RechargeStationList rcSt = RechargeStationList.fromJson(body);
      CargaList = rcSt.getCoordsRcSt();
      ChargerStationList = rcSt.getChargerStations();
      print("Estacions carga");
      print(CargaList.length);
      print(CargaList.getRange(0, 10));
    } else {
      throw Exception('Algo falló');
    }
    print(res.statusCode);
    print(body);
  }





}