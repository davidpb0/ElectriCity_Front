import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/list_controller.dart';
import '../../core/models/recharge_station.dart';
import '../../core/models/station_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StationCommentForm extends StatefulWidget {
  const StationCommentForm({
    Key? key,
    required this.id,
    required this.bicing,
  }) : super(key: key);
  final int id;
  final bool bicing;

  @override
  State<StationCommentForm> createState() => _StationCommentFormState();
}

class _StationCommentFormState extends State<StationCommentForm> {
  final TextEditingController commentTextController = TextEditingController();
  late ListController listCtrl;
  late Station bicingStation;
  late RechargeStation rechargeStation;

  @override
  void initState() {
    super.initState();
    listCtrl = ListController();
    if (widget.bicing) {
      var firstBicing = listCtrl.getBicingStation(0);
      bicingStation = listCtrl.getBicingStation(widget.id - firstBicing.id);
    } else {
      var firstCharger = listCtrl.getRechargeStation(0);
      rechargeStation = listCtrl.getRechargeStation(widget.id - firstCharger.id);
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
                        decoration: ShapeDecoration(
                          color: Colors.grey[300],
                          shape: const RoundedRectangleBorder(
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
                              UserController().currentUser.username,
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
                                              prefixIcon: Icon(Icons.comment),
                                              border: InputBorder.none,
                                              hintText: AppLocalizations.of(
                                                      context)
                                                  .expandedStation_addComment,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (widget.bicing) {
                                                bicingStation.addComment(
                                                    commentTextController.text,
                                                    UserController()
                                                        .currentUser);
                                              }
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.send))
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
