
import '../models/login_model.dart';
import '../services/api_service.dart';

class LoginController{

  final ApiService _apiService = ApiService();
  LoginResponseModel _loginResponseModel = LoginResponseModel();

  var _email = "";
  var _passwd = "";

  factory LoginController(){
    if (_this == null) _this = LoginController._();
    return _this;
  }

  static LoginController _this = LoginController._();
  LoginController._();

  void setEmail(String _mail){_email = _mail;}

  void setPasswd(String _pwd){_passwd = _pwd;}

  Future<bool> logIn(String mail, String pwd) async {
   int code = await _apiService.logInApi(mail, pwd);
   _loginResponseModel = new LoginResponseModel();
   print("Entro en loginController y el codigo es: ");
   print(code);
   _loginResponseModel.setStatus(code);
   return _loginResponseModel.success;
  }

  void printData(){
    print("Email: " + _email);
    print("Password: " + _passwd);
  }

  bool status(){
    return _loginResponseModel.success;
  }




}