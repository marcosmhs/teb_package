import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ipapi/api.dart';
import 'package:teb_package/log/access_log/access_data.dart';
import 'package:teb_package/log/access_log/access_log_plataform_info.dart';

enum DeviceType { mobile, desktop, none }

class DeviceLogController {
  final FirebaseFirestore fireStoreInstance;

  final _accessLogCollectionName = 'mainSiteAccessLog';

  DeviceLogController({required this.fireStoreInstance});

  void registerAccess() {
    IpApi.getData().then((geoData) {
      if (geoData != null) {
        var accessData = AccessData.getAccessDataFromGeoData(geoData);

        fireStoreInstance.collection(_accessLogCollectionName).doc(accessData.id).set(accessData.toMap);
      }
    });
  }

  Map<String, dynamic> get getDeviceInfo {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceInfoPlugin.webBrowserInfo.then((value) => deviceData = AccessLogPlataformInfo.readWebBrowserInfo(value));
      } else {
        if (defaultTargetPlatform == TargetPlatform.android) {}
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            deviceInfoPlugin.androidInfo.then((value) => deviceData = AccessLogPlataformInfo.readAndroidBuildData(value));
            break;
          case TargetPlatform.iOS:
            deviceInfoPlugin.iosInfo.then((value) => deviceData = AccessLogPlataformInfo.readIosDeviceInfo(value));
            break;
          case TargetPlatform.linux:
            deviceInfoPlugin.linuxInfo.then((value) => deviceData = AccessLogPlataformInfo.readLinuxDeviceInfo(value));
            break;
          case TargetPlatform.windows:
            deviceInfoPlugin.windowsInfo.then((value) => deviceData = AccessLogPlataformInfo.readWindowsDeviceInfo(value));
            break;
          case TargetPlatform.macOS:
            deviceInfoPlugin.macOsInfo.then((value) => deviceData = AccessLogPlataformInfo.readMacOsDeviceInfo(value));
            break;
          default:
        }
      }
      return deviceData;
    } on PlatformException {
      return <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }
  }
}
