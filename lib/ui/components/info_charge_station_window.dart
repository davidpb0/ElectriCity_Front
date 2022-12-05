import 'dart:core';
import 'package:electricity_front/core/controllers/mapa_controller.dart';
import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../fonts/test_icons_icons.dart';

// ignore: must_be_immutable
class InfoChargeStationWindow extends StatefulWidget {
  InfoChargeStationWindow(
      {super.key,
      required this.slots,
      required this.addres,
      required this.connectionType,
      required this.liked,
      required this.id});

  final int? slots;
  final String addres;
  final MarkerId id;
  String? connectionType;
  bool liked;

  @override
  State<InfoChargeStationWindow> createState() => _InfoChargeStationWindow();
}

class _InfoChargeStationWindow extends State<InfoChargeStationWindow> {
  Icon like = const Icon(Icons.favorite_border_outlined);

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
                        if (widget.liked) {
                          widget.liked = false;
                          UserController().currentUser.deleteFavCharger(
                              (MapaController()
                                  .chargerStationList
                                  .elementAt(int.parse(widget.id.value) - 601)));
                        } else {
                          widget.liked = true;
                          UserController().currentUser.addFavCharger(
                              (MapaController()
                                  .chargerStationList
                                  .elementAt(int.parse(widget.id.value) - 601)));

                        }
                      });
                    },
                    icon: Icon((widget.liked)
                        ? Icons.favorite
                        : Icons.favorite_border_outlined))
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.eCar, size: 20)),
                      const Text("Tipus de connexió: "),
                      Text(widget.connectionType.toString())
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.eCharger, size: 20)),
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
