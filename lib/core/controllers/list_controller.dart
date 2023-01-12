import 'dart:async';
import 'dart:convert';

import 'package:electricity_front/core/controllers/station_controller.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import '../models/station_list.dart';
import 'package:http/http.dart';

import '../services/api_service.dart';

class ListController {
  final ApiService _apiService = ApiService();
  late List<Station> _filterBicinglist;
  List<Station> filterBicingListSlots = [];
  List<Station> filterBicingListBikes = [];
  List<Station> filterBicingListEbikes = [];
  late List<RechargeStation> _filterRechargelist;
  bool bici = true;
  bool bicisStarted = false;
  bool chargersStarted = false;
  bool bicisComplete = false;
  bool chargersComplete = false;
  int bicisIterator = 2;
  int chargersIterator = 2;

  // FILTERS BICING
  bool filterSlots = false;
  bool filterBikes = false;
  bool filterEBikes = false;


  // filter recharge station

  StreamController<List<RechargeStation>> rechargeStationStreamController =
  StreamController<List<RechargeStation>>.broadcast();

  factory ListController() {
    return _this;
  }

  static final ListController _this = ListController._();

  ListController._();

  // filter bicing stations fetch

  //SLOTS

  void initFilters() {
    filterBicingStationsSlots();
    filterBicingStationsBikes();
    filterBicingStationsEbikes();
  }

  void filterBicingStationsSlots() {
    for (int i = 0; i < StationController().getTotalBicingStations(); ++i){
      if (StationController().getBicingStation(i).availableSlots > 0){
        filterBicingListSlots.add(StationController().getBicingStation(i));
      }
    }
  }

  void filterBicingStationsBikes() {
    for (int i = 0; i < StationController().getTotalBicingStations(); ++i){
      if (StationController().getBicingStation(i).mechanical > 0){
        filterBicingListBikes.add(StationController().getBicingStation(i));
      }
    }
  }

  void filterBicingStationsEbikes() {
    for (int i = 0; i < StationController().getTotalBicingStations(); ++i){
      if (StationController().getBicingStation(i).electrical > 0){
        filterBicingListEbikes.add(StationController().getBicingStation(i));
      }
    }
  }

  void streamBicingStations() async {
    while (!bicisComplete) {
      Response res =
      await _apiService.getData('/bicing_stations?page=$bicisIterator');
      var body = json.decode(res.body);
      if (res.statusCode == 200) {
        StationList estaciones = StationList.fromJson(body);
        if (estaciones.listMember.isEmpty) {
          bicisComplete = true;
        } else {
          //bicingStationStreamController.add(estaciones.listMember);
          _filterBicinglist.addAll(estaciones.listMember);
          bicisIterator++;
        }
      } else {
        throw Exception('Error en función streamBicingStations');
      }
    }
  }
  /*
  Future<List<Station>> fetchBicingStations() async {
    Response res = await _apiService.getData('/bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(body);
      _filterBicinglist = estaciones.getBicingStations();
      return _filterBicinglist;
    } else {
      throw Exception('Error en función fetchBicingStations');
    }
  }

   */

  void fetchFirstBicingStations() async {
    Response res = await _apiService.getData('/bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(body);
      _filterBicinglist = estaciones.getBicingStations();
      bicisStarted = true;
    } else {
      throw Exception('Error en función fetchFirstBicingStations');
    }
  }

  void fetchFirstRechargeStations() async {
    Response res = await _apiService.getData('/recharge_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      RechargeStationList rcSt = RechargeStationList.fromJson(body);
      _filterRechargelist = rcSt.getChargerStations();
      chargersStarted = true;
    } else {
      throw Exception('Error en función fetchFirstRechargeStations');
    }
  }
/*
  void streamBicingStations() async {
    while (!bicisComplete) {
      Response res =
          await _apiService.getData('/bicing_stations?page=$bicisIterator');
      var body = json.decode(res.body);
      if (res.statusCode == 200) {
        StationList estaciones = StationList.fromJson(body);
        if (estaciones.listMember.isEmpty) {
          bicisComplete = true;
        } else {
          bicingStationStreamController.add(estaciones.listMember);
          _filterBicinglist.addAll(estaciones.listMember);
          bicisIterator++;
        }
      } else {
        throw Exception('Error en función streamBicingStations');
      }
    }
  }

 */

  void streamRechargeStations() async {
    while (!chargersComplete) {
      Response res =
          await _apiService.getData('/recharge_stations?page=$chargersIterator');
      var body = json.decode(res.body);
      if (res.statusCode == 200) {
        RechargeStationList estaciones = RechargeStationList.fromJson(body);
        if (estaciones.chargeStation.isEmpty) {
          chargersComplete = true;
        } else {
          rechargeStationStreamController.add(estaciones.chargeStation);
          _filterRechargelist.addAll(estaciones.chargeStation);
          chargersIterator++;
        }
      } else {
        throw Exception('Error en función streamRechargeStations');
      }
    }
  }

  Future<List<RechargeStation>> fetchRechargeStations() async {
    Response res = await _apiService.getData('/recharge_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      RechargeStationList rcSt = RechargeStationList.fromJson(body);
      _filterRechargelist = rcSt.getChargerStations();
      return _filterRechargelist;
    } else {
      throw Exception('Error en función fetchRechargeStations');
    }
  }

  Stream<List<RechargeStation>> getRechargeStationsStream() {
    return rechargeStationStreamController.stream;
  }
/*
  Stream<List<Station>> getBicingStationsStream() {
    return bicingStationStreamController.stream;
  }

 */

  int getTotalBicingStations() {
    if (!bicisStarted) return 0;
    return _filterBicinglist.length;
  }

  int getTotalRechargeStations() {
    if (!chargersStarted) return 0;
    return _filterRechargelist.length;
  }

  Station getBicingStation(int index) {
    return _filterBicinglist.elementAt(index);
  }

  Station getBicingStationbyId(int id) {
    return _filterBicinglist.singleWhere((o) => o.id == id);
  }

  RechargeStation getRechargeStation(int index) {
    return _filterRechargelist.elementAt(index);
  }

  RechargeStation getRechargeStationbyId(int id) {
    return _filterRechargelist.singleWhere((o) => o.id == id);
  }

  void filterBicingStations(String filter){
    if (filter == "slots"){
      if (filterSlots){
        filterSlots = false;
      }
      else {
        filterSlots = true;
        filterEBikes = false;
        filterBikes = false;
      }
    }
    if (filter == "bikes"){
      if (filterBikes){
        filterBikes = false;
      }
      else {
        filterBikes = true;
        filterEBikes = false;
        filterSlots = false;
      }
    }
    if (filter == "ebikes"){
      if (filterEBikes){
        filterEBikes = false;
      }
      else {
        filterEBikes = true;
        filterBikes = false;
        filterSlots = false;
      }
    }
  }


}
