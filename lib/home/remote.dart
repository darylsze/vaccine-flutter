import 'package:flutter_counter/repo/repo.dart';

class Remote {
  Future<RemoteVaccines> getVaccines() {
    return Future.delayed(
        Duration(seconds: 2),
            () => RemoteVaccines("06/03/2021 10:55 PM", {
          RemoteVaccine("BioNTech/Fosun", {
            RemoteRegion("HKI", {
              RemoteDistrict("Central and Western", {
                RemoteCenter("Community Vaccination Centre, Sun Yat Sen Memorial Park Sports Centre",
                    "中山紀念公園體育館社區疫苗接種中心", "中山纪念公园体育馆社区疫苗接种中心", "CVC", {
                      RemoteQuota("19/03", "0"),
                      RemoteQuota("17/03", "2"),
                      RemoteQuota("11/03", "1"),
                      RemoteQuota("12/03", "0"),
                      RemoteQuota("13/03", "2"),
                    })
              })
            }),
          }),
          RemoteVaccine("Sinovac", {
            RemoteRegion("HKI", {
              RemoteDistrict("Central and Western", {
                RemoteCenter("Sai Ying Pun Jockey Club General Out-patient Clinic", "西營盤賽馬會普通科門診診所",
                    "西营盘赛马会普通科门诊诊所", "HA", {
                      RemoteQuota("19/03", "0"),
                      RemoteQuota("17/03", "2"),
                      RemoteQuota("11/03", "1"),
                      RemoteQuota("12/03", "0"),
                      RemoteQuota("13/03", "2"),
                    })
              })
            }),
          }),
        }));
  }
}
