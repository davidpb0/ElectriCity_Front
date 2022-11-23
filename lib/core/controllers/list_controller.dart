import 'dart:async';
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
  bool bicisStarted = false;
  bool chargersStarted = false;

  StreamController<List<RechargeStation>> rechargeStationStreamController = StreamController<List<RechargeStation>>.broadcast();
  StreamController<List<Station>> bicingStationStreamController = StreamController<List<Station>>.broadcast();

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
  void fetchFirstBicingStations() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      print('first bicing stations recieved');
      StationList estaciones = StationList.fromJson(body);
      _bicinglist = estaciones.getBicingStations();
      bicisStarted = true;
    } else {
      throw Exception('Algo falló');
    }
  }

  void fetchFirstRechargeStations() async {
    Response res = await _apiService.getData('recharge_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      print('first recharge stations recieved');
      RechargeStationList rcSt = RechargeStationList.fromJson(body);
      _rechargelist = rcSt.getChargerStations();
      chargersStarted = true;
    } else {
      throw Exception('Algo falló');
    }
  }

  void streamBicingStations() async {
    int i = 2;
    bool done = false;
    while(!done) {
      Response res = await _apiService.getData('bicing_stations?page=$i');
      var body = json.decode(res.body);
      print('bicing iteration ' + i.toString() + res.statusCode.toString());
      if (res.statusCode == 200) {
        StationList estaciones = StationList.fromJson(body);
        if(estaciones.listMember.length == 0){
          done = true;
        }
        else {
          bicingStationStreamController.add(estaciones.listMember);
          _bicinglist.addAll(estaciones.listMember);
          i++;
        }
      } else {
        throw Exception('Algo falló');
    }

    }
  }

  void streamRechargeStations() async {
    int i = 2;
    bool done = false;
    while(!done) {
      Response res = await _apiService.getData('recharge_stations?page=$i');
      var body = json.decode(res.body);
      print('recharge iteration ' + i.toString() + res.statusCode.toString());
      if (res.statusCode == 200) {
        RechargeStationList estaciones = RechargeStationList.fromJson(body);
        if(estaciones.chargeStation.length == 0){
          done = true;
        }
        else {
          rechargeStationStreamController.add(estaciones.chargeStation);
          _rechargelist.addAll(estaciones.chargeStation);
          i++;
        }
      } else {
        throw Exception('Algo falló');
      }

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

  Stream<List<RechargeStation>> getRechargeStationsStream(){
    return rechargeStationStreamController.stream;
  }

  Stream<List<Station>> getBicingStationsStream(){
    return bicingStationStreamController.stream;
  }

  int getTotalBicingStations(){
    print("bicis:" + _bicinglist.length.toString());
    return _bicinglist.length;
  }

  int getTotalRechargeStations(){
    print("eCar:" + _rechargelist.length.toString());
    return _rechargelist.length;
  }

  Station getBicingStation(int index){
    return _bicinglist.elementAt(index);
  }

  RechargeStation getRechargeStation(int index){
    return _rechargelist.elementAt(index);
  }

  }
