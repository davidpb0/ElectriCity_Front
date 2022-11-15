import 'package:flutter/material.dart';
import '../../core/controllers/userController.dart';

class ProfilePage extends StatelessWidget{
  UserController userCtrl = UserController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Center(
          child: Container(
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    userCtrl.logOut(context);
                  },
                  child: Text(
                    "Log out"
                  ),

                ),
              ),

          ),
        ),
      ),

    );


  }

}