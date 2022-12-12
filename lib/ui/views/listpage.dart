import 'dart:async';

import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/core/models/station_list.dart';
import 'package:electricity_front/ui/components/bicing_preview.dart';
import 'package:electricity_front/ui/components/recharge_preview.dart';
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
  bool bicing = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () => build(context));
  }

  @override
  Widget build(BuildContext context) {
    //Da la altura y el ancho total de la pantalla
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: DefaultHeader(
          size: Size(screenSize.width, (screenSize.height * 0.1))),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //icon eCar
            Builder(builder: (context) {
              if (bicing) {
                return const Icon(TestIcons.eCar, size: 20, color: Colors.grey);
              }
              return const Icon(TestIcons.eCar, size: 20, color: Colors.green);
            }),
            Switch(
              // This bool value toggles the switch.
              value: bicing,
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.green,
              inactiveTrackColor: Colors.green.shade400,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  bicing = value;
                });
              },
            ),
            Builder(builder: (context) {
              if (bicing) {
                return const Icon(TestIcons.bike, size: 20, color: Colors.blue);
              }
              return const Icon(TestIcons.bike, size: 20, color: Colors.grey);
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
                                    Colors.grey.shade300,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.grey.shade300
                                  ],
                                  stops: const [
                                    0.0,
                                    0.05,
                                    0.95,
                                    1.0
                                  ]).createShader(bounds);
                            },
                            blendMode: BlendMode.dstOut,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: stationCtrl.getTotalBicingStations(),
                              itemBuilder: (context, index) {
                                return BicingPreview(
                                    info: stationCtrl.getBicingStation(index));
                              },
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
                                  Colors.grey.shade300,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.grey.shade300
                                ],
                                stops: const [
                                  0.0,
                                  0.05,
                                  0.95,
                                  1.0
                                ]).createShader(bounds);
                          },
                          blendMode: BlendMode.dstOut,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: stationCtrl.getTotalRechargeStations(),
                            itemBuilder: (context, index) {
                              return RechargePreview(
                                  info: stationCtrl.getRechargeStation(index));
                            },
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
