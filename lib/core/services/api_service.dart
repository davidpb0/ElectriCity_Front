import 'dart:convert';

import 'package:electricity_front/core/models/login_model.dart';
import 'package:http/http.dart';


class ApiService {

  factory ApiService(){
    if (_this == null) _this = ApiService._();
    return _this;
  }

  static ApiService _this = ApiService._();
  ApiService._();



  void signUpApi(String mail, String pwd) async{
    try{
      Response response = await post(
          Uri.parse('https://reqres.in/api/register'),
          body: {
            'email' : mail,
            'password' : pwd
          }
      );
      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());
        print(data);
        print('Ok');
      }
      else{
        print('Error');
      }

    }
    catch(e){
      print(e.toString());

    }
  }

  Future<int> logInApi(String mail, String pwd) async{
    try{
      Response response = await post(
          Uri.parse('https://reqres.in/api/login'),
          body: {
            'email' : mail,
            'password' : pwd
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print('Ok');
        return response.statusCode;

      }
      else{
        throw ('Error con el usuario');
      }

    }
    catch(e){
      print(e.toString());

    }
    return 0;
  }
}
