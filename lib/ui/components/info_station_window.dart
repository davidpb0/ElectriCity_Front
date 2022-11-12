import 'dart:core';
import 'package:flutter/material.dart';

import '../../fonts/test_icons_icons.dart';

class InfoStationWindow extends StatelessWidget{
  const InfoStationWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Text(
              "GRAN VIA CORTS CATALANES, 760",
              textAlign: TextAlign.center,
              style: TextStyle(
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
                    children: const [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.ebike, size: 20)),
                      Text("Bicicletes elèctriques disponibles: "),
                      Text("2")
                    ],
                  ),
                  Row(
                    children: const [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.bike, size: 20)),
                      Text("Bicicletes mecàniques disponibles: "),
                      Text("2")
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.parking, size: 20)),
                      Text("Espais disponibles: "),
                      Text("41")
                    ],
                  )
                ],
              )),
        ]));
  }

}

