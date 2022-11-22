import 'package:electricity_front/core/controllers/mapa_controller.dart';
import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:electricity_front/core/models/StationList.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/ui/components/info_bicing_station_window.dart';
import 'package:electricity_front/ui/components/info_charge_station_window.dart';
import 'package:electricity_front/ui/views/routepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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

  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  Widget form = Container();

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
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

    bicingList = _mapaController.bicingList;
    rcList = _mapaController.cargaList;
    personalMarkers = _userController.currentUser.personalUbi;
    bicingStationList = _mapaController.bicingStationList;
    chargerStationList = _mapaController.chargerStationList;

    setState(() {
      for (int i = 0; i < bicingList.length; ++i) {
        _markers.add(
          Marker(
              markerId: MarkerId("id-$i"),
              position: bicingStationList[i].coords,
              icon: bicingMarker,
              onTap: () {
                setState(() {
                  info = InfoBicingStationWindow(
                      belec: bicingStationList[i].electrical,
                      bmech: bicingStationList[i].mechanical,
                      slots: bicingStationList[i].availableSlots,
                      addres: bicingStationList[i].address);
                });
              }),
        );

        _markers.add(
          Marker(
            markerId: MarkerId("id-${i + bicingStationList.length}"),
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

        for (int j = 0; j < personalMarkers.length; ++j) {
          _markers.add(personalMarkers[j]);
        }
      }
    });

    setPolylines();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Stack(children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: widget._aux,
            zoom: 16,
          ),
          myLocationEnabled: true,
          polylines: _polylines,
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
        ]
      ),
        RoutePage(height:MediaQuery.of(context).size.height * 0.25)
      ]
    );
  }

  void setPolylines() async {
    print("entro en la funcion");
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCDg_4vAv_MQQyRHTc94dBLngBqqmdO3ZM",
        PointLatLng(41.3979779, 2.1801069),
        PointLatLng(41.3954877, 2.1771985));
    print(result.status.toString());

    if (result.status == 'OK') {
      print("He entrado en el if");
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates));
      });
    }
  }
}
