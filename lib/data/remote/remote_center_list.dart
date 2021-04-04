import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vaccine_hk/data/remote/remote_vaccines_entity.dart';
import 'package:vaccine_hk/data/entities.dart';

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
  }
}
