// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_vaccines_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteVaccines _$RemoteVaccinesFromJson(Map<String, dynamic> json) {
  return RemoteVaccines(
    lastUpdDate: json['lastUpdDate'] as String,
    vaccines: (json['vaccines'] as List<dynamic>)
        .map((e) => RemoteVaccine.fromJson(e as Map<String, dynamic>))
        .toSet(),
  );
}

Map<String, dynamic> _$RemoteVaccinesToJson(RemoteVaccines instance) =>
    <String, dynamic>{
      'lastUpdDate': instance.lastUpdDate,
      'vaccines': instance.vaccines.toList(),
    };

RemoteVaccine _$RemoteVaccineFromJson(Map<String, dynamic> json) {
  return RemoteVaccine(
    name: json['name'] as String,
    regions: (json['regions'] as List<dynamic>)
        .map((e) => RemoteRegion.fromJson(e as Map<String, dynamic>))
        .toSet(),
  );
}

Map<String, dynamic> _$RemoteVaccineToJson(RemoteVaccine instance) =>
    <String, dynamic>{
      'name': instance.name,
      'regions': instance.regions.toList(),
    };

RemoteRegion _$RemoteRegionFromJson(Map<String, dynamic> json) {
  return RemoteRegion(
    name: json['name'] as String,
    districts: (json['districts'] as List<dynamic>)
        .map((e) => RemoteDistrict.fromJson(e as Map<String, dynamic>))
        .toSet(),
  );
}

Map<String, dynamic> _$RemoteRegionToJson(RemoteRegion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'districts': instance.districts.toList(),
    };

RemoteDistrict _$RemoteDistrictFromJson(Map<String, dynamic> json) {
  return RemoteDistrict(
    name: json['name'] as String,
    centers: (json['centers'] as List<dynamic>)
        .map((e) => RemoteCenter.fromJson(e as Map<String, dynamic>))
        .toSet(),
  );
}

Map<String, dynamic> _$RemoteDistrictToJson(RemoteDistrict instance) =>
    <String, dynamic>{
      'name': instance.name,
      'centers': instance.centers.toList(),
    };

RemoteCenter _$RemoteCenterFromJson(Map<String, dynamic> json) {
  return RemoteCenter(
    engName: json['name'] as String,
    cname: json['cname'] as String,
    sname: json['sname'] as String,
    type: json['type'] as String,
    quota: (json['quota'] as List<dynamic>)
        .map((e) => RemoteQuota.fromJson(e as Map<String, dynamic>))
        .toSet(),
  );
}

Map<String, dynamic> _$RemoteCenterToJson(RemoteCenter instance) =>
    <String, dynamic>{
      'name': instance.engName,
      'cname': instance.cname,
      'sname': instance.sname,
      'type': instance.type,
      'quota': instance.quota.toList(),
    };

RemoteQuota _$RemoteQuotaFromJson(Map<String, dynamic> json) {
  return RemoteQuota(
    date: json['date'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$RemoteQuotaToJson(RemoteQuota instance) =>
    <String, dynamic>{
      'date': instance.date,
      'status': instance.status,
    };
