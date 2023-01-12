import 'package:flutter/material.dart';

import '../../core/controllers/cosmetics_controller.dart';
import 'insidechatview.dart';

class ConversationList extends StatefulWidget {
  final String id;
  final String name;
  final String email;
  final bool isMessageRead;
  const ConversationList({super.key, required this.id, required this.name, required this.email, required this.isMessageRead});

  @override
  State<ConversationList> createState() => ConversationListState();
}

class ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return InsideChatView(receiverId: widget.id, name: widget.name, email: widget.email);
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                 /* CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),*/
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16, color: Color(CosmeticsController().getCurrentTheme().textcolordark)),),
                          const SizedBox(height: 6,),
                          Text(widget.email,style: TextStyle(fontSize: 13,color: Color(CosmeticsController().getCurrentTheme().textcolordark - 0x60000000), fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
