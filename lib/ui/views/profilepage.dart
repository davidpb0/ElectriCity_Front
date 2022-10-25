import 'package:flutter/material.dart';

import '../../core/controllers/loginController.dart';

class ProfilePage extends StatelessWidget{
  LoginController loginCtrl = LoginController();

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
                    loginCtrl.logOut(context);
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