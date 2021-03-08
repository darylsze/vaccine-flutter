import 'package:equatable/equatable.dart';

import 'ReserveStatus.dart';

class CenterInfo extends Equatable {
  String name;
  String address;
  double lat;
  double lng;
  ReserveStatus status;

  CenterInfo(this.name, this.address, this.lat, this.lng, this.status);

  @override
  List<Object> get props => [name, address, lat, lng, status];
}
