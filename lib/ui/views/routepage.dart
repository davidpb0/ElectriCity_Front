import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: PreferredSize( //wrap with PreferredSize
            preferredSize: Size.fromHeight(7), //height of appbar
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.green,
            )
        ),
        body: Body()
    );
  }
}

class Body extends StatelessWidget {

  String googleApikey = "GOOGLE_MAP_API_KAY";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String origin = "Search Origin";
  String destination = "Search Destination";

  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: const BorderSide(color: Color(0xff01d277)));

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    /// Username field
    return SizedBox(
      child: Container (
          padding: const EdgeInsets.only(
            left: 50,
            right: 50
          ),
          height: MediaQuery.of(context).size.height*0.2,
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(36),
                  bottomLeft: Radius.circular(36)
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 10,
                ),
              ]
          ),
        child: Column(
          children: <Widget> [

            Row(
              children: const [
                SizedBox(
                    width: 7
                ),

                Text(
                    "Origin",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    )
                ),
              ],
            ),

            Positioned(  //search input bar
              top:10,
              child: InkWell(
                  onTap: () async {
                    /*var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: googleApikey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [Component(Component.country, 'np')],
                        //google_map_webservice package
                        onError: (err){
                          print(err);
                        }
                    );

                    if(place != null){
                      setState(() {
                        location = place.description.toString();
                      });

                      //form google_maps_webservice package
                      final plist = GoogleMapsPlaces(apiKey:googleApikey,
                        apiHeaders: await GoogleApiHeaders().getHeaders(),
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
                    }*/
                  },
                  child:Padding(
                    padding: EdgeInsets.all(4),
                    child: Card(
                      child: Container(
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            title:Text(origin, style: TextStyle(fontSize: 14),),
                            trailing: Icon(Icons.search),
                            dense: true,
                          )
                      ),
                    ),
                  )
              )
            ),

            Row(
              children: const [
                SizedBox(
                    width: 8
                ),

                Text(
                    "Destination",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    )
                ),
              ],
            ),

            Positioned(  //search input bar
                top:10,
                child: InkWell(
                    onTap: () async {
                      /*var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: googleApikey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [Component(Component.country, 'np')],
                        //google_map_webservice package
                        onError: (err){
                          print(err);
                        }
                    );

                    if(place != null){
                      setState(() {
                        location = place.description.toString();
                      });

                      //form google_maps_webservice package
                      final plist = GoogleMapsPlaces(apiKey:googleApikey,
                        apiHeaders: await GoogleApiHeaders().getHeaders(),
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
                    }*/
                    },
                    child:Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0,
                          right: 0.0,
                          top: 0.0,
                          bottom: 0.0
                      ),
                      child: Card(
                        child: Container(
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width - 40,
                            child: ListTile(
                              title:Text(destination, style: TextStyle(fontSize: 14),),
                              trailing: Icon(Icons.search),
                              dense: true,
                            )
                        ),
                      ),
                    )
                )
            ),
          ],
        ),
      )
    );
  }
}
