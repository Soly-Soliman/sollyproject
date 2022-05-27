

import 'package:geolocator/geolocator.dart';
import 'package:graduation_1/providers/baseGeolocation.dart';

class GeolocationRepository extends BaseGeolocation{

  @override
  Future<Position> getCurrentlocation()async{
    return await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high ) ;

  }


}