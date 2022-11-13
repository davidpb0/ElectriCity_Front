import 'dart:core';
import 'package:flutter/material.dart';

import '../../fonts/test_icons_icons.dart';

class InfoBicingStationWindow extends StatelessWidget{
  const InfoBicingStationWindow({required this.belec, required this.bmech, required this.slots, required this.addres});

  final int ?belec, bmech, slots;
  final String addres;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: 500,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 1,

            )],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            color: Colors.white
          ),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  color: Colors.blue
                ),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  addres,
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
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Icon(TestIcons.ebike, size: 20)),
                          const Text("Bicicletes elèctriques disponibles: "),
                          Text(belec.toString())
                        ],
                      ),
                      Row(
                        children:[
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Icon(TestIcons.bike, size: 20)),
                          Text("Bicicletes mecàniques disponibles: "),
                          Text(bmech.toString())
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Icon(TestIcons.bicing_parking, size: 20)),
                          Text("Espais disponibles: "),
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

