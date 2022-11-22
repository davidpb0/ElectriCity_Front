import 'package:electricity_front/core/controllers/login_controller.dart';
import 'package:electricity_front/core/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class UserController {


  late User currentUser = User();

  factory UserController(){
    return _this;
  }

  static final UserController _this = UserController._();

  UserController._();


  startSession(String mail, String pwd, BuildContext ctext) async {
    try {
      currentUser = await LoginController().logIn(mail, pwd, ctext);
      ApiService().setToken(currentUser.token);
    } catch (e) {
      Container();
    }
  }



void logOut(BuildContext ctxt) {
  currentUser = User();
  ApiService().setToken("");
  Navigator.of(ctxt).pushReplacementNamed('/login');
}

}