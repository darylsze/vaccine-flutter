import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_hk/extensions.dart';
import 'package:vaccine_hk/data/remote/index.dart';
import 'package:vaccine_hk/data/remote/remote_vaccines_entity.dart';

// class CenterDetailsQuotaModel {
//   late DateTime date;
//   late ReserveStatus status;
//
//   CenterDetailsQuotaModel({ required this.date, required this.status });
// }

class CenterDetailsVaccineTypeModel {
  late String name;

  // Set<CenterDetailsQuotaModel> quotas = {};

  CenterDetailsVaccineTypeModel({required this.name //, required this.quotas
  });
}

class CenterDetailsModel {
  late DateTime lastUpdateAt;
  late String cName;
  late String engName;
  late String address;
  late double lat;
  late double lng;
  Set<CenterDetailsVaccineTypeModel> vaccineType = {};
  late bool hasSubscribed = false;

  CenterDetailsModel({required this.lastUpdateAt,
    required this.cName,
    required this.engName,
    required this.address,
    required this.lat,
    required this.lng,
    required this.vaccineType,
    required this.hasSubscribed
  });
}

class CenterDetailsViewModel {
  Future<CenterDetailsModel> getCenterDetailsFromName({required String cName}) async {
    var geolocation = await Remote().getAllCenterLocationInfos();
    var allVaccinesInfos = await Remote().getVaccines();

    DateTime _lastUpdateAt = allVaccinesInfos.lastUpdDate.parseDateTimeLiteral();
    Set<CenterDetailsVaccineTypeModel> _supportedVaccine = {};
    double _lat = 0.0;
    double _lng = 0.0;
    String _address = "";
    String _engName = "";
    bool _hasGroupSubscribed = false;

    print("after api respnose");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> subscribedGroups = prefs.getStringList("centerNames") ?? [];

    RemoteCenter? matchesCenter = null;


    allVaccinesInfos.vaccines.forEach((vaccine) {
      vaccine.regions.forEach((region) {
        region.districts.forEach((district) {
          district.centers.forEach((RemoteCenter center) {
            if (center.cname == cName) {
              matchesCenter = center;
              _supportedVaccine.add(CenterDetailsVaccineTypeModel(name: vaccine.name));
            }
            // center.quota.forEach((RemoteQuota quota) {
            //   ReserveStatus status = ReserveStatus.AVAILABLE;
            //   if (quota.status == "0") {
            //     status = ReserveStatus.FULL;
            //   } else if (quota.status == "1") {
            //     status = ReserveStatus.URGENT;
            //   } else if (quota.status == "2") {
            //     status = ReserveStatus.AVAILABLE; // fixme verify
            //   }
            // });
          });
        });
      });
    });

    if (matchesCenter != null) {
      var geoLocation = geolocation.firstWhere((element) => element.cName == cName);
      _lat = geoLocation.lat;
      _lng = geoLocation.lng;
      _address = geoLocation.address;
      _engName = matchesCenter!.engName;
      _hasGroupSubscribed = subscribedGroups.any((element) {
        print("comparing element: $element with ${_engName.urlEncode()}");
        return element == _engName.urlEncode();
      });
      print("_hasGroupSubscribed: $_hasGroupSubscribed");
    }

    var result = CenterDetailsModel(
        cName: cName,
        engName: _engName,
        address: _address,
        lat: _lat,
        lng: _lng,
        vaccineType: _supportedVaccine,
        lastUpdateAt: _lastUpdateAt,
        hasSubscribed: _hasGroupSubscribed
    );
    print("getCenterDetailsFromAddress: $result");
    return result;
  }

  Future<bool> subscribeToCenter(CenterDetailsModel center) async {
    // accept permission
    var settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String encodedName = center.engName.urlEncode();
      await FirebaseMessaging.instance.subscribeToTopic(encodedName);
      print("subscribed to ${center.cName} (actual: ${encodedName})");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> subscribedCenters = prefs.getStringList("centerNames") ?? [];
      subscribedCenters.add(encodedName);
      prefs.setStringList("centerNames", subscribedCenters);
      return true;
    }
    return false;
  }

  Future<bool> unsubscribeToCenter(CenterDetailsModel center) async {
    // accept permission
    var settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String encodedName = center.engName.urlEncode();
      await FirebaseMessaging.instance.subscribeToTopic(encodedName);
      print("unsubscribed to ${center.cName} (actual: ${encodedName})");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> subscribedCenters = prefs.getStringList("centerNames") ?? [];
      subscribedCenters.removeWhere((element) => element == encodedName);
      prefs.setStringList("centerNames", subscribedCenters);
      return true;
    }
    return false;
  }
}
