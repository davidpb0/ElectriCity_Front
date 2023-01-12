import 'dart:core';
import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/cosmetics_controller.dart';
import '../../fonts/test_icons_icons.dart';

// ignore: must_be_immutable
class InfoChargeStationWindow extends StatefulWidget {
  InfoChargeStationWindow(
      {super.key,
      required this.slots,
      required this.addres,
      required this.connectionType,
      required this.liked,
      required this.charger});

  final int? slots;
  final String addres;
  final RechargeStation charger;
  String? connectionType;
  bool liked;

  @override
  State<InfoChargeStationWindow> createState() => _InfoChargeStationWindow();
}

class _InfoChargeStationWindow extends State<InfoChargeStationWindow> {
  CosmeticsController cosmeticsController = CosmeticsController();
  Icon like = Icon(Icons.favorite_border_outlined, color: Color(CosmeticsController().getCurrentTheme().textcolordark),);

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
                color: Color(cosmeticsController.getCurrentTheme().elementcolorcharger)),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
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
                        await UserController().deleteFavChargerBD(
                            widget.charger.id.toString());
                      } else {
                        await UserController()
                            .addFavChargerBD(widget.charger.id);
                      }
                    },
                    icon: Icon((widget.liked)
                        ? Icons.favorite
                        : Icons.favorite_border_outlined), color: Color(cosmeticsController.getCurrentTheme().textcolorlight),)
              ],
            ),
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
                          child: Icon(TestIcons.eCar, size: 20, color: Color(cosmeticsController.getCurrentTheme().textcolordark),)),
                      Text(AppLocalizations.of(context).infocharger_connection, style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),),
                      Text(widget.connectionType.toString(), style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),)
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.eCharger, size: 20, color: Color(cosmeticsController.getCurrentTheme().textcolordark))),
                      Text(AppLocalizations.of(context).infocharger_slots, style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),),
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
