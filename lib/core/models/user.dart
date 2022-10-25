class User{
  String username = "notlogged";
  //String token = "notlogged";

  User();

  User.frJson(String usrnm){
    username = usrnm;
    //oken = tkn;

  }

  /*User.fromJson(Map json)
      : username = json[0],
        token = json[1];
*/
Map toJson(){
  return{'email': username, /*'token': token*/};
}

  printData(){
    print(username);
  }
}
