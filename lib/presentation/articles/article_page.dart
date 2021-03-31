import 'package:flutter/material.dart';
import 'package:vaccine_hk/data/entities.dart';
import 'package:vaccine_hk/presentation/articles/post_banner_widget.dart';
import 'package:vaccine_hk/presentation/articles/post_row_widget.dart';

class ArticlePage extends StatelessWidget {
  List<Widget> items = [
    PostBanner("In the Swiss Alps, Walking a Cliff's Edge to History", "imgUrl", DateTime.now(),
        [PostTag.TRENDING]),
    PostRow("Google Semantic Experience let you play word games with its AI", "imgUrl",
        DateTime.now(), [PostTag.TRENDING]),
    PostRow("abcd", "imgUrl", DateTime.now(), [PostTag.TRENDING]),
    PostRow("abcd", "imgUrl", DateTime.now(), [PostTag.TRENDING]),
  ].map((e) {
    if (e is PostRow) {
      return PostRowWidget(e);
    }
    if (e is PostBanner) {
      return PostBannerWidget(e);
    }
    throw Exception("not implemented");
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return items[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  ArticlePage();
}
