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

  var _passwd1 = "";

  var _passwd2 = "";

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

  void setPasswd(String _pwd1) {
      _passwd1 = _pwd1;
  }

  void setPasswdRepeat(String _pwd1) {
    _passwd2 = _pwd1;
  }

  bool validatePassword(){
    if (_passwd1 == _passwd2) {
      print("Password matching");
      return true;
    }
    else {
      print("Password not matching");
      _passwdError = "Password not matching";
      return false;
    }
  }


  signUp(BuildContext ctext) async {
    var data={
      "username":this._username,
      "email":this._email,
      "password":this._passwd1,
    };

    Response res = await _apiService.postData(data, 'signup');
    var body = json.decode(res.body);
    if (res.statusCode == 200){
      _loggedUser = User.fromJson(body);
      Navigator.of(ctext).pushReplacementNamed('/home');
    }
    else{
      _emailError = 'This email is already being used';
    }
    print(res.statusCode);
    print(res.body.toString());
    //print(body['user']['tokens'].first);
    //print(_loggedUser?.username);

  }

  void printData() {
    print("Username: " + _username);
    print("Email: " + _email);
    print("Password: " + _passwd1);
    print("Password repeat: " + _passwd2);
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

