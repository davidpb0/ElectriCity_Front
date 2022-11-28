import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String _url = "https://google.electricityupcfib.es/";
  String token = "";

  setToken(String tkn) {
    token = tkn;
  }

  factory ApiService() {
    return _this;
  }

  static final ApiService _this = ApiService._();

  ApiService._();

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "X-AUTH-TOKEN": token
      },
    );
  }

  _setHeaders() => {
    "Content-type": "application/json",
    "Accept": "application/json",
  };

  postPersonalUbi(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "X-AUTH-TOKEN": token
      },
    );
  }

  deletePersonalUbi(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.delete(
      Uri.parse(fullUrl),
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "X-AUTH-TOKEN": token
      },
    );
  }

  login(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(Uri.parse(fullUrl), headers: {
      "X-AUTH-TOKEN": token,
    });
  }

  deleteData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.delete(Uri.parse(fullUrl), headers: {
      "X-AUTH-TOKEN": token,
    });
  }

  routePainting(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "X-AUTH-TOKEN": token
      },
    );
  }
}
