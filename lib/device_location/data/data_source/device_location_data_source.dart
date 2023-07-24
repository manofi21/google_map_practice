import 'package:flutter/services.dart';
import 'package:google_map_practice/core/errors/exceptions.dart';
import 'package:google_map_practice/device_location/data/model/lat_lng_model.dart';
import 'package:location/location.dart';

abstract class DeviceLocationDataSource {
  Future<LatLngModel> getCurrentLatLngLocation();
}

class DeviceLocationDataSourceImpl implements DeviceLocationDataSource {
  DeviceLocationDataSourceImpl(this.location);
  final Location location;

  @override
  Future<LatLngModel> getCurrentLatLngLocation() async {
    try {
      final isEnable = await location.serviceEnabled();
      if (!isEnable) {
        // Just throw String so that the catch would throw as [DeviceLocationRepoException]
        throw 'Look like the GPS off. Make sure the GPS is Online';
      }

      final getCurrentLoc = await location.getLocation();
      final targetLat = getCurrentLoc.latitude ?? 0;
      final targetLong = getCurrentLoc.longitude ?? 0;
      return LatLngModel(latitude: targetLat, longitude: targetLong);
    } catch (e) {
      if (e is PlatformException) {
        throw DeviceLocationRepoException(e.message ?? e.details);
      }
      throw DeviceLocationRepoException(e.toString());
    }
  }
}