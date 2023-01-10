import 'package:electricity_front/core/controllers/mapa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../fonts/test_icons_icons.dart';
import 'dropdown_item.dart';
import 'mapa.dart';

class RoutePage extends StatefulWidget implements PreferredSizeWidget {
  RoutePage({Key? key, required this.height})
      : preferredSize = Size.fromHeight(height),
        super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();

  @override
  final Size preferredSize;
  final double height;
}

class _RoutePageState extends State<RoutePage> {
  String googleApikey = "AIzaSyCDg_4vAv_MQQyRHTc94dBLngBqqmdO3ZM";
  GoogleMapController? mapController; //controller for Google map
  CameraPosition? cameraPosition;
  String origin = "Search Origin";
  String destination = "Search Destination";
  // ignore: prefer_typing_uninitialized_variables
  late var originToCoordinates;
  // ignore: prefer_typing_uninitialized_variables
  late var destinationToCoordinates;
  // ignore: prefer_typing_uninitialized_variables
  late var value;

  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: const BorderSide(color: Color(0xff01d277)));

  final formKey = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {
    origin = AppLocalizations.of(context).route_searchorigin;
    destination = AppLocalizations.of(context).route_searchdestination;
    return SizedBox(
        child: Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(36),
              bottomLeft: Radius.circular(36)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 10,
            ),
          ]),
      child: Stack(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Icon(TestIcons.eCharger, size: 20, color: Colors.white,),
          ),
          Positioned(
            left: 0,
            top: 58,
            //quiero cojer el valor de dropdownItem
            child: DropdownItem()
          ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    padding: const EdgeInsets.all(2.0),
                    child: const Text(
                      'ElectriCity',
                      style: TextStyle(color: Colors.white),
                    )),
                Image.asset(
                  'assets/images/title_logo_car.png',
                  fit: BoxFit.contain,
                  height: 20,
                ),
              ]),
              Positioned(
                top: 15,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 23),
                    ),
                    Text(AppLocalizations.of(context).route_origin,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        )
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Positioned(
              //search input bar
                top: 30,
                left: 21,
                child: SizedBox(
                  width: 358,
                  child: InkWell(
                    onTap: () async {
                      var place = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: googleApikey,
                      mode: Mode.overlay,
                      types: [],
                      strictbounds: false,
                      components: [Component(Component.country, 'es')],
                      //google_map_webservice package
                      onError: (err) {
                        Text(err.toString());
                    });

                    if (place != null) {
                      setState(() {
                      origin = place.description.toString();
                    });

                    //form google_maps_webservice package
                    final plist = GoogleMapsPlaces(
                     apiKey: googleApikey,
                      apiHeaders: await const GoogleApiHeaders().getHeaders(),
                      //from google_api_headers package
                    );

                    String placeid = place.placeId ?? "0";
                    final detail = await plist.getDetailsByPlaceId(placeid);
                    final geometry = detail.result.geometry!;
                    final lat = geometry.location.lat;
                    final lang = geometry.location.lng;
                    var newlatlang = LatLng(lat, lang);
                    originToCoordinates = PointLatLng(lat, lang);

                    MapaController().getGoogleMapa().mc.moveCamera(
                    CameraUpdate.newCameraPosition(
                    CameraPosition(target: newlatlang, zoom: 16)));
                    MapaController()
                        .getGoogleMapa()
                        .setMarker(newlatlang, "origin");

                    if (destination.isNotEmpty) {
                      List<PointLatLng> points = await MapaController().routePainting(originToCoordinates, destinationToCoordinates, DropdownItem().value);
                      GoogleMapaState googleMapa = MapaController().getGoogleMapa();
                      googleMapa.setPolylines(originToCoordinates, PointLatLng(points[0].latitude, points[0].longitude), true);
                      for (int i = 1; i < points.length; ++i) {
                        googleMapa.setPolylines(PointLatLng(points[i-1].latitude, points[i-1].longitude),
                        PointLatLng(points[i].latitude, points[i].longitude), false);
                      }
                      googleMapa.setPolylines(PointLatLng(points[points.length-1].latitude, points[points.length-1].longitude),
                      destinationToCoordinates, false);
                    }
                  }
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 42),
                   child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width - 40,
                        child: ListTile(
                      title:
                        Text(
                            origin,
                            style: const TextStyle(fontSize: 14)
                        ),
                          trailing: const Icon(Icons.search),
                          dense: true,
                        )
                    ),
                   ),
              )
                  ),
                )
              ),
              Positioned(
                top: 90,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 23),
                    ),
                    Text(AppLocalizations.of(context).route_destination,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        )
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Positioned(
                  //search input bar
                  top: 105,
                  left: 21,
                  child: SizedBox(
                    width: 358,
                    child: InkWell(
                        onTap: () async {
                          var place = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: googleApikey,
                              mode: Mode.overlay,
                              types: [],
                              strictbounds: false,
                              components: [Component(Component.country, 'es')],
                              //google_map_webservice package
                              onError: (err) {
                                Text(err.toString());
                              });

                            if (place != null) {
                              setState(() {
                              destination = place.description.toString();
                            });

                            //from google_maps_webservice package
                            final plist = GoogleMapsPlaces(
                              apiKey: googleApikey,
                              apiHeaders: await const GoogleApiHeaders().getHeaders(),
                              //from google_api_headers package
                            );
                            String placeid = place.placeId ?? "0";
                            final detail = await plist.getDetailsByPlaceId(placeid);
                            final geometry = detail.result.geometry!;
                            final lat = geometry.location.lat;
                            final lang = geometry.location.lng;
                            var newlatlang = LatLng(lat, lang);
                            destinationToCoordinates = PointLatLng(lat, lang);

                            MapaController().getGoogleMapa().mc.moveCamera(
                                CameraUpdate.newCameraPosition(
                                    CameraPosition(target: newlatlang, zoom: 16)));
                            MapaController()
                                .getGoogleMapa()
                                .setMarker(newlatlang, "destination");

                            if (origin.isNotEmpty) {
                              List<PointLatLng> points = await MapaController().routePainting(originToCoordinates, destinationToCoordinates, DropdownItem().value);

                              GoogleMapaState googleMapa = MapaController().getGoogleMapa();
                              googleMapa.setPolylines(originToCoordinates, PointLatLng(points[0].latitude, points[0].longitude), true);

                              for (int i = 1; i < points.length; ++i) {
                                googleMapa.setPolylines(PointLatLng(points[i-1].latitude, points[i-1].longitude),
                                    PointLatLng(points[i].latitude, points[i].longitude), false);
                              }
                              googleMapa.setPolylines(PointLatLng(points[points.length-1].latitude, points[points.length-1].longitude),
                                  destinationToCoordinates, false);
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 42),
                          child: Card(
                            child: Container(
                                padding: const EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width - 40,
                                child: ListTile(
                                  title: Text(
                                    destination,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  trailing: const Icon(Icons.search),
                                  dense: true,
                                )
                            ),
                          ),
                        )
                    ),
                  )
              ),
            ]
      ),
    ));
  }
}
