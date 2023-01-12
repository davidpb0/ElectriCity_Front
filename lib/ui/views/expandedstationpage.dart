import 'package:electricity_front/core/controllers/booking_controller.dart';
import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/core/models/station_list.dart';
import 'package:electricity_front/ui/components/reservation_form.dart';
import 'package:electricity_front/ui/components/station_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/controllers/station_controller.dart';
import '../../core/controllers/user_controller.dart';
import '../../core/models/gas.dart';
import '../../fonts/test_icons_icons.dart';
import '../components/comment_form.dart';
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
  late bool faved;
  late Station bicingStation;
  late RechargeStation rechargeStation;
  late Image carita;
  late Gas gas;
  bool booked = false;

  @override
  void initState() {
    super.initState();
    _stationController = StationController();
    if (widget.bicing) {
      bicingStation = _stationController.getBicingStationbyId(widget.index);
      faved = UserController().currentUser.isFavouriteBicingStationIndex(bicingStation.id.toString());
      gas = bicingStation.gasAmount();
      switch (bicingStation.polution) {
        case 0:
          carita = Image.asset(
            'assets/images/gasesBien.png',
            fit: BoxFit.contain,
            height: 64,
          );
          break;
        case 1:
          carita = Image.asset(
            'assets/images/gasesRegular.png',
            fit: BoxFit.contain,
            height: 64,
          );
          break;
        case 2:
          carita = Image.asset(
            'assets/images/gasesMal.png',
            fit: BoxFit.contain,
            height: 64,
          );
          break;
        case 3:
          carita = Image.asset(
            'assets/images/gasesMuyMal.png',
            fit: BoxFit.contain,
            height: 64,
          );
          break;
        case 4:
          carita = Image.asset(
            'assets/images/gasesMuerte.png',
            fit: BoxFit.contain,
            height: 64,
          );
          break;
      }
    } else {
      rechargeStation = _stationController.getRechargeStationbyId(widget.index);
      faved = UserController().currentUser.isFavouriteRechargeStationIndex(rechargeStation.id.toString());
      gas = rechargeStation.gasAmount();
      switch (rechargeStation.polution) {
        case 0:
          carita = Image.asset(
            'assets/images/gasesBien.png',
            fit: BoxFit.contain,
            height: 64,
          );
          break;
        case 1:
          carita = Image.asset(
            'assets/images/gasesRegular.png',
            fit: BoxFit.contain,
            height: 64,
          );
          break;
        case 2:
          carita = Image.asset(
            'assets/images/gasesMal.png',
            fit: BoxFit.contain,
            height: 64,
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //Da la altura y el ancho total de la pantalla
    Size screensize = MediaQuery.of(context).size;
    CosmeticsController cosmeticsController = CosmeticsController();
    refresh() {
      setState(() {});
    }

    return Scaffold(
        backgroundColor: Color(cosmeticsController.getCurrentTheme().backgroundcolor),
        body: Stack(children: [
          Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: screensize.width,
                  decoration: BoxDecoration(
                    color: Color(cosmeticsController.getCurrentTheme().elementcolor),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(children: [
                    const SizedBox(height: 150),
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
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                                        shape: BoxShape.circle),
                                    alignment: Alignment.center,
                                    child: Text(
                                        (widget.bicing)
                                            ? bicingStation.id.toString()
                                            : rechargeStation.id.toString(),
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: Color(cosmeticsController.getCurrentTheme().elementcolor),
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
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Icon(
                                            (widget.bicing)
                                                ? TestIcons.bike
                                                : TestIcons.speedType,
                                            size: 60,
                                            color: Color(cosmeticsController.getCurrentTheme().textcolordark),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              (widget.bicing)
                                                  ? AppLocalizations.of(context)
                                                      .bicingstation_mechanical
                                                  : AppLocalizations.of(context)
                                                      .rechargestation_speed,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(cosmeticsController.getCurrentTheme().textcolordark),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                (widget.bicing)
                                                    ? bicingStation.mechanical
                                                        .toString()
                                                    : rechargeStation.speedType
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(cosmeticsController.getCurrentTheme().textcolordark),
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Icon(
                                            (widget.bicing)
                                                ? TestIcons.ebike
                                                : TestIcons.eCharger,
                                            size: 60,
                                            color: Color(cosmeticsController.getCurrentTheme().textcolordark)
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              (widget.bicing)
                                                  ? AppLocalizations.of(context)
                                                      .bicingstation_electrical
                                                  : AppLocalizations.of(context)
                                                      .rechargestation_connection,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(cosmeticsController.getCurrentTheme().textcolordark),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                (widget.bicing)
                                                    ? bicingStation.electrical
                                                        .toString()
                                                    : rechargeStation
                                                        .connectionType
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(cosmeticsController.getCurrentTheme().textcolordark),
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Icon(
                                            (widget.bicing)
                                                ? TestIcons.bicingParking
                                                : TestIcons.eCar,
                                            size: 60,
                                            color: Color(cosmeticsController.getCurrentTheme().textcolordark)
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              (widget.bicing)
                                                  ? AppLocalizations.of(context)
                                                      .bicingstation_slots
                                                  : AppLocalizations.of(context)
                                                      .rechargestation_slots,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(cosmeticsController.getCurrentTheme().textcolordark),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                (widget.bicing)
                                                    ? bicingStation
                                                        .availableSlots
                                                        .toString()
                                                    : rechargeStation.slots
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(cosmeticsController.getCurrentTheme().textcolordark),
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (widget.bicing){
                                      if (faved) {
                                        await UserController().deleteFavBicingBD(
                                            bicingStation.id.toString());
                                      } else {
                                        await UserController()
                                            .addFavBicingBD(bicingStation.id);
                                      }
                                    }
                                    else{
                                      if (faved) {
                                        await UserController().deleteFavChargerBD(
                                            rechargeStation.id.toString());
                                      } else {
                                        await UserController()
                                            .addFavChargerBD(RechargeStation().id);
                                      }
                                    }
                                    setState(() {
                                      if (faved) {
                                        faved = false;
                                      } else {
                                        faved = true;
                                      }

                                    });
                                  },
                                  minWidth: screensize.width / 3,
                                  color: (faved)? Color(cosmeticsController.getCurrentTheme().elementcolorcharger) : Color(cosmeticsController.getCurrentTheme().elementcolordark),
                                  child: Text((faved)? "Unfavourite" : "Favourite",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                                      )),
                                ),
                              ),
                              Visibility(
                                visible: !(widget.bicing),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: MaterialButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            BookingController booking =
                                                BookingController();
                                            booking.wipe();
                                            booking.setStationId(
                                                rechargeStation.id.toString());
                                            return const ReservationForm();
                                          });
                                    },
                                    minWidth: screensize.width / 3,
                                    color: Color(cosmeticsController.getCurrentTheme().elementcolorcharger),
                                    disabledColor: Color(cosmeticsController.getCurrentTheme().elementcolordark),
                                    child: Text("Book a slot",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                                        )),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                AppLocalizations.of(context)
                                    .expandedStation_gases,
                                style: TextStyle(fontSize: 15,
                                    color: Color(cosmeticsController.getCurrentTheme().textcolordark)
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: carita,
                              ),
                              gas.value != 0.0
                                  ? Text(
                                      "${gas.name} ${gas.value}",
                                      style: const TextStyle(color: Colors.red),
                                    )
                                  : Text(
                                      gas.name,
                                      style:
                                          const TextStyle(color: Colors.green),
                                    ),
                            ],
                          ),
                        ])),
                const Divider(),
                const Text("Comments"),
                StationCommentForm(
                    id: widget.index,
                    bicing: widget.bicing,
                    notifyParent: refresh),
                (widget.bicing)
                    ? listaCommentsBicing(refresh)
                    : listaCommentsCharger(refresh),
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
                      icon: Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                      ))))
        ]));
  }

  Widget listaCommentsBicing(dynamic ref) {
    if (bicingStation.commentsBicing.isEmpty) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Material(
              color: Colors.transparent,
              child: Text(
                AppLocalizations.of(context).expandedStation_noComments,
                style: const TextStyle(fontSize: 20),
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
                child: Row(children: [
                  Icon(
                    Icons.delete_forever,
                    size: 60,
                    color: Color(CosmeticsController().getCurrentTheme().elementcolordelete),
                    textDirection: TextDirection.ltr,
                  ),
                  const Expanded(child: SizedBox())
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
                  notifyParent: ref,
                )),
          );
        });
  }

  Widget listaCommentsCharger(dynamic ref) {
    if (rechargeStation.commentsCharger.isEmpty) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Material(
              color: Colors.transparent,
              child: Text(
                AppLocalizations.of(context).expandedStation_noComments,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )));
    }
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: rechargeStation.commentsCharger.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
                padding: const EdgeInsets.all(20),
                child: Row(children: [
                  Icon(
                    Icons.delete_forever,
                    size: 60,
                    color: Color(CosmeticsController().getCurrentTheme().elementcolordelete),
                    textDirection: TextDirection.ltr,
                  ),
                  const Expanded(child: SizedBox())
                ])),
            key: UniqueKey(),
            onDismissed: (DismissDirection direction) async {
              //await userCtrl.deletePersonalUbiEveryWhere(index);
              setState(() {});
            },
            child: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 1.0),
                child: StationComment(
                  info: rechargeStation.commentsCharger.elementAt(index),
                  notifyParent: ref,
                )),
          );
        });
  }
}
