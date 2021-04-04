import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entities.g.dart';

enum PostTag { TRENDING }

class PostDetails {
  String id;
  String title;
  String imgUrl;
  DateTime createdAt;
  List<String> tags;
  List<String> categories = [];
  String description;
  String link;

  PostDetails({required this.title,
    required this.imgUrl,
    required this.createdAt,
    required this.tags,
    required this.categories,
    required this.description,
    required this.id,
    required this.link});

  static PostDetails fromJson(Map<String, dynamic> jsonString) {
    String title = jsonString['title'] as String;
    print('title: $title');
    String imgUrl = jsonString['coverImg'] as String;
    DateTime createdAt = DateTime.parse(jsonString['createdAt'] as String);
    List<String> tags = jsonString['tags'] == null ? [] : jsonString['tags'] as List<String>;
    List<String> categories =
    jsonString['category'] == null ? [] : [jsonString['category'] as String];
    String link = jsonString['link'] as String;
    String description = jsonString['description'] as String;
    String id = jsonString['id'] as String;

    return PostDetails(
        title: title,
        imgUrl: imgUrl,
        createdAt: createdAt,
        tags: tags,
        categories: categories,
        link: link,
        description: description,
        id: id);
  }
}

class IPost {
  String id;
  String title;
  String imgUrl;
  DateTime createdAt;
  List<String> tags;
  List<String> categories = [];
  String shortDescription;
  String link;

  IPost({required this.title,
    required this.imgUrl,
    required this.createdAt,
    required this.tags,
    required this.categories,
    required this.shortDescription,
    required this.id,
    required this.link});
}

class PostRow extends IPost {
  String id;
  String title;
  String imgUrl;
  DateTime createdAt;
  List<String> tags;
  List<String> categories = [];
  String shortDescription;
  String link;

  PostRow({required this.title,
    required this.imgUrl,
    required this.createdAt,
    required this.tags,
    required this.categories,
    required this.shortDescription,
    required this.id,
    required this.link}) : super(
      title: title,
      id: id,
      imgUrl: imgUrl,
      createdAt: createdAt,
      tags: tags,
      categories: categories,
      shortDescription: shortDescription,
      link: link
  );

  static IPost fromJson(Map<String, dynamic> jsonString) {
    String title = jsonString['title'] as String;
    String imgUrl = jsonString['coverImg'] as String;
    DateTime createdAt = DateTime.parse(jsonString['createdAt'] as String);
    List<String> tags = jsonString['tags'] == null ? [] : jsonString['tags'] as List<String>;
    List<String> categories =
    jsonString['category'] == null ? [] : [jsonString['category'] as String];
    String link = jsonString['link'] as String;
    String shortDescription = jsonString['shortDescription'] as String;
    String id = jsonString['id'] as String;

    return PostRow(
        title: title,
        imgUrl: imgUrl,
        createdAt: createdAt,
        tags: tags,
        categories: categories,
        link: link,
        shortDescription: shortDescription,
        id: id);
  }
}

class PostBanner extends IPost {
  String id;
  String title;
  String imgUrl;
  DateTime createdAt;
  List<String> tags;
  List<String> categories = [];
  String shortDescription;
  String link;

  PostBanner({required this.title,
    required this.imgUrl,
    required this.createdAt,
    required this.tags,
    required this.categories,
    required this.shortDescription,
    required this.id,
    required this.link}) : super(
      title: title,
      id: id,
      imgUrl: imgUrl,
      createdAt: createdAt,
      tags: tags,
      categories: categories,
      shortDescription: shortDescription,
      link: link
  );

  static IPost fromJson(Map<String, dynamic> jsonString) {
    String title = jsonString['title'] as String;
    String imgUrl = jsonString['coverImg'] as String;
    DateTime createdAt = DateTime.parse(jsonString['createdAt'] as String);
    List<String> tags = jsonString['tags'] == null ? [] : jsonString['tags'] as List<String>;
    List<String> categories =
    jsonString['category'] == null ? [] : [jsonString['category'] as String];
    String link = jsonString['link'] as String;
    String shortDescription = jsonString['shortDescription'] as String;
    String id = jsonString['id'] as String;

    return PostBanner(
        title: title,
        imgUrl: imgUrl,
        createdAt: createdAt,
        tags: tags,
        categories: categories,
        link: link,
        shortDescription: shortDescription,
        id: id);
  }
}

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
