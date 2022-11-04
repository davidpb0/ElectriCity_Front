import 'package:electricity_front/core/controllers/mapaController.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Google_Mapa extends StatefulWidget {
  @override
  _Google_MapaState createState() => _Google_MapaState();

  Google_Mapa({Key? key}) :super(key: key);

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(41.3870154, 2.1700471);
}

class _Google_MapaState extends State<Google_Mapa>{
  late BitmapDescriptor mapMarker;
  final Set<Marker> _markers = {};
  MapaController _mapaController = MapaController();

  @override
  void initState() {
    super.initState();
    setCustomMarker();
    _mapaController.bicingAPi();
  }

  void setCustomMarker() async{
    mapMarker =  await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/images/blue_bike.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    List<LatLng> lista = [
      LatLng(41.3870154, 2.1700471),
      LatLng(41.3880154, 2.1700471),    ];



    setState((){
      for(int i = 0; i < lista.length; ++i){
        _markers.add(
          Marker(
            markerId: MarkerId("id-" + i.toString()),
            position: lista[i],
            icon: mapMarker,
            infoWindow: InfoWindow(
                title: "Estació bicing Pz Catalunya",
                snippet: "Estació bicing de Plaça Catalunya"
            ),
          ),
        );
      }
    });

    setState(() {
    });
  }


   List<LatLng>? bicingStations(){
    return _mapaController.markersBicing();
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
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        ),
        backgroundColor: Colors.green,
        elevation: 20,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: SizedBox(),
        ),

      ),

      body: Container(
        child: GoogleMap(
          onMapCreated:_onMapCreated ,
          initialCameraPosition: CameraPosition(
            target: widget._center,
            zoom: 16,
          ),
          markers: _markers,
        ),
      ),
    );
  }

}



