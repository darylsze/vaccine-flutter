import "package:collection/collection.dart";
import 'package:flutter_counter/map/entity/ReserveStatus.dart';
import 'package:flutter_counter/repo/repo.dart';
import 'package:json_annotation/json_annotation.dart';

// ignore: cascade_invocations

part 'representation.g.dart';

@JsonSerializable()
class VaccineModel {
  String vaccine;
  Set<DatePageModel> datePage;

  VaccineModel(this.vaccine, this.datePage);

  static VaccineModel fromJson(Map<String, dynamic> json) => _$VaccineModelFromJson(json);
  Map<String, dynamic> toJson() => _$VaccineModelToJson(this);
}

@JsonSerializable()
class DatePageModel {
  DateTime date;
  Set<RegionModel> regions;

  DatePageModel(this.date, this.regions);

  static DatePageModel fromJson(Map<String, dynamic> json) => _$DatePageModelFromJson(json);
  Map<String, dynamic> toJson() => _$DatePageModelToJson(this);
}

@JsonSerializable()
class RegionModel {
  String name;
  Set<DistrictModel> districts;

  RegionModel(this.name, this.districts);

  static RegionModel fromJson(Map<String, dynamic> json) => _$RegionModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegionModelToJson(this);
}
@JsonSerializable()
class DistrictModel {
  String name;
  Set<CenterForDateModel> dateCenters;

  DistrictModel(this.name, this.dateCenters);

  static DistrictModel fromJson(Map<String, dynamic> json) => _$DistrictModelFromJson(json);
  Map<String, dynamic> toJson() => _$DistrictModelToJson(this);
}
@JsonSerializable()
class CenterModel {
  Set<String> supportedVaccine;
  String district;
  String region;
  String engName;
  String cName;
  double lat;
  double lng;

  CenterModel(
      {required this.supportedVaccine,
      required this.district,
      required this.region,
      required this.engName,
      required this.cName,
      required this.lat,
      required this.lng});

  static CenterModel fromJson(Map<String, dynamic> json) => _$CenterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CenterModelToJson(this);
}

@JsonSerializable()
class CenterForDateModel {
  DateTime dateTime;
  ReserveStatus status;
  CenterModel center;

  CenterForDateModel({required this.dateTime, required this.status, required this.center});

  static CenterForDateModel fromJson(Map<String, dynamic> json) =>
      _$CenterForDateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CenterForDateModelToJson(this);
}

class HomeViewModel {
  late Set<MyCenter> messyCenters;

  HomeViewModel.from(Set<MyCenter> messyCenters) {
    this.messyCenters = messyCenters;
  }

  Set<VaccineModel> getVaccineModels() {
    Set<VaccineModel> vaccines = {};
    messyCenters.groupSetsBy((element) => element.vaccine).forEach(
      (vaccine, centersByVaccine) {
        Set<DatePageModel> page = {};
        centersByVaccine.groupSetsBy((element) => element.dateTime).forEach(
          (date, centersByDates) {
            Set<RegionModel> regions = {};
            centersByDates.groupSetsBy((element) => element.region).forEach(
              (region, centersByRegion) {
                Set<DistrictModel> districts = {};
                centersByRegion.groupSetsBy((element) => element.district).forEach(
                  (district, Set<MyCenter> centersByDistrict) {
                    var centers = centersByDistrict.map((MyCenter e) {
                      var supportedVaccine = messyCenters
                          .where((element) => element.cName == e.cName)
                          .groupSetsBy((element) => element.vaccine)
                          .keys
                          .toSet();
                      var center = CenterModel(
                          cName: e.cName,
                          district: district,
                          engName: e.engName,
                          lat: e.lat,
                          lng: e.lng,
                          region: region,
                          supportedVaccine: supportedVaccine);
                      // ignore: lines_longer_than_80_chars
                      return CenterForDateModel(dateTime: date, status: e.status, center: center);
                    }).toSet();
                    districts.add(DistrictModel(district, centers));
                  },
                );
                regions.add(RegionModel(region, districts));
              },
            );
            page.add(DatePageModel(date, regions));
          },
        );
        vaccines.add(VaccineModel(vaccine, page));
      },
    );

    return vaccines;
  }
}
