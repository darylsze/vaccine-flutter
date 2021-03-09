// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCenter _$MyCenterFromJson(Map<String, dynamic> json) {
  return MyCenter(
    dateTime: DateTime.parse(json['dateTime'] as String),
    region: json['region'] as String,
    district: json['district'] as String,
    types: (json['types'] as List<dynamic>)
        .map((e) => _$enumDecode(_$ClinicTypeEnumMap, e))
        .toSet(),
    status: _$enumDecode(_$ReserveStatusEnumMap, json['status']),
    engName: json['engName'] as String,
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
    cName: json['cName'] as String,
    vaccine: json['vaccine'] as String,
  );
}

Map<String, dynamic> _$MyCenterToJson(MyCenter instance) => <String, dynamic>{
      'vaccine': instance.vaccine,
      'dateTime': instance.dateTime.toIso8601String(),
      'region': instance.region,
      'district': instance.district,
      'types': instance.types.map((e) => _$ClinicTypeEnumMap[e]).toList(),
      'status': _$ReserveStatusEnumMap[instance.status],
      'cName': instance.cName,
      'engName': instance.engName,
      'lat': instance.lat,
      'lng': instance.lng,
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

const _$ClinicTypeEnumMap = {
  ClinicType.HA: 'HA',
  ClinicType.CVV: 'CVV',
  ClinicType.UNKNOWN: 'UNKNOWN',
};

const _$ReserveStatusEnumMap = {
  ReserveStatus.FULL: 'FULL',
  ReserveStatus.AVAILABLE: 'AVAILABLE',
  ReserveStatus.URGENT: 'URGENT',
};
