import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/core/models/StationList.dart';
import 'package:electricity_front/ui/components/bicing_preview.dart';
import 'package:electricity_front/ui/components/recharge_preview.dart';
import 'package:flutter/material.dart';

import '../../core/controllers/list_controller.dart';
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
  late ListController listCtrl;
  bool bicing = true;

  @override
  void initState() {
    super.initState();
    listCtrl = ListController();
    futureBicing = listCtrl.fetchBicingStations();
    futureRecharge = listCtrl.fetchRechargeStations();
  }

  @override
  Widget build(BuildContext context) {
    //Da la altura y el ancho total de la pantalla
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: DefaultHeader(size: Size(screensize.width, (screensize.height * 0.1))),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //icon eCar
            Builder(
              builder: (context) {
                if (bicing){
                  return Icon(TestIcons.eCar, size: 20, color: Colors.grey);
                }
                return Icon(TestIcons.eCar, size: 20, color: Colors.blue);
              }
            ),
            Switch(
              // This bool value toggles the switch.
              value: bicing,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.blue,
              inactiveTrackColor: Colors.blue,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  bicing = value;
                });
              },
            ),
            Builder(
                builder: (context) {
                  if (bicing){
                    return Icon(TestIcons.bike, size: 20, color: Colors.green);
                  }
                  return Icon(TestIcons.bike, size: 20, color: Colors.grey);
                }
            ),
          ]),
        ),
        Expanded(
            child: FutureBuilder(
                future: futureBicing,
                builder: (context, snapshot) {
                  // WHILE THE CALL IS BEING MADE AKA LOADING
                  if (ConnectionState.active != null && !snapshot.hasData) {
                    return Center(child: Text('Loading'));
                  }

                  // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
                  else if (ConnectionState.done != null && snapshot.hasError) {
                    return Center(child: Text("Error"));
                  }

                  // IF IT WORKS IT GOES HERE!
                  else if (bicing) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: listCtrl.getTotalBicingStations(),
                      itemBuilder: (context, index) {
                        return BicingPreview(
                            info: listCtrl.getBicingStation(index));
                      },
                    );
                  } else
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: listCtrl.getTotalRechargeStations(),
                      itemBuilder: (context, index) {
                        return RechargePreview(
                            info: listCtrl.getRechargeStation(index));
                      },
                    );
                }))
      ]),
    );
  }
}
