// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../core/controllers/cosmetics_controller.dart';
import '../../core/controllers/user_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'insidechatview.dart';

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

  showProblemDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("User Error"),
      content:
      Text(message),
      actions: [
        okButton,
      ],
    );

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
    Size screensize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        insetPadding: EdgeInsets.only(top: screensize.height*0.13),
        backgroundColor: Color(CosmeticsController().getCurrentTheme().accentcolor),
        title: Center(
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 0.0)),
              Icon(Icons.person_add,color: Color(CosmeticsController().getCurrentTheme().textcolorlight)),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
              Text(AppLocalizations.of(context).addfriend_title, style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolorlight)),),
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
                  color: Color(CosmeticsController().getCurrentTheme().backgroundcolor),
                  border: Border.all(color: Color(CosmeticsController().getCurrentTheme().textfieldcolor)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextField(
                    controller: emailTextController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Color(CosmeticsController().getCurrentTheme().textcolordark - 0x80000000),),
                      border: InputBorder.none,
                      hintText: "Email",
                      hintStyle: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark - 0x80000000))
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15.0)),
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 1,
                    ),
                  ],
                  color: Color(CosmeticsController().getCurrentTheme().backgroundcolor),
                  border: Border.all(color: Color(CosmeticsController().getCurrentTheme().textfieldcolor)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextField(
                    controller: messageTextController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.send, color: Color(CosmeticsController().getCurrentTheme().textcolordark - 0x80000000),),
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context).addfriend_message,
                      hintStyle: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark - 0x80000000))
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
        actions: [
          SizedBox(
            child: TextButton(
              onPressed: () async {
                if (emailTextController.text.isNotEmpty && messageTextController.text.isNotEmpty) {
                  var email = emailTextController.text;
                  var message = messageTextController.text;
                  if (email == userController.currentUser.getEmail()) {
                    return showProblemDialog(context, "You cannot add yourself");
                  }
                  var response = await userController.getUserInfo(email);
                  if (response != 200) {
                    return showProblemDialog(context, "This user does not exist");
                  }
                  var userAlreadyAdded = userController.chat;
                  for (int i = 0; i < userAlreadyAdded.length; ++i) {
                    if (userAlreadyAdded[i].email == email) {
                      return showProblemDialog(context, "This user has already been added");
                    }
                  }
                  var info = userController.userInfo;
                  var receiverId = info.first;
                  var name = info.last;
                  await userController.sendMessage(message, int.parse(receiverId));
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return InsideChatView(receiverId: receiverId, name: name, email: email);
                  }));
                }
                else if (emailTextController.text.isEmpty) {
                  return showProblemDialog(context, "The email field cannot be empty");
                }
                else if (messageTextController.text.isEmpty) {
                  return showProblemDialog(context, "The message field cannot be empty");
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 5,
                    ),
                  ],
                  color: Color(CosmeticsController().getCurrentTheme().elementcolor),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text(
                      AppLocalizations.of(context).addfriend_send,
                      style: TextStyle(
                      color: Color(CosmeticsController().getCurrentTheme().textcolordark),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                ),
              )
            ),
          ),
        ]
      )
    );
  }
}
