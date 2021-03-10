import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vaccine_hk/home/remote_vaccines_entity.dart';
import 'package:vaccine_hk/map/entity/CenterInfo.dart';
import 'package:vaccine_hk/map/entity/ReserveStatus.dart';

class Result<T> {
}

class Success<T> extends Result<T> {
  late T data;

  Success(this.data);

}

class Error<T> extends Result<T> {
  Error();
}

class Remote {
  Future<RemoteVaccines> getVaccines() async {
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    Response<Map<String, dynamic>> response =
        await Dio().get('https://booking.covidvaccine.gov.hk/centre/data.json?_=$nowTs');
    if (response.data == null) {
      throw Exception("data is null");
    }
    var data = RemoteVaccines.fromJson(response.data!);
    return data;
  }

  Future<Set<CenterInfo>> getAllCenterLocationInfos() async {
    Response<Map<String, dynamic>> response = await Dio().get(
      'https://vaccine-hk.web.app/getAllCenterLocations',
      options: Options(
        contentType: Headers.jsonContentType
      ),
    );
    if (response.data == null) {
      throw Exception("data is null");
    }
    print(response.data);
    var data = RemoteGetAllCenterLocationsResponse.fromJson((response.data!));
    return data.centerLocations;

    // return Future.delayed(
    //     Duration(seconds: 0),
    //     () => {
    //           CenterInfo(
    //               cName: "中山紀念公園體育館社區疫苗接種中心",
    //               address: "香港西營盤東邊街北18號",
    //               lat: 22.2900426,
    //               lng: 114.1435092,
    //               status: ReserveStatus.FULL),
    //           CenterInfo(
    //               cName: "西營盤賽馬會普通科門診診所",
    //               address: "香港西營盤皇后大道西134號",
    //               lat: 22.3173771,
    //               lng: 114.259532,
    //               status: ReserveStatus.AVAILABLE),
    //           CenterInfo(
    //               cName: "南葵涌賽馬會普通科門診診所",
    //               address: "fake 香港九龍塘沙福道19號",
    //               lat: 22.2848009,
    //               lng: 114.2236058,
    //               status: ReserveStatus.URGENT),
    //           CenterInfo(
    //               cName: "龍琛路體育館社區疫苗接種中心",
    //               address: "fake 香港曉光街2號曉光街體育館",
    //               lat: 22.3608107,
    //               lng: 114.1253342,
    //               status: ReserveStatus.FULL),
    //           CenterInfo(
    //               cName: "西營盤賽馬會普通科門診診所",
    //               address: "fake 香港曉光街2號曉光街體育館",
    //               lat: 22.3608107,
    //               lng: 114.1253342,
    //               status: ReserveStatus.FULL),
    //           CenterInfo(
    //               cName: "中九龍診所",
    //               address: "fake 香港曉光街2號曉光街體育館",
    //               lat: 22.3608107,
    //               lng: 114.1253342,
    //               status: ReserveStatus.FULL),
    //           CenterInfo(
    //               cName:
    //                   "教育局九龍塘教育服務中心社區疫苗接種中心",
    //               address: "fake 香港荔枝角荔灣道1號荔枝角公園體育館",
    //               lat: 22.3608107,
    //               lng: 114.1253342,
    //               status: ReserveStatus.FULL),
    //           CenterInfo(
    //               cName: "曉光街體育館社區疫苗接種中心",
    //               address: "fake 香港荔枝角荔灣道1號荔枝角公園體育館",
    //               lat: 22.3608107,
    //               lng: 114.1253342,
    //               status: ReserveStatus.FULL),
    //           CenterInfo(
    //               cName: "中山紀念公園體育館社區疫苗接種中心",
    //               address: "fake 香港荔枝角荔灣道1號荔枝角公園體育館",
    //               lat: 22.3608107,
    //               lng: 114.1253342,
    //               status: ReserveStatus.FULL),
    //         });
  }
}
