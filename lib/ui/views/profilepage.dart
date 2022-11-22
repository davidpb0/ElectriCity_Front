import 'package:flutter/material.dart';
import '../../core/models/user.dart';
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
        body: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  userCtrl.logOut(context);
              },
                child: const Text("Log out"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Delete Account"),
                      content: const Text("Are you sure you want to delete your account?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            userCtrl.deleteUser();
                            userCtrl.logOut(context);
                          },
                          child: Container(
                            color: Colors.green,
                            padding: const EdgeInsets.all(14),
                            child: const Text("okay"),
                          ),
                        ),
                      ],
                    ),
                  );

                },
                child: const Text('Delete account'),
          ),
        ]
        ),
      ),

    );


  }

}