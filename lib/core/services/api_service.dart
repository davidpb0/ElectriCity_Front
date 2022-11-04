import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';


class ApiService {
  final String _url = "https://localhost/";

  factory ApiService(){
    if (_this == null) _this = ApiService._();
    return _this;
  }

  static ApiService _this = ApiService._();
  ApiService._();


  postData(data, apiUrl) async {
    var fullUrl=_url+apiUrl;
    print(fullUrl);

    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }
  _setHeaders()=>{
    "Content-type":"application/json",
    "Accept":"application/json",
  };

  getData(apiUrl) async {
    var fullUrl=_url+apiUrl;
    return await http.get(
      Uri.parse(fullUrl),
    );
  }


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

 /* Future<User> logInApi(String mail, String pwd) async{
    final response = await http.get(
      Uri.parse('http://localhost/basic_resources'),
      headers: <String, String>{/*'Content-Type': 'application/json; charset=UTF-8',
        'connection': 'keep-alive',
        'Accept-Encoding' : 'gzip, deflate, br'*/
        //'Content-Type' : 'application/json'
        'x-auth-token' : '123456'
      },
      /*body: jsonEncode(<String, String>{
        "username": mail,
        "password": pwd,
      }),*/
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print(response.body.toString());
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login.');
    }
  }*/
    /*try{
      Response response = await post(
          Uri.parse('http://localhost/login'),
          headers: <String, String>{"Content-Type": "application/json"},
          body: jsonEncode(<String, String>{
            'username': mail,
            'password': pwd
          })
      );
      print(response.statusCode);
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
  }*/
}
