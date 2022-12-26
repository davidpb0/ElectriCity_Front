import 'dart:convert';

import 'package:electricity_front/core/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../core/controllers/user_controller.dart';

class BookingController {
  final ApiService _apiService = ApiService();
  UserController userCtrl = UserController();

  var _stationid = "";

  var _date = "";
  String _dateError = "";

  late DateTime _starttime;
  String _timeError = "";

  late DateTime _endtime;

  bool _successfulBooking = false;


  factory BookingController() {
    return _this;
  }

  static final BookingController _this = BookingController._();

  BookingController._();
  
  void wipe(){
    _stationid = "";
    _date = "";
    _dateError = "";
    _starttime = DateTime.now();
    _timeError = "";
    _endtime = DateTime.now();
    _successfulBooking = false;
  }

  void setStationId(String id) {
    _stationid = id;
  }

  void setDate(String date) {
    _date = date;
  }

  void setStartTime(DateTime st) {
    _starttime = st;
  }

  void setEndTime(DateTime et) {
    _endtime = et;
  }

  void mockSuccess() {
    _successfulBooking = true;
  }

  bool validateDuration() {
    if (_endtime.difference(_starttime) < Duration.zero) {
      _timeError = "Ending timestamp must come after starting one";
      return false;
    }
    else if (_endtime.difference(_starttime) > const Duration(hours: 3)) {
      _timeError = "Booking duration cannot exceed 3 hours";
      return false;
    }
    else {
      return true;
    }
  }


  Future<bool> tryBooking(BuildContext ctext) async {
    var data = {
      "dataIni": '$_date ${DateFormat('HH:mm:ss').format(_starttime)}',
      "dataFi": '$_date ${DateFormat('HH:mm:ss').format(_endtime)}',
      "idStation": _stationid,
    };
    print(data);

    Response res = await _apiService.postData(data, '/reservations');
    var body = json.decode(res.body);
    print(body);
    if (res.statusCode == 201) {
      return true;
    } else {
      if (body["message"] == "There are not available slots for this date-time"){
        _dateError = "There are no available slots during the selected period";

      }
      return false;
    }
  }

  String dateError() {
    return _dateError;
  }

  String timeError() {
    return _timeError;
  }

  bool getSuccessfulBooking(){
    return _successfulBooking;
  }

}
