import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CenterInfo.g.dart';

@JsonSerializable()
class CenterInfo extends Equatable {
  @JsonKey(name: "locationName")
  String cName;
  String address;
  double lat;
  double lng;

  CenterInfo({required this.cName, required this.address, required this.lat, required this.lng});

  @override
  List<Object> get props => [address, cName, lat, lng];

  static CenterInfo fromJson(Map<String, dynamic> json) => _$CenterInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CenterInfoToJson(this);
}
