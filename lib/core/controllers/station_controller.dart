import 'dart:async';
import 'dart:convert';
import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:intl/intl.dart';
import '../models/comment.dart';
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
    Response res = await _apiService.getData('/bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      StationList estaciones = StationList.fromJson(body);
      _bicinglist = estaciones.getBicingStations();
      return _bicinglist;
    } else {
      throw Exception('Error en función fetchBicingStations');
    }
  }

  void initStations() async {
    await fetchFirstBicingStations();
    await fetchFirstRechargeStations();
    streamBicingStations();
    streamRechargeStations();
  }

  Future<bool> fetchFirstBicingStations() async {
    Response res = await _apiService.getData('/bicing_stations');
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
    Response res = await _apiService.getData('/recharge_stations');
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
          await _apiService.getData('/bicing_stations?page=$bicisIterator');
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
      Response res = await _apiService
          .getData('/recharge_stations?page=$chargersIterator');
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
    Response res = await _apiService.getData('/recharge_stations');
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

  _addBicingComment(int id, Station bicing, String txt, String creator) {
    bicing.addComment(id, txt, creator);
  }

  addBicingCommentBD(Station bicing, String txt, String creator) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    var data = {"message": txt, "date": formattedDate};

    var aux = bicing.id;

    Response res =
        await _apiService.postData(data, "/bicing_stations/$aux/comments");
    var body = jsonDecode(res.body);
    if (res.statusCode == 201) {
      _addBicingComment(body["id"], bicing, txt, creator);
    } else {
      throw Exception('Error en función addBicingCommentBD');
    }
  }

  extractCommentsBicing(int id, Station bicing) async {
    Response res = await _apiService.getData("/bicing_stations/$id/comments");
    var body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      List<Comment> comments = [];
      for (int i = body["comments"].length - 1; i >= 0; --i) {
        Response res2 =
            await _apiService.getData(body["comments"][i]["userOwner"]);
        var body2 = jsonDecode(res2.body);

        Response res3 =
            await _apiService.getData(body["comments"][i]["bicingStation"]);
        var body3 = jsonDecode(res3.body);
        if (res3.statusCode == 200) {
          Comment comment = Comment(
              body["comments"][i]["id"],
              body["comments"][i]["message"],
              body2["username"],
              body["comments"][i]["date"],
              getBicingStationbyId(body3["id"]),
              null);
          comments.add(comment);
        } else {
          throw Exception('Error en función extractCommentsBicing segundo if');
        }
      }
      bicing.addListComments(comments);
      return true;
    } else {
      throw Exception('Error en función addBicingCommentBD');
    }
  }

  deleteBicingComment(Comment comment) async {
    Response res = await _apiService.deleteData(
        "/users/${UserController().currentUser.getUserId()}/comments/${comment.id}");
    if (res.statusCode == 200) {
      comment.bicing?.deleteComment(comment.id);
      return true;
    } else {
      throw Exception('Error en función deleteBicingComment');
    }
  }

  editBicingComment(Comment comment, String text) async {
    var data = {"message": text};
    Response res = await _apiService.putData(data, "/comments/${comment.id}");

    if (res.statusCode == 200) {
     comment.bicing?.editComment(comment.id, text);

      return true;
    } else {
      throw Exception('Error en función deleteBicingComment');
    }
  }

  _addChargerComment(
      int id, RechargeStation charger, String txt, String creator) {
    charger.addComment(id, txt, creator);
  }

  addChargerCommentBD(
      RechargeStation charger, String txt, String creator) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    var data = {"message": txt, "date": formattedDate};

    var aux = charger.id;

    Response res =
        await _apiService.postData(data, "/recharge_stations/$aux/comments");
    var body = jsonDecode(res.body);
    if (res.statusCode == 201) {
      _addChargerComment(body["id"], charger, txt, creator);
    } else {
      throw Exception('Error en función addBicingCommentBD');
    }
  }

  extractCommentsCharger(int id, RechargeStation charger) async {
    Response res = await _apiService.getData("/recharge_stations/$id/comments");
    var body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      List<Comment> comments = [];
      for (int i = body["comments"].length - 1; i >= 0; --i) {
        Response res2 =
            await _apiService.getData(body["comments"][i]["userOwner"]);
        var body2 = jsonDecode(res2.body);

        Response res3 =
            await _apiService.getData(body["comments"][i]["rechargeStation"]);
        var body3 = jsonDecode(res3.body);
        if (res3.statusCode == 200) {
          Comment comment = Comment(
              body["comments"][i]["id"],
              body["comments"][i]["message"],
              body2["username"],
              body["comments"][i]["date"],
              null,
              getRechargeStationbyId(body3["id"]));
          comments.add(comment);
        } else {
          throw Exception('Error en función extractCommentsCharger segundo if');
        }
      }
      charger.addListComments(comments);
      return true;
    } else {
      throw Exception('Error en función extractCommentsCharger');
    }
  }
  deleteChargerComment(Comment comment) async {
    Response res = await _apiService.deleteData(
        "/users/${UserController().currentUser.getUserId()}/comments/${comment.id}");
    if (res.statusCode == 200) {
      comment.charger?.deleteComment(comment.id);
      return true;
    } else {
      throw Exception('Error en función deleteChargerComment');
    }
  }
  editChargerComment(Comment comment, String text) async {
    var data = {"message": text};
    Response res = await _apiService.putData(data, "/comments/${comment.id}");

    if (res.statusCode == 200) {
      comment.charger?.editComment(comment.id, text);

      return true;
    } else {
      throw Exception('Error en función deleteBicingComment');
    }
  }

}
