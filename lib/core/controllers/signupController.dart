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

  factory SignupController(){
    if (_this == null) _this = SignupController._();
    return _this;
  }

  static SignupController _this = SignupController._();
  SignupController._();

  void setUsername(String _un) {
    _username = _un;
  }

  void setEmail(String _mail) {
    _email = _mail;
  }

  void setPasswd(String _pwd1, String _pwd2) {
    if (_pwd1 == _pwd2) {
      print("Password matching");
      _passwd = _pwd1;
      return;
    }
    print("Password not matching");
    _passwdError = "Password not matching";

  }


  signUp(BuildContext ctext) async {
    var data={
      "username":this._username,
      "email":this._email,
      "password":this._passwd,
    };

    Response res = await _apiService.postData(data, 'signup');
    var body = json.decode(res.body);
    if (body['message'] == 'Successfull login'){
      _loggedUser = User.fromJson(body);
      Navigator.of(ctext).pushReplacementNamed('/home');
    };
    print(res.statusCode);
    print(res.body.toString());
    //print(body['user']['tokens'].first);
    //print(_loggedUser?.username);

  }

  void printData() {
    print("Username: " + _username);
    print("Email: " + _email);
    print("Password: " + _passwd);
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

