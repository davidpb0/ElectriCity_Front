import 'package:flutter/material.dart';
import '../../core/controllers/user_controller.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget{
  UserController userCtrl = UserController();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
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