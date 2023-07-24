# Google Maps in Flutter
This project would be contain of to implement Google Map in Flutter. 

## :beginner: Project Permission Preparation
1. Adding packages in pubspec.yaml
```yaml
  google_maps_flutter: ^2.2.1
  location: ^4.4.0
```

2. Move to `android\app\build.gradle` and edit some line:
`   compileSdkVersion 33`
`   targetSdkVersion 33`

3. Adding this line under flutterEmbedding in file `android\app\src\main\AndroidManifest.xml`:
```xml
    <meta-data android:name="com.google.android.geo.API_KEY"
        android:value="API_KEY"/>
```
And permission:
```xml
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
```

## :key: Getting API Key from Google Console
1. For get geo's API Key:

a. Open (Google Console)(https://console.cloud.google.com/welcome/new?project=dependable-star-393506)
![image](https://user-images.githubusercontent.com/54527045/255093730-981b5bff-455a-41a5-97e8-32315803960c.png)

b. Scroll to Products and choose Access services.
![image](https://user-images.githubusercontent.com/54527045/255093913-b3980640-8d40-4039-8d1c-c9f550eaf432.png)

c. After that choose Maps SDK for Android.
(If the option not found, choose Map from category or search in search bar)
![image](https://user-images.githubusercontent.com/54527045/255094313-1a587052-5a63-4d2d-9309-0d4a666f10cf.png)

d. After the page opened, click enable.
![image](https://user-images.githubusercontent.com/54527045/255095772-9d6ff9a1-d78a-4963-a36d-db34a5aeb329.png)

e. Wait until the API-key pop up show up, Copy the API key so paste in AndroidManifest.xml.
![image](https://user-images.githubusercontent.com/54527045/255096244-45b827c8-0208-4aa8-9716-6ced366f59f8.png)

2. Give restricted option:

a. From Landing page, open your project by click your project name:
(can choose by click 'You're working on project (Project name)' <!-- or choose the side of Google Cloud logo  -->)

![image](https://user-images.githubusercontent.com/54527045/255099715-529decbc-b756-4129-a0dc-e554c2ce0fd3.png)

b. in dashboard page scroll until find __Explore and enable APIs__

![image](https://user-images.githubusercontent.com/54527045/255101015-99f09ccf-0a92-46ff-b87d-75b82fa52ad0.png)

c. after choose and waiting the page open, choose Credentials

![image](https://user-images.githubusercontent.com/54527045/255101556-28ef5b7d-0b1d-415c-b095-523e84829292.png)

d. click the 3 buttons's point and choose `Edit API key`

![image](https://user-images.githubusercontent.com/54527045/255101877-486c8a79-1c5c-48ae-ad90-90d1c5ac3490.png)

e. in Option of _set an application restriction_ choose Android apps: and click ADD

![image](https://user-images.githubusercontent.com/54527045/255102865-6882669f-e7c0-44d2-ab46-4e4aa8f47b79.png)

f. fill the form by:
f.1 Packages name can be find in AndroidManifest.xml:
```xml
<!-- Copy the value of packages -->
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.google_map_practice"> 
```
f.2 SHA-1 certificate and be find by running this comment:
```shell
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```
or this comment:
```shell
keytool -list -v -keystore c:\Users\"user-name"\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
```
After that, click save.

## :construction: Adding Errors, Result handler, and use cases 
1. Adding structure folder like this:
- lib
  - core
    - errors
    - result_handler
    - use_cases

2. in errors's folder would contain this file.
- exceptions.dart : would contain class that implements by `Exception` class to handling exception/try-catch in source data.
ex:
```dart
class DeviceLocationRepoException implements Exception {
  final String message;
  DeviceLocationRepoException(this.message);
}
```
- failure.dart : would contain class that extends by `Failure` class to handling exception/try-catch in Repository or Use Cases.
ex:
```dart
class DeviceLocationRepoFailure extends Failure {
  const DeviceLocationRepoFailure(String message) : super(message);
}
```

3. in result_handler's folder this file.
- no_params.dart: would containt class without params. (Would be use in use cases). Adding packages `equatable` in `pubspec.yaml`.
- option.dart: abstract class for handle use cases's object without return
- result.dart: abstract class for handle use cases's object with return

For option.dart & result.dart would need following step to generate files of freezed:
a. in `pubspec.yaml` adding the following packages: 
- `freezed_annotation: ^2.2.0`
- `freezed: ^2.3.2` (in dev_dependencies)
- `build_runner: ^2.3.3` (in dev_dependencies)

b after adding the packages, run this comment:
```shell
flutter pub run build_runner build
```
This following step would generate file type `.freezed.dart`. Or would be called sealed union object.

4. in use_cases's folder would be contain this file:
- future_result_use_case.dart: this file would contian abstract class that be used for implementing use cases from repository.

## :fried_egg: Handling the feature by using Repo, model, and Use Cases
![Clean-Architecture-Flutter-Diagram](https://user-images.githubusercontent.com/54527045/255397743-36ed7e89-36b6-4542-a129-6f14f56683c2.jpg)

(img sorce: Reso coder)

From this diagram, the folder's feature would be handle like Data, Domain and Presentation. 

One of another feature that can be use as Example is Device location.
The folder's structure would be like this:
- device_location
  - data
    - data_source
    - model
    - repos
  - domain
    - repos
    - use_cases
    - entites (not in use because not find requiredment)
  - presentation (keep for laters)

#### :file_folder: Explanation of folder sturcture and impl according device location's case
This short explanation of folder or what kind files that can be filled in the folders.
1. Data
The folder consist for process data from API or Local. This folder responsible to handing activity get, put, post, or delete. 

The folder usualy contain:

   __a. data_source__: containt class of accessing data (either from API or Local) and converting value to class in folder _Model_ 

   __b. model__: containt class that be used for convert cached data in __data_source__ folder

   __c. repos__: containt implemented class repos from folder repos in domain's folder. The repos would be a bridge of __data__ and __domain__. So the implementation of repos in folder __data__, and the abstract class of the __repos__ in __domain__.

2. domain
The folder consist for process data from __data_source__ to use cases. This folder focus to handling bbusiness logic like handling error, change model to entities, and so on.

The folder usualy contain:

  __a. entites__: containt class that be used for convert Model in repos folder

  __b. repos__: containt abstract class for repos folder in folder data

  __c. use_cases__: containt use cases that handle bussiness logic in that be used in presentation later

#### :memo: Writing code base of folder's structure
The step of writing the code start from:
creating __model__ -> handle proccesing data in __data_source__ -> bridging result by __repos__ -> impl bussiness logic in __use_cases__ -> serve data to Presentation  

1. creating __model__
After determine value from data source, set in one model. For developer's convenience, usually the models containt the following functions:
- `toJson`(not used in this case): for convert model back to data source. Usualy for create/update
- `fromJson`(not used in this case): for convert data source to model. Usualy for fetch data
file location: `lib\device_location\data\model\lat_lng_model.dart`
```dart
class LatLngModel {
  final double latitude;
  final double longitude;
  
  const LatLngModel({
    required this.latitude,
    required this.longitude,
  });
}
```

2. handle proccesing data in __data_source__
When the model complete, create function using the model for proccessing data. For ex:
If the function of proccesing data for fetching, return the function to the Model.
`Future<LatLngModel> getCurrentLatLngLocation();`
For in case, make sure for use __*try-catch*__. The would help some Unexpected error in future like error from updating type in data source, the changes of data accessing permission's process, and so on.

file location: `lib\device_location\data\data_source\device_location_data_source.dart`
```dart
Future<LatLngModel> getCurrentLatLngLocation() async {
  try {
    final isEnable = await location.serviceEnabled();
    if (!isEnable) {
      // Just throw String so that 
      // the catch would throw as [DeviceLocationRepoException]
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
```

3. bridging result by __repos__
Because the repos is bridging for data to domain, make sure the repos in two folder where abstract class in domain, and the impl in data. 

In inside repos impl, usualy for change model to entites. So that the data would be serve to presentation from use cases.

abstract location:`lib\device_location\domain\repos\device_location_repo.dart`
```dart
abstract class DeviceLocationRepo {
  Future<LatLng> currentLatLngLocation();
}
```

impl location:`lib\device_location\data\repos\device_location_repo.dart`
```dart
Future<LatLng> currentLatLngLocation() async {
  ....
}
```

make sure for using __*try-catch*__ like in source data but the thow would return Faiure rather than exception. The source data already throw Exception and just return `instead of 'Exception'` if just throw along inside __*catch*__. So, for handle the Execption must catch the previouse Exception from source data using _on_ keyword in between _try_ and _catch_.
```dart
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
```

4. impl bussiness logic in __use_cases__
By using `FutureResultUseCase` for create use cases class, the result that would be serve to UI only entities, and Failure. Some validation like wrong validation, or empty parameter from user can be set in here. The use case can receive parameter or no params at all.
```dart
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
```

5. Serving TIME!
then call the use cases allowing in controller, state management, or UI instead(but prefer inside state management for best practice).

```dart
  final getCases = GetCurrentLocation(DeviceLocationRepoImpl(
    DeviceLocationDataSourceImpl(
      Location(),
    ),
  ));

  final value = await getCases(NoParams());
  value.when(ok: (ok) {
    /// For serving data
  }, err: (err) {
    /// For show error
  });
```
But rather than call the use cases by unite all component in parameter in one file, using dependency injection would make easier 

#### :syringe: Injecting every aspect (from Data Source until Use Cases)
1. Adding `get_it` packages in `pubspect.yaml`.

2. create locator.dart files and registering the compnent like:
- Locator
- DeviceLocationDataSource
- DeviceLocationRepo
- GetCurrentLocation

```dart
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
```

3. set the `setup` function in main.dart so that the registering could come first before run the UI.
```dart
void main() {
  setup();
  runApp(const MyApp());
}
```

now for call the use cases of `GetCurrentLocation` just like this:
```dart
final getCurrentLocCase = getIt<GetCurrentLocation>();
final value = await getCurrentLocCase(NoParams());
value.when(ok: (ok) {
  /// For serving data
}, err: (err) {
  /// For show error
});
```