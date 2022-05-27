

import 'package:geolocator/geolocator.dart';

abstract class BaseGeolocation {
  Future<Position?> getCurrentLocation()async{}
}