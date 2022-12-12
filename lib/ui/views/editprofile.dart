import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:electricity_front/ui/views/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/default_header.dart';

class EditProfile extends StatefulWidget {


  final Function() notifyParent;

  const EditProfile({
    Key? key,
    required this.notifyParent,
  }) : super (key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final UserController userController = UserController();

  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController oldPasswordTextController = TextEditingController();
  final TextEditingController newPasswordTextController = TextEditingController();
  final TextEditingController repeatPasswordTextController = TextEditingController();

  Future<void> updateUserData(context) async {
    await userController.updateUserProfile(
        usernameTextController.text, emailTextController.text, oldPasswordTextController.text,
        newPasswordTextController.text, repeatPasswordTextController.text
    );
    widget.notifyParent();
    Navigator.pop(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final String userEmail = userController.currentUser.getEmail();
    final String userName = userController.currentUser.getUsername();

    return Scaffold (
      backgroundColor: Colors.grey[350],
      appBar: DefaultHeader(
        size: Size(screenSize.width, (screenSize.height * 0.1))
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 55),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 1,
                  ),
                ],
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: TextField(
                  controller: usernameTextController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.account_circle),
                    border: InputBorder.none,
                    hintText: userName,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 1,
                  ),
                ],
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: TextField(
                  controller: emailTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    border: InputBorder.none,
                    hintText: userEmail,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 1,
                  ),
                ],
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: TextField(
                  controller: oldPasswordTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context).editprofile_oldpassword,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 1,
                  ),
                ],
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: TextField(
                  controller: newPasswordTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context).editprofile_newpassword,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 1,
                  ),
                ],
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: TextField(
                  controller: repeatPasswordTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_reset),
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context).editprofile_repeatnewpassword,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 80,
            width: 500,
            child: TextButton(
              onPressed: () {
                updateUserData(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 5,
                      ),
                    ],
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).editprofile_confirm_changes,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
            width: 500,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 5,
                      ),
                    ],
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                      child: Text(
                        AppLocalizations.of(context).editprofile_cancel_changes,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}