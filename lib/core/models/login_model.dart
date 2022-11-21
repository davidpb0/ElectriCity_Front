class LoginResponseModel {
  bool success = false;
  late int _statusCode;

  void setStatus(int code) {
    _statusCode = code;
    success = (_statusCode == 200);

  }
}
