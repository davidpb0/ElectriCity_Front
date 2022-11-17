import 'dart:convert';

import 'package:electricity_front/core/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../models/user.dart';

class SignupController {
  final ApiService _apiService = ApiService();
  User? _loggedUser;

  var _username = "";
  String? _usernameError;

  var _email = "";
  String? _emailError;

  var _passwd = "";
  String? _passwdError;

  factory SignupController() {
    return _this;
  }

  static final SignupController _this = SignupController._();

  SignupController._();

  void setUsername(String un) {
    _username = un;
  }

  void setEmail(String mail) {
    _email = mail;
  }

  void setPasswd(String pwd1, String pwd2) {
    if (pwd1 == pwd2) {
      //print("Password matching");
      _passwd = pwd1;
      return;
    }
    //print("Password not matching");
    _passwdError = "Password not matching";
  }

  signUp(BuildContext ctext) async {
    var data = {
      "username": _username,
      "email": _email,
      "password": _passwd,
    };
    _loggedUser;
    Response res = await _apiService.postData(data, 'signup');
    var body = json.decode(res.body);
    if (body['message'] == 'Successfull login') {
      _loggedUser = User.fromJson(body);
    }
    //print(res.statusCode);
    //print(res.body.toString());
    //print(body['user']['tokens'].first);
    //print(_loggedUser?.username);
  }

  String? usernameError() {
    return _usernameError;
  }

  String? emailError() {
    return _emailError;
  }

  String? pwdError() {
    return _passwdError;
  }
}
