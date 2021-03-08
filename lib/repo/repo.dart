import 'package:flutter_counter/map/module/CenterInfo.dart';
import 'package:flutter_counter/map/module/ReserveStatus.dart';

class Vaccines {
  late String lastUpdDate;
  late Set<Vaccine> vaccines;

  Vaccines(this.lastUpdDate, this.vaccines);
}

class Vaccine {
  late String name;
  late Set<Region> regions;

  Vaccine(this.name, this.regions);
}

class Region {
  late String name;
  late Set<District> districts;

  Region(this.name, this.districts);
}

class District {
  late String name;
  late Set<MyCenter> centers;

  District(this.name, this.centers);
}

class MyCenter {
  late String name;
  late String cname;
  late String sname;
  late String type;
  late Set<Quota> quotas;

  MyCenter(this.name, this.cname, this.sname, this.type, this.quotas);
}

class Quota {
  late String date;
  late String status;

  Quota(this.date, this.status);
}

class Repo {
  Future<Set<CenterInfo>> getAllCenterInfos() {
    return Future.delayed(
        Duration(seconds: 2),
        () => {
              CenterInfo("a", "a", 22.2900426, 114.1435092, ReserveStatus.FULL),
              CenterInfo("b", "b", 22.3173771, 114.259532, ReserveStatus.AVAILABLE),
              CenterInfo("c", "c", 22.2848009, 114.2236058, ReserveStatus.URGENT),
              CenterInfo("d", "d", 22.3608107, 114.1253342, ReserveStatus.FULL),
            });
  }

  Future<Vaccines> getAllVaccineInfos() {
    return Future.delayed(
        Duration(seconds: 2),
        () => Vaccines("06/03/2021 10:55 PM", {
              Vaccine("BioNTech/Fosun", {
                Region("HKI", {
                  District("Central and Western", {
                    MyCenter("Community Vaccination Centre, Sun Yat Sen Memorial Park Sports Centre",
                        "中山紀念公園體育館社區疫苗接種中心", "中山纪念公园体育馆社区疫苗接种中心", "CVC", {
                      Quota("19/03", "0"),
                      Quota("17/03", "2"),
                      Quota("11/03", "1"),
                      Quota("12/03", "0"),
                      Quota("13/03", "2"),
                    })
                  })
                }),
              }),
              Vaccine("Sinovac", {
                Region("HKI", {
                  District("Central and Western", {
                    MyCenter("Sai Ying Pun Jockey Club General Out-patient Clinic", "西營盤賽馬會普通科門診診所",
                        "西营盘赛马会普通科门诊诊所", "HA", {
                      Quota("19/03", "0"),
                      Quota("17/03", "2"),
                      Quota("11/03", "1"),
                      Quota("12/03", "0"),
                      Quota("13/03", "2"),
                    })
                  })
                }),
              }),
            }));
  }
}
