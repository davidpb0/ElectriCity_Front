import 'package:electricity_front/core/controllers/mapa_controller.dart';
import 'package:electricity_front/core/controllers/user_controller.dart';
import 'package:electricity_front/core/models/StationList.dart';
import 'package:electricity_front/core/models/recharge_station.dart';
import 'package:electricity_front/ui/components/info_bicing_station_window.dart';
import 'package:electricity_front/ui/components/info_charge_station_window.dart';
import 'package:electricity_front/ui/views/routepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/default_header.dart';

// ignore: must_be_immutable
class GoogleMapa extends StatefulWidget {
  @override
  GoogleMapaState createState() => GoogleMapaState();

  const GoogleMapa({Key? key}) : super(key: key);

  //final LatLng _center = const LatLng(41.3870154, 2.1700471);
  final LatLng _aux = const LatLng(41.3979779, 2.1801069);
}

class GoogleMapaState extends State<GoogleMapa> {
  late GoogleMapController mc;
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

  static const int bicingPages = 18;

  Widget form = Container();
  Widget top = const DefaultHeader(size: Size(100.0, 100.0));

  @override
  void initState() {
    super.initState();
  }

  void setCustomMarker() async {
    bool isIOS = Theme
        .of(context)
        .platform == TargetPlatform.iOS;
    if (isIOS) {
      bicingMarker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(0.1, 0.1), devicePixelRatio: 0.1),
          'assets/images/bikepin_ios.png');
      chargerMarker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(0.1, 0.1), devicePixelRatio: 0.1),
          'assets/images/chargerpin_ios.png');
      personalMarker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(0.1, 0.1), devicePixelRatio: 0.1),
          'assets/images/homepin_ios.png');
    } else {
      bicingMarker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(0.1, 0.1), devicePixelRatio: 0.1),
          'assets/images/bikepin.png');
      chargerMarker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(0.1, 0.1), devicePixelRatio: 0.1),
          'assets/images/chargerpin.png');
      personalMarker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(0.1, 0.1), devicePixelRatio: 0.1),
          'assets/images/homepin.png');
    }

  }

  void _onMapCreated(GoogleMapController controller) async {
    setCustomMarker();

    mc = controller;

    int o = 1;
    int j = 0;
    int q = 0;

    while (o < bicingPages) {
      //await _mapaController.bicingApi(o);
      //await _mapaController.rechargeApi(o);

      bicingList = _mapaController.bicingList;
      rcList = _mapaController.cargaList;
      personalMarkers = _userController.currentUser.personalUbi;
      bicingStationList = _mapaController.bicingStationList;
      chargerStationList = _mapaController.chargerStationList;

      setState(() {
        for (int i = q; i < bicingList.length; ++i) {
          _markers.add(
            Marker(
                markerId: MarkerId("id-${i + 1}"),
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
        }
        for (int k = q; k < chargerStationList.length; ++k) {
          _markers.add(
            Marker(
              markerId: MarkerId("id-${k + 502}"),
              position: chargerStationList[k].coords,
              icon: chargerMarker,
              onTap: () {
                setState(() {
                  //print(k.toString());
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
      q += 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    _mapaController.setGoogleMapaState(this);
    return Stack(alignment: Alignment.topCenter, children: [
      Stack(children: [
        /*currentLocation == null
            ? const Center(child: Text("Loading"),)*/
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: widget._aux,
            //LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
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
              top = const DefaultHeader(size: Size(100.0, 100.0));
              _polylines.clear();
              polylineCoordinates.clear();
              deleteMarker('origin');
              deleteMarker('destination');
            });
          },
          markers: _markers,
        ),
        Container(
            height: 130,
            margin:
            EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * 0.75),
            child: info),
        Container(
            height: 130,
            margin:
            EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * 0.5),
            child: form),
      ]),
      top,
      Container(
        margin: EdgeInsets.only(
            top: MediaQuery
                .of(context)
                .size
                .height * 0.72,
            left: MediaQuery
                .of(context)
                .size
                .width * 0.8),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              top =
                  RoutePage(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.25);
            });
          },
          child: const Icon(Icons.turn_right_outlined),
        ),
      ),


      Visibility(
          visible: Theme.of(context).platform != TargetPlatform.iOS,
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.81,
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8),
            child: FloatingActionButton(
              onPressed: () async {
                Position position = await _determinePosition();
                mc.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 14)));

                _markers.add(Marker(markerId: const MarkerId("currentLocation"),
                    position: LatLng(position.latitude, position.longitude)));

                setState(() {

                });
              },
              child: const Icon(Icons.location_history),
            ),
          )
      )
    ]);
  }

  void setPolylines(final PointLatLng punto1, final PointLatLng punto2) async {
    polylinePoints = PolylinePoints();
    polylineCoordinates.clear();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCDg_4vAv_MQQyRHTc94dBLngBqqmdO3ZM", punto1, punto2);

    if (result.status == 'OK') {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      //WidgetsBinding.instance.addPostFrameCallback((_)
      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: const PolylineId('polyLine'),
            color: const Color(0xFF08A5CB),
            points: polylineCoordinates));
      });
    }
  }

  void setMarker(LatLng location, String id) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(id),
        position: location,
        icon: personalMarker,
      ));
    });
  }

  void deleteMarker(String id) {
    Marker marker =
    _markers.firstWhere((marker) => marker.markerId.value == id);
    setState(() {
      _markers.remove(marker);
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanently denied");
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }


}
