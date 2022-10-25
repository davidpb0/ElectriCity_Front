
import 'dart:convert';

import 'package:electricity_front/core/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../models/login_model.dart';
import '../services/api_service.dart';

class LoginController{

  final ApiService _apiService = ApiService();
  LoginResponseModel _loginResponseModel = LoginResponseModel();
  User _loggedUser = User();

  var _email = "";
  var _passwd = "";

  factory LoginController(){
    if (_this == null) _this = LoginController._();
    return _this;
  }

  static LoginController _this = LoginController._();
  LoginController._();

  void setEmail(String _mail){_email = _mail;}

  void setPasswd(String _pwd){_passwd = _pwd;}

  logIn(String mail, String pwd, BuildContext ctext) async {
    var data={
      "username":mail,
      "password":pwd,
    };

    Response res = await _apiService.postData(data, 'login');
    var body = json.decode(res.body);
    if (body['message'] == 'Successfull login'){
      _loggedUser = User.frJson(body['user']['email']);
      Navigator.of(ctext).pushReplacementNamed('/home');
    };

    print(res.statusCode);
    print(res.body.toString());
    print(body['user']['email']);;
    _loggedUser.printData();

  // User user = await _apiService.logInApi(mail, pwd);

  }

  void printData(){
    print("Email: " + _email);
    print("Password: " + _passwd);
  }

  bool status(){
    return _loginResponseModel.success;
  }




}