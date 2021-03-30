import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entities.g.dart';

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

enum ClinicType {
  HA, CVV, UNKNOWN
}


enum ReserveStatus { FULL, AVAILABLE , URGENT }

extension ParseToString on ReserveStatus {
  String toName() {
    switch (this) {
      case ReserveStatus.AVAILABLE: {
        return "可供預約";
      }
      case ReserveStatus.FULL: {
        return "已滿";

      }
      case ReserveStatus.URGENT: {
        return "只餘小量";

      }
      default: {
        return "";
      }
    }
  }
  BitmapDescriptor toMarkerColor() {
    switch (this) {
      case ReserveStatus.AVAILABLE: {
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen);
      };
      case ReserveStatus.FULL: {
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRose);
      };
      case ReserveStatus.URGENT: {
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed);
      };
      default: {
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue);
      };
    }
  }

  Color toColor() {
    Color bgColor;
    switch (this) {
      case ReserveStatus.AVAILABLE: {
        bgColor = Colors.green;
        break;
      };
      case ReserveStatus.FULL: {
        bgColor = Colors.grey;
        break;
      };
      case ReserveStatus.URGENT: {
        bgColor = Colors.red;
        break;
      };
      default: {
        bgColor = Colors.white;
        break;
      };
    }
    return bgColor;
  }

  String toReserveAdvise() {
    switch (this) {
      case ReserveStatus.AVAILABLE: {
        return "目前尚有大量餘額。";
      };
      case ReserveStatus.FULL: {
        return "已沒有餘額，請選擇其他日子";
      };
      case ReserveStatus.URGENT: {
        return "目前只餘少量餘額。";
      };
      default: {
        return "";
      };
    }
  }
}
