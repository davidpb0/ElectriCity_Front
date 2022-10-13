
class LoginController{

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

  void printData(){
    print("Email: " + _email);
    print("Password: " + _passwd);
  }




}