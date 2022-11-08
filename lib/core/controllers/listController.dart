import 'dart:convert';

import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import '../models/StationList.dart';
import 'package:http/http.dart';

import '../services/api_service.dart';

class ListController {

  final ApiService _apiService = ApiService();
  late StationList _list;

  factory ListController(){
    if (_this == null) _this = ListController._();
    return _this;
  }

  static ListController _this = ListController._();

  ListController._();

  getstations() async {
    Response res = await _apiService.getData('bicing_stations');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      _list = StationList.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Algo falló');
    }
    print(res.statusCode);
  }
  Station getStation(int index){
    return _list.listMember.elementAt(index);
  }

  }
