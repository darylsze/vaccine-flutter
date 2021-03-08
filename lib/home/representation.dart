import "package:collection/collection.dart";
import 'package:flutter_counter/map/entity/ReserveStatus.dart';
import 'package:flutter_counter/repo/repo.dart';
// ignore: cascade_invocations

class VaccineModel {
  String vaccine;
  Set<DatePageModel> datePage;

  VaccineModel(this.vaccine, this.datePage);
}

class DatePageModel {
  DateTime date;
  Set<RegionModel> regions;

  DatePageModel(this.date, this.regions);
}

class RegionModel {
  Set<DistrictModel> districts;

  RegionModel(this.districts);
}

class DistrictModel {
  Set<CenterModel> centers;

  DistrictModel(this.centers);
}

class CenterModel {
  ReserveStatus status;
  String address;
  String name;
  double lat;
  double lng;

  CenterModel(this.status, this.address, this.name, this.lat, this.lng);
}

class HomeViewModel {
  late Set<MyCenter> centers;

  HomeViewModel.from(Set<MyCenter> centers) {
    this.centers = centers;
  }

  Set<VaccineModel> getVaccineModels() {
    Set<VaccineModel> vaccines = {};
    centers.groupSetsBy((element) => element.vaccine).forEach(
      (vaccine, centersByVaccine) {
        Set<DatePageModel> page = {};
        centersByVaccine.groupSetsBy((element) => element.dateTime).forEach(
          (date, centersByDates) {
            var groupByRegion = centersByDates.groupSetsBy((element) => element.region);
            Set<RegionModel> regions = {};
            groupByRegion.forEach(
              (region, centersByRegion) {
                Set<DistrictModel> districts = {};
                centers.groupSetsBy((element) => element.district).forEach(
                  (district, centersByDistrict) {
                    Set<CenterModel> centers = centersByDistrict
                        .map((e) => CenterModel(e.status, e.address, e.address, e.lat, e.lng))
                        .toSet();
                    districts.add(DistrictModel(centers));
                  },
                );
                regions.add(RegionModel(districts));
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
