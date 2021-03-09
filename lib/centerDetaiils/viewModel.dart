import 'package:flutter_counter/extensions.dart';
import 'package:flutter_counter/home/remote.dart';
import 'package:flutter_counter/home/remote_vaccines_entity.dart';

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
  late String address;
  late double lat;
  late double lng;
  Set<CenterDetailsVaccineTypeModel> vaccineType = {};

  CenterDetailsModel(
      {required this.lastUpdateAt,
      required this.cName,
      required this.address,
      required this.lat,
      required this.lng,
      required this.vaccineType});
}

class CenterDetailsViewModel {
  Future<CenterDetailsModel> getCenterDetailsFromAddress({required String cName}) async {
    var geolocation = await Remote().getAllCenterLocationInfos();
    var allVaccinesInfos = await Remote().getVaccines();

    DateTime _lastUpdateAt = allVaccinesInfos.lastUpdDate.parseDateTimeLiteral();
    Set<CenterDetailsVaccineTypeModel> _supportedVaccine = {};
    double _lat = 0.0;
    double _lng = 0.0;
    String _address = "";

    print("after api respnose");

    allVaccinesInfos.vaccines.forEach((vaccine) {
      vaccine.regions.forEach((region) {
        region.districts.forEach((district) {
          district.centers.forEach((RemoteCenter center) {
            if (center.cname == cName) {
              _supportedVaccine.add(CenterDetailsVaccineTypeModel(name: vaccine.name));
            }
            var geoLocation = geolocation.firstWhere((element) => element.cName == cName);
            _lat = geoLocation.lat;
            _lng = geoLocation.lng;
            _address = geoLocation.address;
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

    var result = CenterDetailsModel(
        cName: cName,
        address: _address,
        lat: _lat,
        lng: _lng,
        vaccineType: _supportedVaccine,
        lastUpdateAt: _lastUpdateAt);
    print("getCenterDetailsFromAddress: $result");
    return result;
  }
}
