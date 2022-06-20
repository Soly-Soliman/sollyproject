
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_1/Utils/colors.dart';

class GoogleMapPage extends StatefulWidget
{
  @override
  _GoogleMapPageState createState()=>_GoogleMapPageState();
  
}

class _GoogleMapPageState extends State<GoogleMapPage>{
  late GoogleMapController mapContoller ;
  late String searchAdrdress;
  TextEditingController _textEditingController =TextEditingController() ;

  
  static final Marker _Kgoogleplexmarker =
  Marker(
      markerId: MarkerId('_kgoogleplex'),
    infoWindow: InfoWindow(
      title: 'current position' ,
    ),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(30.039234, 31.224565),
  );
  static final Marker _Klategoogleplexmarker =
  Marker(
    markerId: MarkerId('_knextgoogleplex'),
    infoWindow: InfoWindow(
      title: 'to the next ...' ,
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    position: LatLng(30.035578, 31.198585),
  );
  static final Polyline _kpolyline =
  Polyline(
    polylineId: PolylineId('kpolyline'),
    points:
    [
      LatLng(30.035578, 31.198585),
      LatLng(30.039234, 31.224565),
    ]
  );
  @override

  Widget build (BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title: Text('Google Maps'),
        centerTitle: true,
        backgroundColor: selection,
        foregroundColor: black,
      ),
      body: SafeArea(
        child: Stack(
          children:[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target:
                LatLng(30.039234, 31.224565),
                zoom: 10,),
              markers: {_Kgoogleplexmarker ,_Klategoogleplexmarker},
              polylines: {_kpolyline},
              mapType:  MapType.normal,
              onMapCreated: onmapcreated,
            ),
            Positioned(
              top: 30,
              right: 10,
              left: 15,
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Address...' ,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15,top: 5),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search_rounded),
                      onPressed: (){},
                      iconSize: 30.0,
                    )
                  ),
                  onChanged: (val){
                    setState(() {
                      searchAdrdress =val ;
                    });
                  },
                ),

            ),) ,
            Positioned(
              top: 600,
              right: 10,
              left: 15,
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextButton(
                      child: Text(
                          "Save".toUpperCase(),
                          style: TextStyle(fontSize: 14)
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                              //    side: BorderSide(color: Colors.red)
                              )
                          )
                      ),
                      onPressed: () => null
                  ),
                ),

              ),)

          ] ,
        ),
      ),
    );
  }
  searchandnavigate (){
  }
  void onmapcreated(contoller){
    setState(() {
      mapContoller =contoller ;
    });
  }
}