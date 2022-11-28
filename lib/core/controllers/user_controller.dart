
import 'package:electricity_front/core/controllers/login_controller.dart';
import 'package:electricity_front/core/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import '../models/user.dart';

class UserController {


  late User currentUser = User();

  factory UserController(){
    return _this;
  }

  static final UserController _this = UserController._();

  UserController._();


  startSession(String mail, String pwd, BuildContext ctext) async {
    try {
      currentUser = await LoginController().logIn(mail, pwd, ctext);
      ApiService().setToken(currentUser.token);
      //print("El token es:" + currentUser.token);
    } catch (e) {
      Container();
    }
  }



void logOut(BuildContext ctxt) {
  currentUser = User();
  ApiService().setToken("");
  Navigator.of(ctxt).pushReplacementNamed('/login');
}

  Future<bool> deleteUser() async{
    String endpoint = 'users/${currentUser.getUserId()}';
    Response res = await ApiService().deleteData(endpoint);
    //print(res.statusCode);
    //var body = json.decode(res.body);
    if (res.statusCode == 204) {
    return true;
    }
    else {
    throw Exception('Algo falló');
    }

  }


  deletePersonalUbiEveryWhere(int index) async{
    print(currentUser.getUserId());
    Marker location = currentUser.personalUbi.elementAt(index);

    String urlTemp = "users/${currentUser.getUserId()}/locations/${int.parse(location.markerId.value)-3000}";
    Response res = await ApiService().deletePersonalUbi(urlTemp);
    if(res.statusCode == 201) currentUser.deletePersonalUbi(index);

  }
}