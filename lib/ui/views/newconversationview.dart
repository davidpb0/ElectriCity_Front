import 'package:flutter/material.dart';

import '../../core/controllers/user_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewConversationView extends StatelessWidget {
  NewConversationView({
    Key? key,
  }) : super(key: key);

  final UserController userController = UserController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController messageTextController = TextEditingController();

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    Widget alert = build(context);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    emailTextController.clear();
    messageTextController.clear();
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      contentPadding: const EdgeInsets.only(top: 10.0),
      backgroundColor: Colors.green[400],
      title: Center(
        child: Row(
          children: const [
            Padding(padding: EdgeInsets.symmetric(horizontal: 0.0)),
            Icon(Icons.person_add),
            Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
            Text("Add new user"),
          ]
        )
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Container(
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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: InputBorder.none,
                    hintText: "Email",
                  ),
                ),
              ),
            ),
            Container(
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
                  controller: messageTextController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.send),
                    border: InputBorder.none,
                    hintText: "New message",
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
      actions: [
        SizedBox(
          height: 60,
          width: 130,
          child: TextButton(
            onPressed: () {
              if (emailTextController.text.isNotEmpty && messageTextController.text.isNotEmpty) {
                Navigator.of(context).pop(context);
              }
              else {

              }
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
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text(
                      AppLocalizations.of(context).chatview_adduser,
                      style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                ),
              ),
            )
          ),
        ),
      ]
    );
  }
}
