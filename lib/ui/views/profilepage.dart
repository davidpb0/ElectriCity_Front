import 'package:electricity_front/ui/components/default_header.dart';
import 'package:flutter/material.dart';
import '../../core/models/user.dart';
import '../../core/controllers/user_controller.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserController userCtrl = UserController();
  bool visiblePersonalList = false;
  bool visibleFavouriteList = false;
  String aux = "List";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile",
      home: Scaffold(
        appBar: DefaultHeader(
            size: Size(screensize.width, (screensize.height * 0.15))),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 200),
              Row(
                children: [
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (visiblePersonalList) {
                      visiblePersonalList = false;
                      aux = "List";
                    } else {
                      visiblePersonalList = true;
                      aux = "Hide";
                    }
                  });
                },
                child: Text(aux),
              ),
              Expanded(
                child: Visibility(
                  visible: visiblePersonalList,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: userCtrl.currentUser.personalUbiBD.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            width: 200,
                            color: Colors.white,
                            child: Column(
                              children: [
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),

    );


  }

}