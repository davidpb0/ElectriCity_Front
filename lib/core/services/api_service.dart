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
        "Authorization": "Bearer $token"
      },
    );
  }

  postDataAux(data, apiUrl) async {
    return await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "X-AUTH-TOKEN": "168de41d0b28d734c5f10fe8d7f2d2146d51713e9e05f542435a51ff6a78f60a4df4391bf0c1fd4ae48a6a9f4e93d31926055eb8575615aad811196817d715322fd8401358c78a53f8c1b6bc4e9890ff178e2ed259afe7946da284335314c66270d30dd904543e1b2dd30cd2d4c7c08f909105acb06ef08038af3aba5c"
      },
    );
  }

  putDataAux(data, apiUrl) async {
    return await http.put(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "X-AUTH-TOKEN": "168de41d0b28d734c5f10fe8d7f2d2146d51713e9e05f542435a51ff6a78f60a4df4391bf0c1fd4ae48a6a9f4e93d31926055eb8575615aad811196817d715322fd8401358c78a53f8c1b6bc4e9890ff178e2ed259afe7946da284335314c66270d30dd904543e1b2dd30cd2d4c7c08f909105acb06ef08038af3aba5c"
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
        "Authorization": "Bearer $token"
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
        "Authorization": "Bearer $token"
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
      "Authorization": "Bearer $token",
    });
  }

  getDataAux(apiUrl) async {
    return await http.get(Uri.parse(apiUrl), headers: {
      "X-AUTH-TOKEN": "168de41d0b28d734c5f10fe8d7f2d2146d51713e9e05f542435a51ff6a78f60a4df4391bf0c1fd4ae48a6a9f4e93d31926055eb8575615aad811196817d715322fd8401358c78a53f8c1b6bc4e9890ff178e2ed259afe7946da284335314c66270d30dd904543e1b2dd30cd2d4c7c08f909105acb06ef08038af3aba5c"
    });
  }

  deleteData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.delete(Uri.parse(fullUrl), headers: {
      "Authorization": "Bearer $token",
    });
  }

  deleteDataAux(apiUrl) async {
    return await http.delete(Uri.parse(apiUrl), headers: {
      "X-AUTH-TOKEN": "168de41d0b28d734c5f10fe8d7f2d2146d51713e9e05f542435a51ff6a78f60a4df4391bf0c1fd4ae48a6a9f4e93d31926055eb8575615aad811196817d715322fd8401358c78a53f8c1b6bc4e9890ff178e2ed259afe7946da284335314c66270d30dd904543e1b2dd30cd2d4c7c08f909105acb06ef08038af3aba5c" ,
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
        "Authorization": "Bearer $token"
      },
    );
  }
}
