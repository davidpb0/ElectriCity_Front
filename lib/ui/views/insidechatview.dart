import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/controllers/cosmetics_controller.dart';
import '../../core/controllers/user_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InsideChatView extends StatefulWidget {
  final String receiverId;
  final String name;
  final String email;

  const InsideChatView(
      {super.key, required this.receiverId, required this.name, required this.email});

  @override
  State<InsideChatView> createState() => _InsideChatViewState();
}

class _InsideChatViewState extends State<InsideChatView> {
  UserController userCtrl = UserController();
  TextEditingController messageTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => refresh());
  }

  refresh() {
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(CosmeticsController().getCurrentTheme().backgroundcolor),
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Color(CosmeticsController().getCurrentTheme().textcolordark)),
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
                      Text(widget.name, style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600, color: Color(CosmeticsController().getCurrentTheme().textcolordark)),),
                      const SizedBox(height: 6,),
                      Text(widget.email, style: TextStyle(
                          color: Color(CosmeticsController().getCurrentTheme().elementcoloralt), fontSize: 13),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: FutureBuilder<bool>(
                  future: UserController().getConversationWithOneUser(
                      int.parse(widget.receiverId)),
                  // a previously-obtained Future<String> or null
                  builder: (BuildContext context,
                      AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                          () => _scrollController.jumpTo(
                          _scrollController.position.maxScrollExtent);
                      return ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        itemCount: UserController().messages.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment: (UserController().messages[index]
                                  .messageType == "receiver"
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (UserController().messages[index]
                                      .messageType == "receiver"
                                      ? Color(CosmeticsController().getCurrentTheme().elementcolor - 0x80000000)
                                      : Color(CosmeticsController().getCurrentTheme().accentcoloralt - 0x80000000)),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Text(UserController().messages[index]
                                    .messageContent,
                                  style: TextStyle(fontSize: 15, color: Color(CosmeticsController().getCurrentTheme().textcolordark)),),
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
                              children: [
                                const SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Text(AppLocalizations.of(context).insidechat_loading, style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().elementcolor)),),
                                )
                              ]
                          )
                      );
                    }
                  }
              )
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Color(CosmeticsController().getCurrentTheme().textfieldcolor),
            child: Row(
              children: <Widget>[
                const SizedBox(width: 15,),
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark)),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).insidechat_write,
                      hintStyle: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark - 0x80000000)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 15,),
                FloatingActionButton(
                  onPressed: () async {
                    if (messageTextController.text.isNotEmpty) {
                      await userCtrl.sendMessage(messageTextController.text,
                          int.parse(widget.receiverId));
                      messageTextController.clear();
                      refresh();
                    }
                  },
                  backgroundColor: Color(CosmeticsController().getCurrentTheme().elementcoloralt),
                  elevation: 0,
                  child: Icon(Icons.send, color: Color(CosmeticsController().getCurrentTheme().textcolorlight), size: 18,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
