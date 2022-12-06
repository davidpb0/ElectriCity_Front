import 'dart:io';
import 'package:electricity_front/core/controllers/login_controller.dart';
import 'package:electricity_front/core/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import '../models/station_list.dart';
import '../models/user.dart';

class UserController {
  late User currentUser = User();
  late BitmapDescriptor personalMarker;

  factory UserController() {
    return _this;
  }

  static final UserController _this = UserController._();

  UserController._();

  startSession(String mail, String pwd, BuildContext ctext) async {
    try {
      setCustomMarker();
      currentUser = await LoginController().logIn(mail, pwd, ctext);
      ApiService().setToken(currentUser.getUserTkn());
    }
    catch (e) {
      Exception("Error en iniciar la sesion");
    }
  }

  void setCustomMarker() async {
    if (Platform.isIOS) {
      personalMarker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(0.1, 0.1), devicePixelRatio: 0.1),
          'assets/images/homepin_ios.png');
    }
    else {
      personalMarker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(0.1, 0.1), devicePixelRatio: 0.1),
          'assets/images/homepin.png');
    }
  }

  void logOut(BuildContext ctxt) {
    currentUser = User();
    ApiService().setToken("");
    Navigator.of(ctxt).pushReplacementNamed('/login');
  }

  Future<bool> deleteUser() async {
    String endpoint = 'users/${currentUser.getUserId()}';
    Response res = await ApiService().deleteData(endpoint);
    if (res.statusCode == 204) {
      return true;
    }
    else {
      throw Exception('Error en función deleteUser');
    }
  }

  deletePersonalUbiEveryWhere(int index) async {
    Marker location = currentUser.getPersonalUbi().elementAt(index);

    String urlTemp = "users/${currentUser.getUserId()}/locations/${int.parse(location.markerId.value) - 3000}";
    Response res = await ApiService().deletePersonalUbi(urlTemp);
    if (res.statusCode == 201) {
      currentUser.deletePersonalUbi(index);
    }
  }

  addFavBicingBD(int index, Station bicing) async {
    String urlTemp = "https://localhost/users/${currentUser.getUserId()}/bicingStation/$index";
    var data = {};
    //Cambiar a postData cuando deploy de backEnd
    Response res = await ApiService().postDataAux(data, urlTemp);
    print(res.statusCode.toString());
    if (res.statusCode == 201) {
      print("GG wp");
      currentUser.addFavBicing(bicing);
    }

  }

  deleteFavBicingBD(int index, Station bicing) async {
    String urlTemp = "https://localhost/users/${currentUser.getUserId()}/bicingStation/$index";

    //Cambiar a delteData cuando deploy de backEnd
    Response res = await ApiService().deleteDataAux(urlTemp);
    print(res.statusCode.toString());
    if (res.statusCode == 201) {
      print("GG wp");
      currentUser.deleteFavBicing(bicing);
    }

  }
}
