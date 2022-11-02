
import 'package:flutter/material.dart';

import '../../core/controllers/signupController.dart';
import '../components/header_login_component.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
        ),
        body: Text('Home')
    );
  }
}


