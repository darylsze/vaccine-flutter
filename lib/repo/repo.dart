import 'package:flutter_counter/home/remote.dart';
import 'package:flutter_counter/map/entity/CenterInfo.dart';
import 'package:flutter_counter/map/entity/CenterType.dart';
import 'package:flutter_counter/map/entity/ReserveStatus.dart';
import 'package:flutter_counter/extensions.dart';

class RemoteVaccines {
  late String lastUpdateDate;
  late Set<RemoteVaccine> vaccines;

  RemoteVaccines(this.lastUpdateDate, this.vaccines);
}

class RemoteVaccine {
  late String name;
  late Set<RemoteRegion> regions;

  RemoteVaccine(this.name, this.regions);
}

class RemoteRegion {
  late String name;
  late Set<RemoteDistrict> districts;

  RemoteRegion(this.name, this.districts);
}

class RemoteDistrict {
  late String name;
  late Set<RemoteCenter> centers;

  RemoteDistrict(this.name, this.centers);
}

class RemoteCenter {
  late String name;
  late String cname;
  late String sname;
  late String type;
  late Set<RemoteQuota> quotas;

  RemoteCenter(this.name, this.cname, this.sname, this.type, this.quotas);
}

class RemoteQuota {
  late String date;
  late String status;

  RemoteQuota(this.date, this.status);
}

class MyCenter {
  late String vaccine;
  late DateTime lastUpdateAt;
  late DateTime dateTime;
  late String region;
  late String district;
  late Set<ClinicType> types;
  late ReserveStatus status;
  late String name;
  late String address;
  late double lat;
  late double lng;

  MyCenter(this.dateTime, this.region, this.district, this.types, this.status, this.address, this.lat,
      this.lng, this.lastUpdateAt, this.name, this.vaccine);
}

class Repo {
  Future<Set<CenterInfo>> getAllCenterInfos() {
    return Future.delayed(
        Duration(seconds: 0),
        () => {
              CenterInfo("Community Vaccination Centre, Sun Yat Sen Memorial Park Sports Centre", "香港西營盤東邊街北18號", 22.2900426, 114.1435092, ReserveStatus.FULL),
              CenterInfo("Sai Ying Pun Jockey Club General Out-patient Clinic", "香港西營盤皇后大道西134號", 22.3173771, 114.259532, ReserveStatus.AVAILABLE),
              CenterInfo("c", "c", 22.2848009, 114.2236058, ReserveStatus.URGENT),
              CenterInfo("d", "d", 22.3608107, 114.1253342, ReserveStatus.FULL),
            });
  }

  Future<Set<MyCenter>> getAllVaccineInfos() async {
    var data = await Remote().getVaccines();
    // print("data: $data");
    var centerLocationInfos = await getAllCenterInfos();
    // print("centerLocationInfos: $centerLocationInfos");
    Set<MyCenter> centers = {};

    data.vaccines.forEach((vaccine) {
      vaccine.regions.forEach((region) {
        region.districts.forEach((district) {
          district.centers.forEach((center) {
            center.quotas.forEach((quota) {
              var reserveDate = quota.date.parseLiteral();
              // print("reserveDate: $reserveDate");
              var lastUpdateAt = data.lastUpdateDate.parseLiteral();
              // print("lastUpdateAt: $lastUpdateAt");
              // not available
              var status = ReserveStatus.AVAILABLE;
              if (quota.status == "0") {
                status = ReserveStatus.FULL;
              } else if (quota.status == "1") {
                status = ReserveStatus.URGENT;
              } else if (quota.status == "2") {
                status = ReserveStatus.AVAILABLE; // fixme verify
              }
              var clinicType = ClinicType.UNKNOWN;
              if (center.type == "CVV") {
                clinicType = ClinicType.CVV;
              } else if (center.type == "HA") {
                clinicType = ClinicType.HA;
              }
              // print("centerLocationInfos: $centerLocationInfos");
              try {
                var info = centerLocationInfos.firstWhere((centerInfo) =>
                centerInfo.name == center.name);
                print("info: $info");
                if (info != null) {
                  var tmp = MyCenter(
                      reserveDate,
                      region.name,
                      district.name,
                      {clinicType},
                      status,
                      center.cname,
                      info.lat,
                      info.lng,
                      lastUpdateAt,
                      center.name,
                      vaccine.name);
                  centers.add(tmp);
                }
              } catch (e) {

              }
            });
          });
        });
      });
    });
    print("centers: $centers");
    return centers;
  }

}
