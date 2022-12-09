
import 'dart:math';

import 'package:flutter/material.dart';
import '../../core/models/comment.dart';

class StationComment extends StatefulWidget {
  final Comment info;

  const StationComment({
    Key? key, required this.info,
  }) : super(key: key);

  @override
  State<StationComment> createState() => _StationCommentState();
}

class _StationCommentState extends State<StationComment> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
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
                  Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(child:
                          Container(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                            decoration: ShapeDecoration(
                              color: Colors.primaries[Random().nextInt(Colors.primaries.length)] ,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.zero,
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.zero,
                                    topRight: Radius.circular(8)),
                              ),
                            ),
                            child: Row(
                              children:  [
                                const SizedBox(width: 40,),
                                Text(
                                  widget.info.creator.username,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],),
                          )
                        ),
                      ]
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(child: Container(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                          decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    topLeft: Radius.zero,
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.zero),
                              )),
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text(
                                              widget.info.text
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                        widget.info.timestamp
                                    ),
                                  ])

                          )
                      ),),

                    ],
                  ),


                ],
              ),
              Container(
                width:52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: const Icon(Icons.account_circle, size: 24, color: Colors.pink,),
              )
            ],
          )
        ),
      ),
    );
  }
}
