import 'dart:convert';
import '../models/StationList.dart';
import 'package:http/http.dart';

import '../services/api_service.dart';

class ListController {
  static final ListController _this = ListController._();
  final ApiService _apiService = ApiService();

  late StationList _list;

  factory ListController() {
    return _this;
  }

  ListController._();

  getstations() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      _list = StationList.fromJson(body);
    } else {
      throw Exception('Algo falló');
    }
    //print(res.statusCode);
  }

  int getTotalStations() {
    return _list.totalItems;
  }

  Station getStation(int index) {
    return _list.listMember.elementAt(index);
  }
}
