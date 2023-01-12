import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:electricity_front/ui/views/conversationpreview.dart';
import 'package:electricity_front/ui/views/newconversationview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  NewConversationView newConversationView = NewConversationView();
  UserController userController = UserController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CosmeticsController cosmeticsController = CosmeticsController();
    return Scaffold(
      backgroundColor: Color(cosmeticsController.getCurrentTheme().backgroundcolor),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Color(CosmeticsController().getCurrentTheme().accentcolor),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(AppLocalizations.of(context).messagesmenu_title, style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold, color: Color(CosmeticsController().getCurrentTheme().textcolorlight)),),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 2, bottom: 2),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(CosmeticsController().getCurrentTheme().elementcoloralt + 0x00404040),
                        ),
                        child: TextButton(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.person_add, color: Color(CosmeticsController().getCurrentTheme().elementcoloralt), size: 20,),
                              const SizedBox(width: 6, ),
                              Text(AppLocalizations.of(context).messagesmenu_add, style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold, color: Color(CosmeticsController().getCurrentTheme().accentcolor)),),
                            ],
                          ),
                          onPressed: () {
                            newConversationView.showAlertDialog(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
            ),
             FutureBuilder<bool>(
              future: UserController().getAllUserConversations(), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: UserController().chat.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return ConversationList(
                        id: UserController().chat[index].id.toString(),
                        name: UserController().chat[index].name,
                        email: UserController().chat[index].email,
                        isMessageRead: true,
                        //isMessageRead: (index == 0 || index == 3)?true:false,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(AppLocalizations.of(context).insidechat_loading, style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark)),),
                        )
                      ]
                    )
                  );
                }
              },
            ),

            /*decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.grey.shade600),
              prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.grey.shade100
                  )
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
