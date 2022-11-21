import 'package:electricity_front/core/controllers/login_controller.dart';
import 'package:electricity_front/core/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class UserController{


  late User currentUser = User();

  factory UserController(){
    return _this;
  }

  static final UserController _this = UserController._();
  UserController._();



 startSession(String mail, String pwd, BuildContext ctext) async{
   currentUser = await LoginController().logIn(mail, pwd, ctext);
   ApiService().setToken(currentUser.token);

 }

  void logOut(BuildContext ctxt){
   currentUser = User();
   ApiService().setToken("");
   Navigator.of(ctxt).pushReplacementNamed('/login');
  }

  bool deleteUser() async{
    String endpoint = 'users/' + currentUser.getUserId();
    response res = await ApiService().deleteData(endpoint);
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
    return true;
    } else {
    throw Exception('Algo falló');
    return false;
    }

  }

}