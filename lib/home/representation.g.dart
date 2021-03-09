// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'representation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VaccineModel _$VaccineModelFromJson(Map<String, dynamic> json) {
  return VaccineModel(
    json['vaccine'] as String,
    (json['datePage'] as List<dynamic>)
        .map((e) => DatePageModel.fromJson(e as Map<String, dynamic>))
        .toSet(),
  );
}

Map<String, dynamic> _$VaccineModelToJson(VaccineModel instance) =>
    <String, dynamic>{
      'vaccine': instance.vaccine,
      'datePage': instance.datePage.toList(),
    };

DatePageModel _$DatePageModelFromJson(Map<String, dynamic> json) {
  return DatePageModel(
    DateTime.parse(json['date'] as String),
    (json['regions'] as List<dynamic>)
        .map((e) => RegionModel.fromJson(e as Map<String, dynamic>))
        .toSet(),
  );
}

Map<String, dynamic> _$DatePageModelToJson(DatePageModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'regions': instance.regions.toList(),
    };

RegionModel _$RegionModelFromJson(Map<String, dynamic> json) {
  return RegionModel(
    json['name'] as String,
    (json['districts'] as List<dynamic>)
        .map((e) => DistrictModel.fromJson(e as Map<String, dynamic>))
        .toSet(),
  );
}

Map<String, dynamic> _$RegionModelToJson(RegionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'districts': instance.districts.toList(),
    };

DistrictModel _$DistrictModelFromJson(Map<String, dynamic> json) {
  return DistrictModel(
    json['name'] as String,
    (json['dateCenters'] as List<dynamic>)
        .map((e) => CenterForDateModel.fromJson(e as Map<String, dynamic>))
        .toSet(),
  );
}

Map<String, dynamic> _$DistrictModelToJson(DistrictModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dateCenters': instance.dateCenters.toList(),
    };

CenterModel _$CenterModelFromJson(Map<String, dynamic> json) {
  return CenterModel(
    supportedVaccine: (json['supportedVaccine'] as List<dynamic>)
        .map((e) => e as String)
        .toSet(),
    district: json['district'] as String,
    region: json['region'] as String,
    engName: json['engName'] as String,
    cName: json['cName'] as String,
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CenterModelToJson(CenterModel instance) =>
    <String, dynamic>{
      'supportedVaccine': instance.supportedVaccine.toList(),
      'district': instance.district,
      'region': instance.region,
      'engName': instance.engName,
      'cName': instance.cName,
      'lat': instance.lat,
      'lng': instance.lng,
    };

CenterForDateModel _$CenterForDateModelFromJson(Map<String, dynamic> json) {
  return CenterForDateModel(
    dateTime: DateTime.parse(json['dateTime'] as String),
    status: _$enumDecode(_$ReserveStatusEnumMap, json['status']),
    center: CenterModel.fromJson(json['center'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CenterForDateModelToJson(CenterForDateModel instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'status': _$ReserveStatusEnumMap[instance.status],
      'center': instance.center,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$ReserveStatusEnumMap = {
  ReserveStatus.FULL: 'FULL',
  ReserveStatus.AVAILABLE: 'AVAILABLE',
  ReserveStatus.URGENT: 'URGENT',
};
