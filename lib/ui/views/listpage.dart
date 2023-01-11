import 'dart:async';

import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:electricity_front/core/controllers/list_controller.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/core/models/station_list.dart';
import 'package:electricity_front/ui/components/bicing_preview.dart';
import 'package:electricity_front/ui/components/recharge_preview.dart';
import 'package:electricity_front/ui/views/dropdown_current_type.dart';
import 'package:flutter/material.dart';


import '../../core/controllers/station_controller.dart';
import '../../fonts/test_icons_icons.dart';
import '../components/default_header.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<Station>> futureBicing;
  late Future<List<RechargeStation>> futureRecharge;
  StationController stationCtrl = StationController();
  CosmeticsController cosmeticsController = CosmeticsController();
  bool bicing = true;
  int fBicing = 0;
  int fRecharge = 0;
  late String valueCurrentType = "None";
  late String valueConnectionType = "None";
  late String valueSpeedType = "None";

  static final List<String> _speedTypes = [
    "RAPID",
    "semiRAPID",
    "NORMAL"
  ];

  static final List<String> _connectionTypes = [
    "MENNEKES",
    "MENNEKES.M",
    "MENNEKES.F",
    "MENNEKES.TESLA",
    "TESLA",
    "CSS Combo2",
    "Schuko",
    "ChadeMO"
  ];

  catchCurrentTypeValue(String newValue) {
    setState(() {
      valueCurrentType = newValue;
      stationCtrl.filterRechargeStation(valueSpeedType, valueConnectionType, valueCurrentType);
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () => build(context));
    ListController().initFilters();
  }

  @override
  Widget build(BuildContext context) {
    //Da la altura y el ancho total de la pantalla
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(cosmeticsController.getCurrentTheme().backgroundcolor),
      appBar: DefaultHeader(
          size: Size(screenSize.width, (screenSize.height * 0.15))),
      body: Column(children: [
        Builder(
          builder: (context) {
            if(!bicing){
              return Row(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                  // filter Speed type
                  DropdownCurrentType(catchValue: catchCurrentTypeValue),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                  // filter Connection type
                  /*MultiSelectBottomSheetField<String?>(
                    initialChildSize: 0.4,
                    buttonIcon: const Icon(TestIcons.eCharger, size: 22.0,),
                    searchable: true,
                    buttonText: const Text("Connection type", style: TextStyle(fontSize: 12.4),),
                    items: connectionTypesItems,
                    onConfirm: (values) {
                      _selectedConnectionTypes = values;
                    },
                    chipDisplay: MultiSelectChipDisplay.none(),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                  // filter Current type
                  MultiSelectBottomSheetField<String?>(
                    initialChildSize: 0.4,
                    buttonIcon: const Icon(Icons.electric_meter, size: 22.0,),
                    searchable: true,
                    buttonText: const Text("Current type", style: TextStyle(fontSize: 12.4),),
                    items: currentTypesItems,
                    onConfirm: (values) {
                      _selectedCurrentTypes = values;
                    },
                    chipDisplay: MultiSelectChipDisplay.none(),
                  ),*/
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                ],
              );
            }
            else{
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed:(){
                      ListController().filterBicingStations("slots");
                      setState(() {

                      });
                    } ,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (ListController().filterSlots) ? Color(CosmeticsController().getCurrentTheme().elementcolorbicing) : Color(CosmeticsController().getCurrentTheme().elementcolordark),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Text('Available Slots',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed:(){
                      ListController().filterBicingStations("bikes");
                      setState(() {

                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (ListController().filterBikes) ? Color(CosmeticsController().getCurrentTheme().elementcolorbicing) : Color(CosmeticsController().getCurrentTheme().elementcolordark),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Text('Available Bikes',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed:(){
                      ListController().filterBicingStations("ebikes");
                      setState(() {

                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (ListController().filterEBikes) ? Color(CosmeticsController().getCurrentTheme().elementcolorbicing) : Color(CosmeticsController().getCurrentTheme().elementcolordark),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Text('Available E-Bikes',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }
        ),
        Container(
          padding: const EdgeInsets.all(4),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //icon eCar
            Builder(builder: (context) {
              if (bicing) {
                return Icon(TestIcons.eCar, size: 20, color: Color(cosmeticsController.getCurrentTheme().elementcolor));
              }
              return Icon(TestIcons.eCar, size: 20, color: Color(cosmeticsController.getCurrentTheme().elementcolorcharger));
            }),
            Switch(
              // This bool value toggles the switch.
              value: bicing,
              activeColor: Color(cosmeticsController.getCurrentTheme().elementcolorbicing),
              inactiveThumbColor: Color(cosmeticsController.getCurrentTheme().elementcolorcharger),
              inactiveTrackColor: Color(cosmeticsController.getCurrentTheme().elementcolorcharger - 0x80000000),
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  bicing = value;
                });
              },
            ),
            Builder(builder: (context) {
              if (bicing) {
                return Icon(TestIcons.bike, size: 20, color: Color(cosmeticsController.getCurrentTheme().elementcolorbicing));
              }
              return Icon(TestIcons.bike, size: 20, color: Color(cosmeticsController.getCurrentTheme().elementcolor));
            }),
          ]),
        ),
        Visibility(
            visible: bicing,
            child: Expanded(
                child: StreamBuilder(
                    stream: stationCtrl.getBicingStationsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Error"));
                      } else if (snapshot.connectionState ==
                              ConnectionState.none &&
                          !stationCtrl.bicisStarted) {
                        return const Center(child: Text('Loading'));
                      } else if (snapshot.connectionState ==
                              ConnectionState.waiting &&
                          !stationCtrl.bicisStarted) {
                        return const Center(child: Text('Loading'));
                      } else if (snapshot.connectionState ==
                              ConnectionState.active &&
                          !stationCtrl.bicisStarted) {
                        return const Center(child: Text('Loading'));
                      } else {
                        return ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[
                                    Color(cosmeticsController.getCurrentTheme().backgroundcolor),
                                    Colors.transparent,
                                    Colors.transparent,
                                    Color(cosmeticsController.getCurrentTheme().backgroundcolor)
                                  ],
                                  stops: const [
                                    0.0,
                                    0.05,
                                    0.95,
                                    1.0
                                  ]).createShader(bounds);
                            },
                            blendMode: BlendMode.dstOut,
                            child: Builder(
                              builder: (context) {
                                if (ListController().filterSlots){
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: ListController().filterBicinglist_slots.length,
                                    itemBuilder: (context, index) {
                                      return BicingPreview(
                                          info: stationCtrl.getBicingStationbyId(ListController().filterBicinglist_slots[index].id));
                                    },
                                  );
                                }
                                else if (ListController().filterBikes){
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: ListController().filterBicinglist_bikes.length,
                                    itemBuilder: (context, index) {
                                      return BicingPreview(
                                          info: stationCtrl.getBicingStationbyId(ListController().filterBicinglist_bikes[index].id));
                                    },
                                  );
                                }
                                else if (ListController().filterEBikes){
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: ListController().filterBicinglist_ebikes.length,
                                    itemBuilder: (context, index) {
                                      return BicingPreview(
                                          info: stationCtrl.getBicingStationbyId(ListController().filterBicinglist_ebikes[index].id));
                                    },
                                  );
                                }
                                else {
                                  return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: stationCtrl.getTotalBicingStations(),
                                  itemBuilder: (context, index) {
                                    return BicingPreview(
                                        info: stationCtrl.getBicingStation(index));
                                  },
                                );
                                }
                              }
                            )
                        );
                      }
                    })
            )
        ),
        Visibility(
          visible: !bicing,
          child: Expanded(
              child: StreamBuilder(
                  stream: stationCtrl.getRechargeStationsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text("Error"));
                    } else if (snapshot.connectionState ==
                            ConnectionState.none &&
                        !stationCtrl.chargersStarted) {
                      return const Center(child: Text('Loading'));
                    } else if (snapshot.connectionState ==
                            ConnectionState.waiting &&
                        !stationCtrl.chargersStarted) {
                      return const Center(child: Text('Loading'));
                    } else if (snapshot.connectionState ==
                            ConnectionState.active &&
                        !stationCtrl.chargersStarted) {
                      return const Center(child: Text('Loading'));
                    } else {
                      // WHILE THE CALL IS BEING MADE AKA LOADING
                      return ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Color(cosmeticsController.getCurrentTheme().backgroundcolor),
                                  Colors.transparent,
                                  Colors.transparent,
                                  Color(cosmeticsController.getCurrentTheme().backgroundcolor),
                                ],
                                stops: const [
                                  0.0,
                                  0.05,
                                  0.95,
                                  1.0
                                ]).createShader(bounds);
                          },
                          blendMode: BlendMode.dstOut,
                          child: Builder(
                            builder: (context) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: stationCtrl.getTotalRechargeStations(),
                                itemBuilder: (context, index) {
                                  return RechargePreview(
                                      info: stationCtrl.getRechargeStation(index));
                                },
                              );
                            }
                          )
                      );
                    }
                  })
          ),
        )
      ]),
    );
  }
}
 Widget filters(){
  return Row(
    children: [
      TextButton(
          onPressed:(){
            //ListController().filterSlots();
          } ,
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(CosmeticsController().getCurrentTheme().elementcolordark),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: const Text('Available Slots')
          ),
      ),
      TextButton(
        onPressed:(){
          //ListController().filterSlots();
        },
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(CosmeticsController().getCurrentTheme().elementcolordark),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 1,
                ),
              ],
            ),
            child: const Text('Available Bikes')
        ),
      ),
    ],
  );
 }