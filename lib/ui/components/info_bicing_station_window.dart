import 'dart:core';
import 'package:flutter/material.dart';

import '../../fonts/test_icons_icons.dart';

class InfoBicingStationWindow extends StatefulWidget {
  const InfoBicingStationWindow({super.key,
    required this.belec,
    required this.bmech,
    required this.slots,
    required this.addres});

  final int? belec, bmech, slots;
  final String addres;


  @override
  State<InfoBicingStationWindow> createState() =>
      _InfoBicingStationWindowState();
}

class _InfoBicingStationWindowState extends State<InfoBicingStationWindow>{
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
                color: Colors.blue),
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
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
            ]),
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
                          child: Icon(TestIcons.ebike, size: 20)),
                      const Text("Bicicletes elèctriques disponibles: "),
                      Text(widget.belec.toString())
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.bike, size: 20)),
                      const Text("Bicicletes mecàniques disponibles: "),
                      Text(widget.bmech.toString())
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.bicingParking, size: 20)),
                      const Text("Espais disponibles: "),
                      Text(widget.slots.toString())
                    ],
                  )
                ],
              )),
        ]),
      ),
    );
  }

}
