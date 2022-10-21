

import 'dart:convert';


class LoginResponseModel {
  bool success = false;
  late int _statusCode;

  void setStatus(int code){
    _statusCode = code;
    success = (_statusCode == 200);
    print("Se ejecuta setStatus i succes es: ");
    print(success);
  }


}