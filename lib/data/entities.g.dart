// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterInfo _$CenterInfoFromJson(Map<String, dynamic> json) {
  return CenterInfo(
    cName: json['locationName'] as String,
    address: json['address'] as String,
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CenterInfoToJson(CenterInfo instance) =>
    <String, dynamic>{
      'locationName': instance.cName,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
    };
