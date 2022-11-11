import 'package:electricity_front/core/controllers/mapaController.dart';
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

class _Google_MapaState extends State<Google_Mapa>{
  late BitmapDescriptor mapMarker;
  final Set<Marker> _markers = {};
  MapaController _mapaController = MapaController();
  late List<LatLng> bicingList;
  late List<LatLng> rcList;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async{
    mapMarker =  await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/images/blue_bike.png');
  }

  void _onMapCreated(GoogleMapController controller) async{
    await _mapaController.bicingApi();
    await _mapaController.rechargeApi();

    bicingList = _mapaController.BicingList;
    rcList = _mapaController.CargaList;

    setState((){
      for(int i = 0; i < bicingList.length; ++i){
        _markers.add(
          Marker(
            markerId: MarkerId("id-" + i.toString()),
            position: bicingList[i],
            icon: mapMarker,
            infoWindow: InfoWindow(
                title: "Estació bicing Pz Catalunya",
                snippet: "Estació bicing de Plaça Catalunya"
            ),
          ),
        );

        _markers.add(
          Marker(
            markerId: MarkerId("id-" + (i+30).toString()),
            position: rcList[i],
            icon: mapMarker,
            infoWindow: InfoWindow(
                title: "Estació rc Pz Catalunya",
                snippet: "Estació rc de Plaça Catalunya"
            ),
          ),
        );
      }
    });

    setState(() {
    });
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
            target: widget. _aux,
            zoom: 16,
          ),
          markers: _markers,
        ),
      ),
    );
  }

}



