import 'package:json_annotation/json_annotation.dart';
import 'package:vaccine_hk/data/entities.dart';

part 'remote_vaccines_entity.g.dart';

@JsonSerializable()
class RemoteGetAllCenterLocationsResponse {
	@JsonKey(name: "data")
	Set<CenterInfo> centerLocations;

	RemoteGetAllCenterLocationsResponse({ required this.centerLocations });

  static RemoteGetAllCenterLocationsResponse fromJson(Map<String, dynamic> json) => _$RemoteGetAllCenterLocationsResponseFromJson(json);
	Map<String, dynamic> toJson() => _$RemoteGetAllCenterLocationsResponseToJson(this);
}

@JsonSerializable()
class RemoteVaccines {
	String lastUpdDate;
  Set<RemoteVaccine> vaccines;

  RemoteVaccines({required this.lastUpdDate, required this.vaccines});

  static RemoteVaccines fromJson(Map<String, dynamic> json) => _$RemoteVaccinesFromJson(json);
  Map<String, dynamic> toJson() => _$RemoteVaccinesToJson(this);
}
@JsonSerializable()
class RemoteVaccine {
	String name;
	Set<RemoteRegion> regions;

	RemoteVaccine({ required this.name, required this.regions });

	static RemoteVaccine fromJson(Map<String, dynamic> json) => _$RemoteVaccineFromJson(json);
	Map<String, dynamic> toJson() => _$RemoteVaccineToJson(this);
}

@JsonSerializable()
class RemoteRegion {
	String name;
	Set<RemoteDistrict> districts;

	RemoteRegion({ required this.name, required this.districts });

	static RemoteRegion fromJson(Map<String, dynamic> json) => _$RemoteRegionFromJson(json);
	Map<String, dynamic> toJson() => _$RemoteRegionToJson(this);
}

@JsonSerializable()
class RemoteDistrict {
	String name;
	Set<RemoteCenter> centers;

	RemoteDistrict({ required this.name, required this.centers });

	static RemoteDistrict fromJson(Map<String, dynamic> json) => _$RemoteDistrictFromJson(json);
	Map<String, dynamic> toJson() => _$RemoteDistrictToJson(this);
}

@JsonSerializable()
class RemoteCenter {
	@JsonKey(name: 'name')
	String engName;
	String cname;
	String sname;
	String type;
	Set<RemoteQuota> quota;

	RemoteCenter({
		required this.engName, required this.cname, required this.sname, required this.type, required this.quota
	});

	static RemoteCenter fromJson(Map<String, dynamic> json) => _$RemoteCenterFromJson(json);
	Map<String, dynamic> toJson() => _$RemoteCenterToJson(this);
}

@JsonSerializable()
class RemoteQuota {
	String date;
	String status;

	RemoteQuota({
		required this.date, required this.status
	});

	static RemoteQuota fromJson(Map<String, dynamic> json) => _$RemoteQuotaFromJson(json);
	Map<String, dynamic> toJson() => _$RemoteQuotaToJson(this);
}
