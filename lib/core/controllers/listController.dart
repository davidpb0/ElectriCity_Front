import 'dart:convert';

import 'package:electricity_front/core/models/RechargeStation.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import '../models/StationList.dart';
import 'package:http/http.dart';

import '../services/api_service.dart';

class ListController {

  final ApiService _apiService = ApiService();
  late StationList _bicinglist;
  late RechargeStationList _rechargelist;
  bool bici = true;

  factory ListController(){
    if (_this == null) _this = ListController._();
    return _this;
  }

  static ListController _this = ListController._();

  ListController._();

  Future<StationList> fetchBicingStations() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
     return StationList.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Algo falló');
    }
    print(res.statusCode);
  }

  Future<RechargeStationList> fetchRechargeStations() async {
    Response res = await _apiService.getData('recharge_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return RechargeStationList.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Algo falló');
    }
    print(res.statusCode);
  }

  int getTotalBicingStations(){
    return _bicinglist.totalItems;
  }

  int getTotalRechargeStations(){
    return _rechargelist.totalItems;
  }

  Station getBicingStation(int index){
    return _bicinglist.listMember.elementAt(index);
  }

  RechargeStation getRechargeStation(int index){
    return _rechargelist.ChargeStation.elementAt(index);
  }

  }
