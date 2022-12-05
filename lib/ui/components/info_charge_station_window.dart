import 'dart:core';
import 'package:flutter/material.dart';

import '../../fonts/test_icons_icons.dart';

// ignore: must_be_immutable
class InfoChargeStationWindow extends StatefulWidget {
  InfoChargeStationWindow({super.key,
    required this.slots,
    required this.addres,
    required this.connectionType});

  final int? slots;
  final String addres;
  String? connectionType;

  @override
  State<InfoChargeStationWindow> createState() =>
      _InfoChargeStationWindow();
}
class _InfoChargeStationWindow extends State<InfoChargeStationWindow>{
  Icon like = const Icon(Icons.favorite_border_outlined);
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 1,
            )
          ],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white),
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12)),
              color: Colors.green),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.addres,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if(liked) {
                          liked = false;
                          like = const Icon(Icons.favorite_border_outlined);
                        }
                        else {
                          liked = true;
                          like = const Icon(Icons.favorite);
                        }
                      });
                    },
                    icon: like
                )
              ],
            ),
          ),
          Container(
              color: Colors.white,
              child: Column(
                //padding
                children: [
                  Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.eCar, size: 20)
                      ),
                      const Text("Tipus de connexió: "),
                      Text(widget.connectionType.toString())
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.eCharger, size: 20)
                      ),
                      const Text("Espais disponibles: "),
                      Text(widget.slots.toString())
                    ],
                  )
                ],
              )
          ),
        ]),
      ),
    );
  }
}
