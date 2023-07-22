# Google Maps in Flutter

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
        android:value="AIzaSyBA_N4obTKm34xlQiOnb7tF14aE8ABcufU"/>
```
And permission:
```xml
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
```

4. For get geo's API Key:
a. Open (Google Console)(https://console.cloud.google.com/welcome/new?project=dependable-star-393506)
![image](https://user-images.githubusercontent.com/54527045/255093730-981b5bff-455a-41a5-97e8-32315803960c.png)
b. Scroll to Products and choose Access services.
![image](https://user-images.githubusercontent.com/54527045/255093913-b3980640-8d40-4039-8d1c-c9f550eaf432.png)
c. After that choose Maps SDK for Android.
(If the option not found, choose Map from category or search in search bar)
![image](https://user-images.githubusercontent.com/54527045/255094313-1a587052-5a63-4d2d-9309-0d4a666f10cf.png)
d. After the page opened, click enable.
![image](https://user-images.githubusercontent.com/54527045/255095772-9d6ff9a1-d78a-4963-a36d-db34a5aeb329.png)
e. Wait until the API-key pop up show up
![image](https://user-images.githubusercontent.com/54527045/255096244-45b827c8-0208-4aa8-9716-6ced366f59f8.png)

5. Give restricted option:
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