import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:electricity_front/ui/views/conversationpreview.dart';
import 'package:electricity_front/ui/views/newconversationview.dart';
import 'package:flutter/material.dart';
import 'package:wp_search_bar/wp_search_bar.dart';

import '../../core/models/chatusers.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  NewConversationView newConversationView = NewConversationView();
  UserController userController = UserController();
  List<ChatUsers> chatUsers = UserController().getAllUserConversations();
  var buttonFilters = {
    'name': {
      'name': 'name',
      'selected': false,
      'title': 'Name',
      'operation': 'CONTAINS',
      'icon': Icons.supervised_user_circle_rounded,
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.green,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Conversations", style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 2, bottom: 2),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.pink[50],
                        ),
                        child: TextButton(
                          child: Row(
                            children: const <Widget>[
                              Icon(Icons.person_add, color: Colors.pink, size: 20,),
                              SizedBox(width: 6, ),
                              Text("Add", style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),),
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
            Padding(
              padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
              child: WPSearchBar(
                listOfFilters: buttonFilters,
                onSearch: (filter, value, operation) {
                },
                materialDesign:
                  const {
                  'title': {'text': 'Search...'},
                  },
                body: ListView.builder(
                  itemCount: chatUsers.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return ConversationList(
                      id: chatUsers[index].id,
                      name: chatUsers[index].name,
                      email: chatUsers[index].email,
                      isMessageRead: true,
                      //isMessageRead: (index == 0 || index == 3)?true:false,
                    );
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
