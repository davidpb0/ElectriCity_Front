
import 'package:electricity_front/ui/views/expandedstationpage.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/station_controller.dart';
import '../../core/controllers/user_controller.dart';
import '../../core/models/recharge_station.dart';
import '../../fonts/test_icons_icons.dart';

class RechargePreview extends StatefulWidget {
  final RechargeStation info;

  const RechargePreview({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<RechargePreview> createState() => _RechargePreviewState();
}

class _RechargePreviewState extends State<RechargePreview> {


  @override
  Widget build(BuildContext context) {
    bool faved = UserController().currentUser.isFavouriteRechargeStationIndex(widget.info.id.toString());
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
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                decoration: ShapeDecoration(
                  color: Colors.green.shade800,
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
                    Expanded(
                      child: Text(
                        widget.info.address,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.info.id.toString(),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.zero,
                          bottomRight: Radius.circular(8),
                          topRight: Radius.zero),
                    )),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Icon(TestIcons.speedType, size: 20),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  widget. info.speedType.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Icon(TestIcons.eCharger, size: 20),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                widget.info.connectionType.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        Row(// TEXT
                            children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Icon(TestIcons.eCar, size: 20),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                widget.info.slots.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ]) //TEXT
                      ],
                      ),
                    ),
                    const VerticalDivider(),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          IconButton(onPressed: () async {
                            if (faved) {
                              await UserController().deleteFavChargerBD(
                                  widget.info.id.toString());
                            } else {
                              await UserController()
                                  .addFavChargerBD(widget.info.id);
                            }
                            setState(() {
                              if (faved) {
                                faved = false;
                              } else {
                                faved = true;
                              }

                              });

                            },
                            icon: Icon((faved) ? Icons.favorite : Icons.favorite_outline),
                          ),

                          IconButton(onPressed: () async {
                            await StationController().extractCommentsCharger(widget.info.id, widget.info);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ExpandedStationPage(index: widget.info.id, bicing: false)));
                          },
                            icon: const Icon(Icons.open_in_new),
                          )

                        ]
                      )
                    )
                ]),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
