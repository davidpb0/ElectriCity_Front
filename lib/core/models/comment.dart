
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/core/models/station_list.dart';

class Comment{

  late int id;
  late String creator;
  late String text;
  late String timestamp;
  late Station ?bicing;
  late RechargeStation ?charger;

  Comment(this.id, this.text, this.creator, this.timestamp, this.bicing, this.charger);
}