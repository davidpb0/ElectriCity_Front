import 'package:electricity_front/core/controllers/station_controller.dart';
import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import '../../core/models/recharge_station.dart';
import '../../core/models/station_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StationCommentForm extends StatefulWidget {
  final Function() notifyParent;
  const StationCommentForm({
    Key? key,
    required this.id,
    required this.bicing, required this.notifyParent,
  }) : super(key: key);
  final int id;
  final bool bicing;

  @override
  State<StationCommentForm> createState() => _StationCommentFormState();
}

class _StationCommentFormState extends State<StationCommentForm> {
  final TextEditingController commentTextController = TextEditingController();
  late StationController _stationController;
  late Station bicingStation;
  late RechargeStation rechargeStation;

  @override
  void initState() {
    super.initState();
    _stationController = StationController();
    if (widget.bicing) {
      bicingStation = _stationController.getBicingStationbyId(widget.id);
    } else {
      rechargeStation = _stationController.getRechargeStationbyId(widget.id);
    }
  }

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
                    Flex(direction: Axis.horizontal, children: [
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        decoration: const ShapeDecoration(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.zero,
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.zero,
                                topRight: Radius.circular(8)),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 40,
                            ),
                            Text(
                              UserController().currentUser.getUsername(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                                  child: Column(children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: commentTextController,
                                            decoration: InputDecoration(
                                              prefixIcon: const Icon(Icons.comment),
                                              border: InputBorder.none,
                                              hintText: AppLocalizations.of(
                                                      context)
                                                  .expandedStation_addComment,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              if (widget.bicing) {
                                                await _stationController.addBicingCommentBD(bicingStation,
                                                    commentTextController.text,
                                                    UserController()
                                                        .currentUser.getUsername());
                                              }
                                              else{
                                                await _stationController.addChargerCommentBD(rechargeStation,
                                                    commentTextController.text,
                                                    UserController()
                                                        .currentUser.getUsername());
                                              }
                                              setState(() {
                                                commentTextController.text = "";
                                              });
                                              widget.notifyParent();
                                            },
                                            icon: const Icon(Icons.send))
                                      ],
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
                    color: Colors.grey[300],
                  ),
                  child: const Icon(
                    Icons.account_circle,
                    size: 24,
                    color: Colors.pink,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
