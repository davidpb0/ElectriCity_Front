// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:electricity_front/core/models/user.dart';
import 'package:flutter/material.dart';
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
      "email": mail,
      "password": pwd,
    };

    Response res = await _apiService.login(data, '/login');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      ApiService().setToken(body['token']);
      Response res2 = await _apiService.getData('/profile');
      var body2 = json.decode(res2.body);
      if (res2.statusCode == 201) {
        Navigator.of(ctext).pushReplacementNamed('/home');
        User usr = User.fromJson(body2);
        print(body['token']);

        usr.setToke(body['token']);
        return usr;
      }
      else {
        showAlertDialog(ctext);
      }
    } else {
      showAlertDialog(ctext);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pushReplacementNamed('/login');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("User Error"),
      content:
          const Text("The email or the password introduced were incorrect"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
