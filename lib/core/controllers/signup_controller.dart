import 'package:electricity_front/core/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../../core/controllers/user_controller.dart';

class SignupController {
  final ApiService _apiService = ApiService();
  UserController userCtrl = UserController();

  var _username = "";
  String? _usernameError;

  var _email = "";
  String? _emailError;

  var _passwd1 = "";

  var _passwd2 = "";

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

  void setPasswd(String pwd1) {
    _passwd1 = pwd1;
  }

  void setPasswdRepeat(String pwd1) {
    _passwd2 = pwd1;
  }

  bool validatePassword() {
    if (_passwd1 == _passwd2) {
      //print("Password matching");
      return true;
    } else {
      //print("Password not matching");
      _passwdError = "Password not matching";
      return false;
    }
  }

  signUp(String email, String pwd, BuildContext ctext) async {
    var data = {
      "username": _username,
      "password": _passwd1,
      "email": _email,
      "fullname": _username,
    };


    //printData();

    Response res = await _apiService.postData(data, 'register');
    if (res.statusCode == 201) {
      userCtrl.startSession(email, pwd, ctext);
    } else {
      _emailError = 'This email is already being used';
      //print(res.statusCode);
    }
    //print(res.statusCode);
    //print(res.body.toString());
    //print(body['user']['tokens'].first);
    //print(_loggedUser?.username);
  }

  /*void printData() {
    print("Username: " + _username);
    print("Email: " + _email);
    print("Password: " + _passwd1);
    print("Password repeat: " + _passwd2);
  }*/

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
