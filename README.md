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
creating __model__ -> handle proceesing data in __data_source__ -> bridging result by __repos__ -> impl bussiness logic in use cases -> serve data to Presentation  

#### :syringe: Injecting every aspect (from Data Source until Use Cases)