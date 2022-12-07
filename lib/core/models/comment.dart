import 'package:electricity_front/core/models/user.dart';

class Comment{


  late User creator;
  late String text;
  late String timestamp;

  Comment(this.text, this.creator, this.timestamp);
}