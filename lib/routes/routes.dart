import 'package:electricity_front/ui/views/loginpage.dart';
import 'package:electricity_front/ui/views/profilepage.dart';
import 'package:electricity_front/ui/views/signuppage.dart';
import 'package:electricity_front/ui/views/listpage.dart';
import 'package:flutter/material.dart';
import '../ui/components/info_personal_ubi_form.dart';
import '../ui/components/navigation_bar.dart';



Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => const LoginPage(),
    '/signup': (BuildContext context) => const SignupPage(),
    '/list': (BuildContext context) => const ListPage(),
    '/home': (BuildContext context) => const BottomBar(),
    '/profile': (BuildContext context) => ProfilePage(),
    '/form_ubi':(BuildContext context) => InfoPersonalUbiForm(),
  };

}