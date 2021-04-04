import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vaccine_hk/data/entities.dart';

@JsonSerializable()
class GetArticlesResponse {
  List<IPost> data;

  GetArticlesResponse(this.data);
}

class RemoteArticles {
  static Future<List<IPost>> getArticels({required int page}) async {
    Response<String> response = await Dio().get('https://vaccine-hk.web.app/getVaccineArticles');
    if (response.data == null) {
      throw Exception("data is null");
    }
    List<dynamic> list = json.decode(response.data ?? '[]') as List<dynamic>;
    return list.asMap().entries.map((e) {
      if (e.key == 0) {
        return PostBanner.fromJson(e.value as Map<String, dynamic>);
      } else {
        return PostRow.fromJson(e.value as Map<String, dynamic>);
      }
    }).toList();
  }

  static Future<PostDetails> getArticleDetails({required String postId}) async {
    Response<Map<String, dynamic>> response = await Dio().get('https://vaccine-hk.web.app/getVaccineArticleById?id=$postId');
    if (response.data == null) {
      throw Exception("data is null");
    }
    return PostDetails.fromJson(response.data!);
  }
}
