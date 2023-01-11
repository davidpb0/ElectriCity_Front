import 'dart:core';
import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/user_controller.dart';
import '../../core/models/station_list.dart';
import '../../fonts/test_icons_icons.dart';

// ignore: must_be_immutable
class InfoBicingStationWindow extends StatefulWidget {
  InfoBicingStationWindow(
      {super.key,
      required this.belec,
      required this.bmech,
      required this.slots,
      required this.addres,
      required this.liked,
      required this.bicing});

  final int? belec, bmech, slots;
  final String addres;
  final Station bicing;
  bool liked;

  @override
  State<InfoBicingStationWindow> createState() =>
      _InfoBicingStationWindowState();
}

class _InfoBicingStationWindowState extends State<InfoBicingStationWindow> {
  CosmeticsController cosmeticsController = CosmeticsController();
  Icon like = Icon(Icons.favorite_border_outlined, color: Color(CosmeticsController().getCurrentTheme().textcolorlight));

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
            border: Border.all(color: Color(cosmeticsController.getCurrentTheme().textfieldcolor)),
            borderRadius: BorderRadius.circular(12),
            color: Color(cosmeticsController.getCurrentTheme().textfieldcolor)),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: Color(cosmeticsController.getCurrentTheme().elementcolorbicing)),
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
              Expanded(
                child: Text(
                  widget.addres,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    setState(() {
                      if (widget.liked) {
                        widget.liked = false;
                      } else {
                        widget.liked = true;
                      }
                    });
                    if (!widget.liked) {
                      await UserController().deleteFavBicingBD(
                          widget.bicing.id.toString());
                    } else {
                      await UserController()
                          .addFavBicingBD(widget.bicing.id);
                    }
                  },
                  icon: Icon((widget.liked)
                      ? Icons.favorite
                      : Icons.favorite_border_outlined), color: Color(cosmeticsController.getCurrentTheme().textcolorlight))
            ]),
          ),
          Container(
              color: Color(cosmeticsController.getCurrentTheme().textfieldcolor),
              child: Column(
                //padding
                children: [
                  Row(
                    children: [
                      Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.ebike, size: 20, color: Color(cosmeticsController.getCurrentTheme().textcolordark),)),
                      Text("Bicicletes elèctriques disponibles: ", style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark))),
                      Text(widget.belec.toString(), style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),)
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.bike, size: 20, color: Color(cosmeticsController.getCurrentTheme().textcolordark), )),
                      Text("Bicicletes mecàniques disponibles: ", style: TextStyle(color:  Color(cosmeticsController.getCurrentTheme().textcolordark)),),
                      Text(widget.bmech.toString(), style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),)
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.bicingParking, size: 20, color: Color(cosmeticsController.getCurrentTheme().textcolordark))),
                      Text("Espais disponibles: ", style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),),
                      Text(widget.slots.toString(), style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),)
                    ],
                  )
                ],
              )),
        ]),
      ),
    );
  }
}
