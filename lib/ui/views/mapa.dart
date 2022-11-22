import 'package:electricity_front/core/controllers/mapa_controller.dart';
import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/core/models/StationList.dart';
import 'package:electricity_front/ui/components/info_bicing_station_window.dart';
import 'package:electricity_front/ui/components/info_charge_station_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class GoogleMapa extends StatefulWidget {
  @override
  GoogleMapaState createState() => GoogleMapaState();

  GoogleMapa({Key? key}) : super(key: key);

  late GoogleMapController mapController;

  //final LatLng _center = const LatLng(41.3870154, 2.1700471);
  final LatLng _aux = const LatLng(41.3979779, 2.1801069);
}

class GoogleMapaState extends State<GoogleMapa> {
  late BitmapDescriptor bicingMarker;
  late BitmapDescriptor chargerMarker;
  late BitmapDescriptor personalMarker;
  final Set<Marker> _markers = {};
  final MapaController _mapaController = MapaController();
  final UserController _userController = UserController();
  late List<LatLng> bicingList;
  late List<Station> bicingStationList;
  late List<Marker> personalMarkers;
  late List<RechargeStation> chargerStationList;
  late List<LatLng> rcList;
  Widget info = Container();
  late String title;
  String? address;
  String? telfn;

  static const int bicingPages = 18;

  Widget form = Container();

  @override
  void initState() {
    super.initState();
  }

  void setCustomMarker() async {
    bicingMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/blue_bike.png');
    chargerMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/green_charger.png');
    personalMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/personal_pin.png');
  }

  void _onMapCreated(GoogleMapController controller) async {
    setCustomMarker();
    int o = 1;
    int j = 0;
    int q = 0;

    while(o < bicingPages) {
      await _mapaController.bicingApi(o);
      await _mapaController.rechargeApi(o);

      bicingList = _mapaController.bicingList;
      rcList = _mapaController.cargaList;
      personalMarkers = _userController.currentUser.personalUbi;
      bicingStationList = _mapaController.bicingStationList;
      chargerStationList = _mapaController.chargerStationList;

      setState(() {
        for (int i = q; i < bicingList.length; ++i) {
          print("Entro en el for");
          _markers.add(
            Marker(
                markerId: MarkerId("id-${i+1}"),
                position: bicingStationList[i].coords,
                icon: bicingMarker,
                onTap: () {
                  setState(() {
                    print("La i es " + i.toString());
                    info = InfoBicingStationWindow(
                        belec: bicingStationList[i].electrical,
                        bmech: bicingStationList[i].mechanical,
                        slots: bicingStationList[i].availableSlots,
                        addres: bicingStationList[i].address);
                  });
                }),
          );
        }
        for (int k = q; k < chargerStationList.length; ++k) {
          _markers.add(
            Marker(
              markerId:
              MarkerId("id-${k + 502}"),
              position: chargerStationList[k].coords,
              icon: chargerMarker,
              onTap: () {
                setState(() {
                  print(k.toString());
                  info = InfoChargeStationWindow(
                    slots: chargerStationList[k].slots,
                    addres: chargerStationList[k].address,
                    connectionType: chargerStationList[k].connectionType,
                  );
                });
              },
            ),
          );
        }

        for (j; j < personalMarkers.length; ++j) {
          _markers.add(personalMarkers[j]);
        }
      });

      setState(() {});
      ++o;
      q+=30;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              padding: const EdgeInsets.all(2.0), child: const Text('ElectriCity')),
          Image.asset(
            'assets/images/title_logo_car.png',
            fit: BoxFit.contain,
            height: 32,
          ),
        ]),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40)),
        ),
        backgroundColor: Colors.green,
        elevation: 20,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: SizedBox(),
        ),
      ),
      body: Stack(children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: widget._aux,
            zoom: 16,
          ),
          onLongPress: (latlang) async {
            _mapaController.coords = latlang;
            _mapaController.personalMarker = await personalMarker;
            Navigator.of(context).pushReplacementNamed('/form_ubi');
          },
          onTap: (latlang) {
            setState(() {
              info = Container();
              form = Container();
            });
          },
          markers: _markers,
        ),
        Container(
            height: 130,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.595),
            child: info),
        Container(
            height: 130,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
            child: form),
      ]),
    );
  }
}
