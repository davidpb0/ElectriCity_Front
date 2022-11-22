import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class RoutePage extends StatefulWidget implements PreferredSizeWidget {

  RoutePage({Key? key, required this.height}): preferredSize = Size.fromHeight(height), super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();

  @override
  final Size preferredSize;
  final double height;
}

class _RoutePageState extends State<RoutePage> {
  @override
  String googleApikey = "AIzaSyCDg_4vAv_MQQyRHTc94dBLngBqqmdO3ZM";
  GoogleMapController? mapController; //controller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(27.6602292, 85.308027);
  String origin = "Search Origin";
  String destination = "Search Destination";

  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: const BorderSide(color: Color(0xff01d277))
  );

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 27),
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
              ]
          ),
          child: Stack(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    padding: const EdgeInsets.all(2.0),
                    child: const Text('ElectriCity', style: TextStyle(color: Colors.white),)),
                Image.asset(
                  'assets/images/title_logo_car.png',
                  fit: BoxFit.contain,
                  height: 20,
                ),
              ]),
              Positioned(
                top: 15,
                child: Row(
                  children: const [
                    SizedBox(width: 7),
                    Text("Origin",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        )
                    ),
                  ],
                ),
              ),
              Positioned(
                //search input bar
                  top: 25,
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
                              print(err);
                            }
                        );

                        if(place != null) {
                          setState(() {
                            origin = place.description.toString();
                          });

                          //form google_maps_webservice package
                          final plist = GoogleMapsPlaces(apiKey:googleApikey,
                            apiHeaders: await const GoogleApiHeaders().getHeaders(),
                            //from google_api_headers package
                          );

                          String placeid = place.placeId ?? "0";
                          final detail = await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                          final lat = geometry.location.lat;
                          final lang = geometry.location.lng;
                          var newlatlang = LatLng(lat, lang);

                          //move map camera to selected place with animation
                          mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Card(
                          child: Container(
                              padding: const EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width - 40,
                              child: ListTile(
                                title: Text(
                                  origin,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                trailing: const Icon(Icons.search),
                                dense: true,
                              )
                          ),
                        ),
                      )
                  )
              ),
              Positioned(
                top: 90,
                child: Row(
                  children: const [
                    SizedBox(width: 7),
                    Text("Destination",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        )
                    ),
                  ],
                ),
              ),
              Positioned(
                //search input bar
                  top: 105,
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
                            onError: (err){
                              print(err);
                            }
                        );

                        if(place != null){
                          setState(() {
                            destination = place.description.toString();
                          });

                          //form google_maps_webservice package
                          final plist = GoogleMapsPlaces(apiKey:googleApikey,
                            apiHeaders: await const GoogleApiHeaders().getHeaders(),
                            //from google_api_headers package
                          );
                          String placeid = place.placeId ?? "0";
                          final detail = await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                          final lat = geometry.location.lat;
                          final lang = geometry.location.lng;
                          var newlatlang = LatLng(lat, lang);

                          //move map camera to selected place with animation
                          mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
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
                  )
              ),
            ],
          ),
        ));
  }
}
