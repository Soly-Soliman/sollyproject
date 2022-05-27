import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier{
  late Location _location ;
  Location get location => _location ;
  late LatLng _locationPostion ;
  LatLng get locationPosition =>_locationPostion;
  bool locationServiceActive = true ;

  LocationProvider(){
    _location = new Location();
  }

  initalization(){

  }
  getUserLocation()async{
    bool _serviseEnable ;
    PermissionStatus _permissionGranted;

    _serviseEnable = await location.serviceEnabled();
    if(!_serviseEnable){
      _serviseEnable =await location.requestService() ;

      if (!_serviseEnable){
        return;
      }
    }
    _permissionGranted =await location.hasPermission();
    if(_permissionGranted ==PermissionStatus.denied){
      _permissionGranted =await location.requestPermission();
      if(_permissionGranted!=PermissionStatus.granted){
        return ;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      //_locationPostion =LatLng(currentLocation.latitude, currentLocation.longitude) ;
      print(_locationPostion);
      notifyListeners();

    });
  }
}

