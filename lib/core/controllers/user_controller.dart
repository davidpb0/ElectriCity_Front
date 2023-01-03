import 'dart:convert';
import 'dart:io';
import 'package:electricity_front/core/controllers/login_controller.dart';
import 'package:electricity_front/core/controllers/station_controller.dart';
import 'package:electricity_front/core/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import '../models/chatusers.dart';
import '../models/chatmessagemodel.dart';
import '../models/user.dart';

class UserController {
  late User currentUser = User();
  late BitmapDescriptor personalMarker;
  late List<ChatUsers> chat;
  late List<ChatMessage> messages;

  factory UserController() {
    return _this;
  }

  static final UserController _this = UserController._();

  UserController._();

  startSession(String mail, String pwd, BuildContext ctext) async {
    try {
      setCustomMarker();
      currentUser = await LoginController().logIn(mail, pwd, ctext);
      StationController().initStations();
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
    String endpoint = '/users/${currentUser.getUserId()}';
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
    String urlTemp = "/users/${currentUser.getUserId()}/locations/${int.parse(location.markerId.value) - 3000}";
    Response res = await ApiService().deletePersonalUbi(urlTemp);
    if (res.statusCode == 201) {
      currentUser.deletePersonalUbi(index);
    }
  }

  addFavBicingBD(int index) async {
    String urlTemp = "/users/${currentUser.getUserId()}/bicingStation/$index";
    var data = {};
    Response res = await ApiService().postData(data, urlTemp);
    if (res.statusCode == 201) {
      currentUser.addFavouriteBicingStationIndex(index.toString());
    }
  }

  deleteFavBicingBD(String stationId) async {
    String urlTemp = "/users/${currentUser.getUserId()}/bicingStation/$stationId";
    Response res = await ApiService().deleteData(urlTemp);
    if (res.statusCode == 201) {
      currentUser.deleteFavouriteBicingStationIndex(stationId);
    }
  }

  addFavChargerBD(int stationId) async {
    String urlTemp = "/users/${currentUser.getUserId()}/rechargeStation/$stationId";
    var data = {};
    Response res = await ApiService().postData(data, urlTemp);
    if (res.statusCode == 201) {
      currentUser.addFavouriteRechargeStationIndex(stationId.toString());
    }
  }

  deleteFavChargerBD(String stationId) async {
    String urlTemp = "/users/${currentUser.getUserId()}/rechargeStation/$stationId";
    Response res = await ApiService().deleteData(urlTemp);
    if (res.statusCode == 201) {
      currentUser.deleteFavouriteRechargeStationIndex(stationId);
    }
  }

  updateUserProfile(String username, String email, String oldPassword, String newPassword, String repeatPassword) async {
    var data = {};
    if (username.isNotEmpty && email.isNotEmpty) {
      data = {
        "username": username,
        "email": email
      };
    }
    else if (username.isNotEmpty) {
      data = {
        "username": username
      };
    }
    else if (email.isNotEmpty) {
      data = {
        "email": email
      };
    }

    //TODO: verify user old Password
    /*if (oldPassword == currentUser.getPassword() && newPassword != "" && newPassword == repeatPassword) {

    }*/

    if (data.isNotEmpty) {
      String urlTemp = "/users/${currentUser.getUserId()}";
      Response res = await ApiService().updateUserInfo(data, urlTemp);
      if (res.statusCode == 200) {
        if (username.isNotEmpty) currentUser.setUsername(username);
        if (email.isNotEmpty) currentUser.setEmail(email);
      }
      else {
        throw Exception("Error while updating user profile");
      }
    }
  }

  sendMessage(String text, int idReceiver) async {
    String urlTemp = "/users/${currentUser.getUserId()}/messages";
    String time = DateTime.now().toString();
    time = time.split(".")[0];
    if (time[10] == 'T') {
      time[10] == ' ';
    }

    var data = {
      "text": text,
      "idReceiver": idReceiver,
      "data": time
    };
    Response res = await ApiService().sendNewMessage(urlTemp, data);
    if (res.statusCode != 201) {
      throw Exception("Error while sending a message");
    }
  }

  Future<bool> getConversationWithOneUser(int idUserWithConversation) async {
    String urlTemp = "/users/${currentUser.getUserId()}/messages/users/$idUserWithConversation";
    Response res = await ApiService().getConversationBetweenUsers(urlTemp);
    var body = json.decode(res.body);
    if (res.statusCode == 201) {
      messages = getMessages(body);
      return true;
    }
    else {
      throw Exception("Error while getting a conversation with a user");
    }
  }

  Future<bool> getAllUserConversations() async {
    String urlTemp = "/users/${currentUser.getUserId()}/conversations";
    Response res = await ApiService().getUserConversations(urlTemp);
    var body = json.decode(res.body);
    if (res.statusCode == 201) {
      chat = getInfoUsers(body);
      return true;
    }
    else {
      throw Exception("Error while getting user conversations");
    }
  }

  getMessages(dynamic json) {
    List<ChatMessage> chatMessage = <ChatMessage>[];
    for (int i = 0; i < json['enviats'].length; ++i) {
      chatMessage.add(
          ChatMessage(id: json['enviats'][i]['id'], messageContent: json['enviats'][i]['text'].toString(), messageType: "sender")
      );
    }
    for (int i = 0; i < json['rebuts'].length; ++i) {
      chatMessage.add(
          ChatMessage(id: json['rebuts'][i]['id'], messageContent: json['rebuts'][i]['text'].toString(), messageType: "receiver")
      );
    }
    return chatMessage;
  }

  List<ChatUsers> getInfoUsers(dynamic json) {
    List<ChatUsers> chatUsers = <ChatUsers>[];
    for (int i = 0; i < json['userWithConversation'].length; ++i) {
      chatUsers.add(
        ChatUsers(id: json['userWithConversation'][i]['id'], name: json['userWithConversation'][i]['username'].toString(), email: json['userWithConversation'][i]['email'].toString())
      );
    }
    return chatUsers;
  }

}
