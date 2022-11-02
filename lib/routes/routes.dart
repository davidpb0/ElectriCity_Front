import 'package:electricity_front/ui/views/loginpage.dart';
import 'package:electricity_front/ui/views/signuppage.dart';
import 'package:electricity_front/ui/views/listpage.dart';
import 'package:flutter/material.dart';
import '../ui/components/navigation_bar.dart';



Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => LoginPage(),
    '/signup': (BuildContext context) => SignupPage(),
    '/list': (BuildContext context) => ListPage(),
    '/home': (BuildContext context) => BottomBar(),
  };

}