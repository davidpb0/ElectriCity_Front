import 'package:electricity_front/ui/components/default_header.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/user_controller.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget{
  UserController userCtrl = UserController();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return MaterialApp(
      title: "Profile",
      home: Scaffold(
        appBar: DefaultHeader(size: Size(screensize.width, (screensize.height * 0.15))),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              userCtrl.logOut(context);
            },
            child: const Text(
              "Log out"
            ),

          ),
        ),
      ),

    );


  }

}