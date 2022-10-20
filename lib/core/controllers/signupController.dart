import 'dart:convert';

import 'package:electricity_front/core/services/api_service.dart';
import 'package:http/http.dart';

class SignupController {

  final ApiService _apiService = ApiService();

  var _username = "";
  var _email = "";
  var _passwd = "";

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

  }

  void signUp(String mail, String pwd) async{
    _apiService.signUpApi(mail, pwd);
  }

  void printData() {
    print("Username: " + _username);
    print("Email: " + _email);
    print("Password: " + _passwd);
  }
}

