import 'dart:convert';
import 'package:electricity_front/core/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../services/api_service.dart';

class LoginController {

  static final LoginController _this = LoginController._();

  final ApiService _apiService = ApiService();
  

  factory LoginController() {
    return _this;
  }

  LoginController._();


  logIn(String mail, String pwd, BuildContext ctext) async {
    var data = {
      "username": mail,
      "password": pwd,
    };

    Response res = await _apiService.login(data, 'login');
    var body = json.decode(res.body);
    if (body['message'] == 'Successfull login') {
      Navigator.of(ctext).pushReplacementNamed('/home');
      return User.fromJson(body);
    }

    //print(_userController.current_user.username);
    //print(body['user']['tokens'].first);
    //print(_loggedUser?.username);
  }

}
