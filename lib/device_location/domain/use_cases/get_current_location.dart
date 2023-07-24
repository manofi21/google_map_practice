import 'package:google_map_practice/core/errors/failure.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/result_handler/no_params.dart';
import '../../../core/result_handler/result.dart';
import '../../../core/use_cases/future_result_use_case.dart';
import '../repos/device_location_repo.dart';

class GetCurrentLocation extends FutureResultUseCase<LatLng, NoParams> {
  final DeviceLocationRepo deviceLocationRepo;
  GetCurrentLocation(this.deviceLocationRepo);

  @override
  Future<Result<LatLng, Failure>> processCall(NoParams params) async {
    try {
      final location = await deviceLocationRepo.currentLatLngLocation();
      return Ok(location);
    } on UnknownFailure catch (failure) {
      return Err(failure);
    } on DeviceLocationRepoFailure catch (failure) {
      return Err(failure);
    } catch (err) {
      return Err(UnknownFailure('Cause in [GetCurrentLocation] : ${err.toString()}'));
    }
  }
}
