import 'dart:core';
import 'package:flutter/material.dart';

import '../../fonts/test_icons_icons.dart';

class InfoChargeStationWindow extends StatelessWidget {
  InfoChargeStationWindow(
      {super.key,
      required this.slots,
      required this.addres,
      required this.connectionType});

  final int? slots;
  final String addres;
  String ?connectionType;

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
            child: Text(
              addres,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.eCar, size: 20)),
                      const Text("Tipus de connexió: "),
                      Text(connectionType.toString())
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.eCharger, size: 20)),
                      const Text("Espais disponibles: "),
                      Text(slots.toString())
                    ],
                  )
                ],
              )),
        ]),
      ),
    );
  }
}
