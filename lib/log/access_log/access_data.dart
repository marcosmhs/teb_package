import 'package:ipapi/models/geo_data.dart';
import 'package:teb_package/teb_package.dart';

class AccessData {
  late String id;
  late DateTime dateTime;
  // AS number and organization, separated by space (RIR). Empty for IP blocks not being announced in BGP tables
  late String? asNumberAndOrganization; // asno
  late String? cityName; // city
  late String? stateCode; // region
  late String? stateName; // regionName
  late String? countryName; // country
  late String? countryCode;
  // internet service provider
  late String? providerName; // isp
  // Organization name
  late String? oganizationName; // org
  late double? latitude; // lat
  late double? longitude; // long
  late String? ipAdress; // query
  late String? timezone;
  late bool mobile;
  late double? screenWidth;
  late double? screenHeight;

  AccessData({
    required this.id,
    required this.dateTime,
    this.asNumberAndOrganization,
    this.cityName,
    this.stateCode,
    this.stateName,
    this.countryName,
    this.countryCode,
    this.providerName,
    this.oganizationName,
    this.latitude,
    this.longitude,
    this.ipAdress,
    this.timezone,
    this.mobile = false,
    this.screenWidth,
    this.screenHeight,
  });

  static AccessData getAccessDataFromGeoData(GeoData geoData) {
    return AccessData(
      id: TebUidGenerator.accessLogUid,
      dateTime: DateTime.now(),
      asNumberAndOrganization: geoData.asno,
      cityName: geoData.city,
      stateCode: geoData.region,
      stateName: geoData.regionName,
      countryName: geoData.country,
      countryCode: geoData.countryCode,
      providerName: geoData.isp,
      oganizationName: geoData.org,
      latitude: geoData.lat,
      longitude: geoData.lon,
      ipAdress: geoData.query,
      timezone: geoData.timezone,
      mobile: geoData.mobile ?? false,
    );
  }

  Map<String, dynamic> get toMap {
    Map<String, dynamic> r = {};
    r = {
      'id': id,
      'dateTime': dateTime.toString(),
      'asNumberAndOrganization': asNumberAndOrganization,
      'cityName': cityName,
      'stateCode': stateCode,
      'stateName': stateName,
      'countryName': countryName,
      'countryCode': countryCode,
      'providerName': providerName,
      'oganizationName': oganizationName,
      'latitude': latitude,
      'longitude': longitude,
      'ipAdress': ipAdress,
      'timezone': timezone,
      'mobile': mobile,
      'screenWidth': screenWidth,
      'screenHeight': screenHeight,
    };

    return r;
  }
}
