import 'package:electricity_front/core/controllers/mapaController.dart';
import 'package:electricity_front/core/controllers/userController.dart';
import 'package:electricity_front/core/models/RechargeStation.dart';
import 'package:electricity_front/core/models/StationList.dart';
import 'package:electricity_front/ui/components/info_bicing_station_window.dart';
import 'package:electricity_front/ui/components/info_charge_station_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Google_Mapa extends StatefulWidget {
  @override
  _Google_MapaState createState() => _Google_MapaState();

  Google_Mapa({Key? key}) :super(key: key);

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(41.3870154, 2.1700471);
  final LatLng _aux = const LatLng(41.3979779, 2.1801069);


}

class _Google_MapaState extends State<Google_Mapa> {
  late BitmapDescriptor bicingMarker;
  late BitmapDescriptor chargerMarker;
  late BitmapDescriptor personalMarker;
  final Set<Marker> _markers = {};
  MapaController _mapaController = MapaController();
  UserController _userController = UserController();
  late List<LatLng> bicingList;
  late List<Station> bicingStationList;
  late List<Marker> personalMarkers;
  late List<RechargeStation> chargerStationList;
  late List<LatLng> rcList;
  Widget info = Container();
  late String title;
  String ?address;
  String ?telfn;


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
    await _mapaController.bicingApi();
    await _mapaController.rechargeApi();

    bicingList = _mapaController.BicingList;
    rcList = _mapaController.CargaList;
    personalMarkers = _userController.current_user.personal_ubi;
    bicingStationList = _mapaController.BicingStationList;
    chargerStationList = _mapaController.ChargerStationList;

    setState(() {
      for (int i = 0; i < bicingList.length; ++i) {
        _markers.add(
          Marker(
              markerId: MarkerId("id-" + i.toString()),
              position: bicingStationList[i].coords,
              icon: bicingMarker,
              onTap: () {
                setState(() {
                  info = InfoBicingStationWindow(
                      belec: bicingStationList[i].electrical,
                      bmech: bicingStationList[i].mechanical,
                      slots: bicingStationList[i].availableSlots,
                      addres: bicingStationList[i].address
                  );
                });
              }
          ),
        );

        _markers.add(
          Marker(
            markerId: MarkerId(
                "id-" + (i + bicingStationList.length).toString()),
            position: chargerStationList[i].coords,
            icon: chargerMarker,
            onTap: () {
              setState(() {
                info = InfoChargeStationWindow(
                  slots: chargerStationList[i].slots,
                  addres: chargerStationList[i].address,
                  connectionType: chargerStationList[i].connectionType,
                );
              });
            },
          ),
        );

        for(int j = 0; j < personalMarkers.length; ++j){
          _markers.add(personalMarkers[j]);
        }
      }
    });

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(2.0),
                  child: Text('ElectriCity')),
              Image.asset(
                'assets/images/title_logo_car.png',
                fit: BoxFit.contain,
                height: 32,
              ),
            ]
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40)),
        ),
        backgroundColor: Colors.green,
        elevation: 20,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: SizedBox(),
        ),

      ),

      body: Stack(
          children: [
            Container(
              child: GoogleMap(
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
                onTap: (latlang){
                  setState(() {
                    info = Container();
                    form = Container();
                  });
                },
                markers: _markers,
              ),
            ),
            Container(
                height: 130,
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.595),
                child: info
            ),
            Container(
                height: 130,
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.5),
                child: form
            ),
          ]
      ),

    );
  }


}



