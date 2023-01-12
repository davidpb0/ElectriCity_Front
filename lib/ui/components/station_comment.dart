import 'dart:math';
import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/station_controller.dart';
import '../../core/models/comment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StationComment extends StatefulWidget {
  final Comment info;
  final Function() notifyParent;

  const StationComment({
    Key? key,
    required this.info,
    required this.notifyParent,
  }) : super(key: key);

  @override
  State<StationComment> createState() => _StationCommentState();
}

class _StationCommentState extends State<StationComment> {
  final TextEditingController commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isFromActualUSer();
  }

  Widget delete = Container();
  Widget modify = Container();
  Widget text = Container();

  isFromActualUSer() {
    if (widget.info.bicing != null) {
      if (widget.info.creator == UserController().currentUser.getUsername()) {
        text = Text(widget.info.text, style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark)),);
        delete = IconButton(
            onPressed: () async {
              bool b = false;
              b = await StationController().deleteBicingComment(widget.info);
              if (b) widget.notifyParent();
            },
            icon: Icon(Icons.delete, color: Color(CosmeticsController().getCurrentTheme().textcolordark),));
        modify = IconButton(
            onPressed: () async {
              /*bool b = false;
              b = await StationController().deleteBicingComment(widget.info);
              if (b) widget.notifyParent();*/
              commentTextController.text = widget.info.text;
              setState(() {
                text = Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: commentTextController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)
                              .expandedStation_editComment,
                          hintStyle: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark))
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          bool b = false;
                          b = await StationController().editBicingComment(
                              widget.info, commentTextController.text);
                          if (b) widget.notifyParent();
                        },
                        icon: Icon(Icons.send, color: Color(CosmeticsController().getCurrentTheme().textcolordark),))
                  ],
                );
              });
            },
            icon: const Icon(Icons.edit));
      } else {
        text = Text(widget.info.text, style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark)),);
      }
    } else {
      if (widget.info.creator == UserController().currentUser.getUsername()) {
        text = Text(widget.info.text, style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark)),);
        delete = IconButton(
            onPressed: () async {
              bool b = false;
              b = await StationController().deleteChargerComment(widget.info);
              if (b) widget.notifyParent();
            },
            icon: const Icon(Icons.delete));
        modify = IconButton(
            onPressed: () async {
              /*bool b = false;
              b = await StationController().deleteBicingComment(widget.info);
              if (b) widget.notifyParent();*/
              commentTextController.text = widget.info.text;
              setState(() {
                text = Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: commentTextController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)
                              .expandedStation_editComment,
                          hintStyle: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark))
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          bool b = false;
                          b = await StationController().editChargerComment(
                              widget.info, commentTextController.text);
                          if (b) widget.notifyParent();
                        },
                        icon: Icon(Icons.send, color: Color(CosmeticsController().getCurrentTheme().textcolordark),))
                  ],
                );
              });
            },
            icon: Icon(Icons.edit, color: Color(CosmeticsController().getCurrentTheme().textcolordark),));
      } else {
        text = Text(widget.info.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CosmeticsController cosmeticsController = CosmeticsController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(cosmeticsController.getCurrentTheme().elementcolor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 1,
            ),
          ],
        ),
        child: Container(
            padding: const EdgeInsets.all(2),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Flex(direction: Axis.horizontal, children: [
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        decoration: ShapeDecoration(
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.zero,
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.zero,
                                topRight: Radius.circular(8)),
                          ),
                        ),
                        child: Flex(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          direction: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 40,
                            ),
                            Text(
                              widget.info.creator,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            modify,
                            delete,
                          ],
                        ),
                      )),
                    ]),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 24),
                              decoration: ShapeDecoration(
                                  color: Color(cosmeticsController.getCurrentTheme().textfieldcolor),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        topLeft: Radius.zero,
                                        bottomRight: Radius.circular(8),
                                        topRight: Radius.zero),
                                  )),
                              child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: text,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      widget.info.timestamp,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 10,
                                          color: Color(cosmeticsController.getCurrentTheme().textcolordark)),
                                    ),
                                  ]))),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(cosmeticsController.getCurrentTheme().elementcolor),
                  ),
                  child: Icon(
                    Icons.account_circle,
                    size: 24,
                    color: Color(CosmeticsController().getCurrentTheme().accentcoloralt),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
