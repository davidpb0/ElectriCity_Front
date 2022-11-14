class User{
  String username = "";
  String token = "";


  User();

  User.fromJson(dynamic json){
      username = json['user']['email'];
      token = json['user']['tokens'].first;
  }

Map toJson(){
  return{'email': username, 'token': token};
}

getUserTkn(){
    return token;
}

  printData(){
    print(username);
  }
}
