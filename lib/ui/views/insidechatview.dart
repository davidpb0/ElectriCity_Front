import 'package:flutter/material.dart';

import '../../core/controllers/user_controller.dart';

class InsideChatView extends StatefulWidget{
  final String receiverId;
  final String name;
  final String email;
  const InsideChatView({super.key, required this.receiverId, required this.name, required this.email});

  @override
  State<InsideChatView> createState() => _InsideChatViewState();
}

class _InsideChatViewState extends State<InsideChatView> {
  UserController userCtrl = UserController();
  TextEditingController messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back,color: Colors.black,),
                ),
                const SizedBox(width: 2,),
                /*const CircleAvatar(
                  backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                  maxRadius: 20,
                ),*/
                const SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.name, style: const TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      const SizedBox(height: 6,),
                      Text(widget.email, style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                    ],
                  ),
                ),
                const Icon(Icons.settings,color: Colors.black54,),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: FutureBuilder<bool>(
            future: UserController().getConversationWithOneUser(int.parse(widget.receiverId)),// a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: UserController().messages.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (UserController().messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (UserController().messages[index].messageType == "receiver"
                                ? Colors.grey.shade200
                                : Colors.blue[200]),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(UserController().messages[index].messageContent,
                            style: const TextStyle(fontSize: 15),),
                        ),
                      ),
                    );
                  },
                );
              }
              else if (snapshot.hasError) {
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
                        children: const [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Loading...'),
                          )
                        ]
                    )
                );
              }
            }
              )
          ),
    Container(
              padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      decoration: const InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: () async{
                      if (messageTextController.text.isNotEmpty) {
                        await userCtrl.sendMessage(messageTextController.text,
                            int.parse(widget.receiverId));
                        messageTextController.clear();
                        refresh();
                      }
                    },
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(Icons.send,color: Colors.white,size: 18,),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
