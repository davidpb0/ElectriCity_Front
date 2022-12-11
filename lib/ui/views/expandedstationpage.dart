import 'package:electricity_front/core/controllers/booking_controller.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/core/models/station_list.dart';
import 'package:electricity_front/ui/components/reservation_form.dart';
import 'package:electricity_front/ui/components/station_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/controllers/station_controller.dart';
import '../../fonts/test_icons_icons.dart';
import '../components/commentForm.dart';
import '../components/default_header.dart';

class ExpandedStationPage extends StatefulWidget {
  const ExpandedStationPage(
      {Key? key, required this.index, required this.bicing})
      : super(key: key);

  final int index;
  final bool bicing;

  @override
  State<ExpandedStationPage> createState() => _ExpandedStationPageState();
}

class _ExpandedStationPageState extends State<ExpandedStationPage> {
  late StationController _stationController;
  late Station bicingStation;
  late RechargeStation rechargeStation;

  @override
  void initState() {
    super.initState();
    _stationController = StationController();
    if (widget.bicing) {
      bicingStation = _stationController.getBicingStationbyId(widget.index);
    } else {
      rechargeStation = _stationController.getRechargeStationbyId(widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Da la altura y el ancho total de la pantalla
    Size screensize = MediaQuery.of(context).size;
    refresh() {
      setState(() {});
    }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Stack(children: [
          Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: screensize.width,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(children: [
                    const SizedBox(height: 112),
                    Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text(
                                    (widget.bicing)
                                        ? bicingStation.address
                                        : rechargeStation.address,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    height: 60,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    alignment: Alignment.center,
                                    child: Text(
                                        (widget.bicing)
                                            ? bicingStation.id.toString()
                                            : rechargeStation.id.toString(),
                                        style: const TextStyle(
                                            fontSize: 28,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))))
                          ],
                        )),
                  ]),
                ),
                Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top:12),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Icon((widget.bicing)
                                          ? TestIcons.bike
                                          : TestIcons.speedType, size: 60),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            (widget.bicing)
                                                ? AppLocalizations.of(context).bicingstation_mechanical
                                                : AppLocalizations.of(context).rechargestation_speed,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),


                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                              (widget.bicing)
                                                  ? bicingStation.mechanical.toString()
                                                  : rechargeStation.speedType.toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),),

                            Padding(
                                padding: EdgeInsets.only(top:12),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Icon((widget.bicing)
                                          ? TestIcons.ebike
                                          : TestIcons.eCharger, size: 60),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            (widget.bicing)
                                                ? AppLocalizations.of(context).bicingstation_electrical
                                                : AppLocalizations.of(context).rechargestation_connection,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),


                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                              (widget.bicing)
                                                  ? bicingStation.electrical.toString()
                                                  : rechargeStation.connectionType.toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),),

                            Padding(
                                padding: EdgeInsets.only(top:12),
                                child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Icon((widget.bicing)
                                      ? TestIcons.bicingParking
                                      : TestIcons.eCar, size: 60),                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        (widget.bicing)
                                            ? AppLocalizations.of(context).bicingstation_slots
                                            : AppLocalizations.of(context).rechargestation_slots,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          (widget.bicing)
                                              ? bicingStation.availableSlots.toString()
                                              : rechargeStation.slots.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),),

                          ],
                        ),
                      ),
                      VerticalDivider(),

                      Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: MaterialButton(
                                onPressed: () {},
                                minWidth: screensize.width / 3,
                                color: Colors.grey[800],
                                disabledColor: Colors.grey[800],
                                child: const Text("Favourite",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: MaterialButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        BookingController booking = BookingController();
                                        booking.wipe();
                                        booking.setStationId(rechargeStation.id.toString());
                                        return const ReservationForm();


                                      });
                                },
                                minWidth: screensize.width / 3,
                                color: Colors.grey[800],
                                disabledColor: Colors.grey[800],
                                child: const Text("Book a slot",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ],
                        ),

                    ])),
                Divider(),
                Container(child: Text("Comments")),
                StationCommentForm(
                    id: widget.index,
                    bicing: widget.bicing,
                    notifyParent: refresh),
                listaCommentsBicing(refresh),

              ]),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: DefaultHeader(
                size: Size(screensize.width, (screensize.height * 0.15))),
          ),
          Material(
              color: Colors.transparent,
              child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 40),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Colors.white,
                      ))))
        ]));
  }

  Widget listaCommentsBicing(dynamic ref) {
    if (bicingStation.commentsBicing.isEmpty) {
      return Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Material(
              color: Colors.transparent,
              child: Text(
                AppLocalizations.of(context).expandedStation_noComments,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )));
    }
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: bicingStation.commentsBicing.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
                padding: const EdgeInsets.all(20),
                child: Row(children: const [
                  Icon(
                    Icons.delete_forever,
                    size: 60,
                    color: Colors.red,
                    textDirection: TextDirection.ltr,
                  ),
                  Expanded(child: SizedBox())
                ])),
            key: UniqueKey(),
            onDismissed: (DismissDirection direction) async {
              //await userCtrl.deletePersonalUbiEveryWhere(index);
              setState(() {});
            },
            child: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 1.0),
                child: StationComment(
                    info: bicingStation.commentsBicing.elementAt(index),
                notifyParent: ref,)),
          );
        });
  }
}
