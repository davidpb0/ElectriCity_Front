import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  final String _url = "https://localhost/";
  String token = "";

  setToken(String tkn) {
    token = tkn;
  }

  factory ApiService(){
    return _this;
  }

  static final ApiService _this = ApiService._();
  ApiService._();


  postData(data, apiUrl) async {
    var fullUrl=_url+apiUrl;
    //print(fullUrl);

    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers:{"Content-type":"application/json",
        "Accept":"application/json",
        "X-AUTH-TOKEN": token},
    );
  }

  _setHeaders()=>{
    "Content-type":"application/json",
    "Accept":"application/json",
  };

  postPersonalUbi(data, apiUrl) async {
    print(apiUrl);
    return await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers:{"Content-type":"application/json",
        "Accept":"application/json",
        "X-AUTH-TOKEN": "d8f2ac7af9bc7a48fd595dace56e49bd833ec008e45cfe90d775033c9ad6de4f1d11ce062268137f41f3d39d9528f8fe59110261783bfc8cbc2d7179e52a477cbf6ccc2e22b0e7de230025a517b31c16ea945c2ac3b1049a78599c5489287e12cc761f3919592b2e38d5f53353dd2970934aebcb1bf4e2b7db8b4dc639"},
    );
  }

  deletePersonalUbi(apiUrl) async {
    print(apiUrl);
    return await http.delete(
      Uri.parse(apiUrl),
      headers:{"Content-type":"application/json",
        "Accept":"application/json",
        "X-AUTH-TOKEN": "d8f2ac7af9bc7a48fd595dace56e49bd833ec008e45cfe90d775033c9ad6de4f1d11ce062268137f41f3d39d9528f8fe59110261783bfc8cbc2d7179e52a477cbf6ccc2e22b0e7de230025a517b31c16ea945c2ac3b1049a78599c5489287e12cc761f3919592b2e38d5f53353dd2970934aebcb1bf4e2b7db8b4dc639"},
    );
  }


  login(data, apiUrl) async {
    var fullUrl=_url+apiUrl;
    //print(fullUrl);

    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  getData(apiUrl) async {
    var fullUrl=_url+apiUrl;
    return await http.get(
      Uri.parse(fullUrl),
      headers: {"X-AUTH-TOKEN": token,}
    );
  }

  deleteData(apiUrl) async {
    var fullUrl=_url+apiUrl;
    return await http.delete(
        Uri.parse(fullUrl),
        headers: {"X-AUTH-TOKEN": token,}
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

        //var data = jsonDecode(response.body.toString());
        //print(data);
        //print('Ok');
      }
      else{
        //print('Error');
      }

    }
    catch(e){
      //print(e.toString());

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
