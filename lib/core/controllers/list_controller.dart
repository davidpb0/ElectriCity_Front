import 'dart:convert';

import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import '../models/StationList.dart';
import 'package:http/http.dart';

import '../services/api_service.dart';

class ListController {

  final ApiService _apiService = ApiService();
  late List<Station> _bicinglist;
  late List<RechargeStation> _rechargelist;
  bool bici = true;

  factory ListController(){
    if (_this == null) _this = ListController._();
    return _this;
  }

  static ListController _this = ListController._();

  ListController._();

  Future<List<Station>> fetchBicingStations() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(body);
      _bicinglist = estaciones.getBicingStations();
     return _bicinglist;
    } else {
      throw Exception('Algo falló');
    }
  }

  Future<List<RechargeStation>> fetchRechargeStations() async {
    Response res = await _apiService.getData('recharge_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      RechargeStationList rcSt = RechargeStationList.fromJson(body);
      _rechargelist = rcSt.getChargerStations();
      return _rechargelist;
    } else {
      throw Exception('Algo falló');
    }
  }

  int getTotalBicingStations(){
    return _bicinglist.length;
  }

  int getTotalRechargeStations(){
    return _rechargelist.length;
  }

  Station getBicingStation(int index){
    return _bicinglist.elementAt(index);
  }

  RechargeStation getRechargeStation(int index){
    return _rechargelist.elementAt(index);
  }

  }
