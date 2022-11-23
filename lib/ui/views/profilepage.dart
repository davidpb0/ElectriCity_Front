import 'package:electricity_front/ui/components/default_header.dart';
import 'package:flutter/material.dart';
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
    Size screensize = MediaQuery.of(context).size;
    return MaterialApp(
      title: "Profile",
      home: Scaffold(
        appBar: DefaultHeader(
            size: Size(screensize.width, (screensize.height * 0.15))),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 200),
              ElevatedButton(
                onPressed: () {
                  userCtrl.logOut(context);
                },
                child: const Text("Log out"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if(visiblePersonalList) {
                      visiblePersonalList = false;
                      aux = "List";
                    }
                    else{
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
                          child: Container(height: 100, width: 200, color: Colors.black,),
                        );
                      }
              ),
            ),
          ),

            ],
          ),
        ),
      ),
    );
  }
  
}
