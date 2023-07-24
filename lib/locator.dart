import 'package:get_it/get_it.dart';
import 'package:location/location.dart';

import 'device_location/data/data_source/device_location_data_source.dart';
import 'device_location/data/repos/device_location_repo_impl.dart';
import 'device_location/domain/repos/device_location_repo.dart';
import 'device_location/domain/use_cases/get_current_location.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerLazySingleton(() => Location());

  getIt.registerSingleton<DeviceLocationDataSource>(
      DeviceLocationDataSourceImpl(getIt<Location>()));

  getIt.registerSingleton<DeviceLocationRepo>(
      DeviceLocationRepoImpl(getIt<DeviceLocationDataSource>()));

  getIt.registerFactory<GetCurrentLocation>(
      () => GetCurrentLocation(getIt<DeviceLocationRepo>()));
}
