import 'package:vaccine_hk/data/entities.dart';
import 'package:vaccine_hk/data/remote/index.dart';
import 'package:vaccine_hk/extensions.dart';
import 'package:vaccine_hk/presentation/centerList/remote_vaccines_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repo.g.dart';

@JsonSerializable()
class MyCenter {
  late String vaccine;
  late DateTime dateTime;
  late String region;
  late String district;
  late String address;
  late Set<ClinicType> types;
  late ReserveStatus status;
  late String cName;
  late String engName;
  late double lat;
  late double lng;

  MyCenter(
      {required this.address,
      required this.dateTime,
      required this.region,
      required this.district,
      required this.types,
      required this.status,
      required this.engName,
      required this.lat,
      required this.lng,
      required this.cName,
      required this.vaccine});

  Map<String, dynamic> toJson() => _$MyCenterToJson(this);
}

class Repo {
  Future<Set<CenterInfo>> getAllCenterInfos() async {
    return await Remote().getAllCenterLocationInfos();
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
          district.centers.forEach((RemoteCenter center) {
            center.quota.forEach((RemoteQuota quota) {
              var reserveDate = quota.date.parseDateLiteral();
              // print("reserveDate: $reserveDate");
              var lastUpdateAt = data.lastUpdDate.parseDateTimeLiteral();
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
                centerInfo.cName == center.cname);
                print("info: $info");
                if (info != null) {
                  var tmp = MyCenter(
                      address: info.address,
                      dateTime: reserveDate,
                      region: region.name,
                      district: district.name,
                      types: {clinicType},
                      status: status,
                      cName: center.cname,
                      lat: info.lat,
                      lng: info.lng,
                      engName: center.engName,
                      vaccine: vaccine.name);
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
