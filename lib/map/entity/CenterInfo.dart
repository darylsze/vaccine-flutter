import 'package:equatable/equatable.dart';

import 'ReserveStatus.dart';

class CenterInfo extends Equatable {
  String cName;
  String address;
  double lat;
  double lng;
  ReserveStatus status;

  CenterInfo({ required this.cName, required this.address, required this.lat, required this.lng, required this.status });

  @override
  List<Object> get props => [address, cName, lat, lng, status];
}
