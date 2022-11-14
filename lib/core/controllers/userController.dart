import 'package:electricity_front/core/controllers/loginController.dart';
import 'package:electricity_front/core/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class UserController{


  late User current_user = User();

  factory UserController(){
    if (_this == null) _this = UserController._();
    return _this;
  }

  static UserController _this = UserController._();
  UserController._();



 startSession(String mail, String pwd, BuildContext ctext) async{
   current_user = await LoginController().logIn(mail, pwd, ctext);
   ApiService().setToken(current_user.token);
   Navigator.of(ctext).pushReplacementNamed('/home');
 }

  void logOut(BuildContext ctxt){
   current_user = User();
   ApiService().setToken("");
   Navigator.of(ctxt).pushReplacementNamed('/login');
  }
}