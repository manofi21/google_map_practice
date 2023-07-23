import 'package:google_map_practice/core/errors/failure.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/errors/exceptions.dart';
import '../../domain/repos/device_location_repo.dart';
import '../data_source/device_location_data_source.dart';

class DeviceLocationRepoImpl implements DeviceLocationRepo {
  final DeviceLocationDataSource deviceLocationDataSource;
  DeviceLocationRepoImpl(this.deviceLocationDataSource);

  @override
  Future<LatLng> currentLatLngLocation() async {
    try {
      final currentLocation =
          await deviceLocationDataSource.getCurrentLatLngLocation();
      final latitude = currentLocation.latitude;
      final longitude = currentLocation.longitude;
      return LatLng(latitude, longitude); 
    } on DeviceLocationRepoException catch (e) {
      throw UnknownFailure('Cause in [DeviceLocationDataSourceImpl] : ${e.message}');
    } catch (e) {
      throw DeviceLocationRepoFailure('Cause in [DeviceLocationRepoImpl] : ${e.toString()}');
    }
  }
}
