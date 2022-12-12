import 'dart:async';
import 'dart:convert';

import 'package:electricity_front/core/models/recharge_station.dart';
import '../models/station_list.dart';
import 'package:http/http.dart';

import '../services/api_service.dart';

class StationController {
  final ApiService _apiService = ApiService();
  late List<Station> _bicinglist;
  late List<RechargeStation> _rechargelist;
  bool bici = true;
  bool bicisStarted = false;
  bool chargersStarted = false;
  bool bicisComplete = false;
  bool chargersComplete = false;
  int bicisIterator = 2;
  int chargersIterator = 2;

  StreamController<int> rechargeStationStreamController =
      StreamController<int>.broadcast();
  StreamController<int> bicingStationStreamController =
      StreamController<int>.broadcast();

  factory StationController() {
    return _this;
  }

  static final StationController _this = StationController._();

  StationController._();

  Future<List<Station>> fetchBicingStations() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(body);
      _bicinglist = estaciones.getBicingStations();
      return _bicinglist;
    } else {
      throw Exception('Error en función fetchBicingStations');
    }
  }



  void initStations() async{
    await fetchFirstBicingStations();
    await fetchFirstRechargeStations();
    streamBicingStations();
    streamRechargeStations();
  }

  Future<bool> fetchFirstBicingStations() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(body);
      _bicinglist = estaciones.getBicingStations();
      bicisStarted = true;
      return true;
    } else {
      throw Exception('Error en función fetchFirstBicingStations');
    }
  }

  Future<bool> fetchFirstRechargeStations() async {

    Response res = await _apiService.getData('recharge_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      RechargeStationList rcSt = RechargeStationList.fromJson(body);
      _rechargelist = rcSt.getChargerStations();
      chargersStarted = true;
      return true;
    } else {
      throw Exception('Error en función fetchFirstRechargeStations');
    }
  }

  void streamBicingStations() async {
    while (!bicisComplete) {
      Response res =
          await _apiService.getData('bicing_stations?page=$bicisIterator');
      var body = json.decode(res.body);
      if (res.statusCode == 200) {
        StationList estaciones = StationList.fromJson(body);
        if (estaciones.listMember.isEmpty) {
          bicisComplete = true;
        } else {
          _bicinglist.addAll(estaciones.getBicingStations());
          bicingStationStreamController.add(_bicinglist.length);
          bicisIterator++;
        }
      } else {
        throw Exception('Error en función streamBicingStations');
      }
    }
  }

  void streamRechargeStations() async {
    while (!chargersComplete) {
      Response res =
          await _apiService.getData('recharge_stations?page=$chargersIterator');
      var body = json.decode(res.body);
      if (res.statusCode == 200) {
        RechargeStationList estaciones = RechargeStationList.fromJson(body);
        if (estaciones.chargeStation.isEmpty) {
          chargersComplete = true;
        } else {
          _rechargelist.addAll(estaciones.getChargerStations());
          rechargeStationStreamController.add(_rechargelist.length);
          chargersIterator++;
        }
      } else {
        throw Exception('Error en función streamRechargeStations');
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
      throw Exception('Error en función fetchRechargeStations');
    }
  }

  Stream<int> getRechargeStationsStream() {
    return rechargeStationStreamController.stream;
  }

  Stream<int> getBicingStationsStream() {
    return bicingStationStreamController.stream;
  }

  int getTotalBicingStations() {
    if (!bicisStarted) return 0;
    return _bicinglist.length;
  }

  int getTotalRechargeStations() {
    if (!chargersStarted) return 0;
    return _rechargelist.length;
  }

  Station getBicingStation(int index) {
    return _bicinglist.elementAt(index);
  }

  Station getBicingStationbyId(int id) {
    return _bicinglist.singleWhere((o) => o.id == id);
  }

  RechargeStation getRechargeStation(int index) {
    return _rechargelist.elementAt(index);
  }

  RechargeStation getRechargeStationbyId(int id) {
    return _rechargelist.singleWhere((o) => o.id == id);
  }

}
