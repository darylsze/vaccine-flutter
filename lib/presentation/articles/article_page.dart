import 'package:flutter/material.dart';
import 'package:vaccine_hk/data/entities.dart';
import 'package:vaccine_hk/presentation/articleDetails/article_details_page.dart';
import 'package:vaccine_hk/presentation/articles/post_banner_widget.dart';
import 'package:vaccine_hk/presentation/articles/post_row_widget.dart';

class ArticlePage extends StatelessWidget {
  final List<IPost> items = [
    PostBanner(
        "In the Swiss Alps, Walking a Cliff's Edge to History",
        "https://images.unsplash.com/photo-1491331606314-1d15535360fa?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1200&q=80",
        DateTime.now(),
        [PostTag.TRENDING]),
    PostRow("Google Semantic Experience let you play word games with its AI", "https://images.unsplash.com/photo-1491331606314-1d15535360fa?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1200&q=80",
        DateTime.now(), []),
    PostRow("Google Semantic Experience let you play word games with its AI", "https://images.unsplash.com/photo-1491331606314-1d15535360fa?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1200&q=80",
        DateTime.now(), []),
    PostRow("Google Semantic Experience let you play word games with its AI", "https://images.unsplash.com/photo-1491331606314-1d15535360fa?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1200&q=80",
        DateTime.now(), []),
    PostRow("Google Semantic Experience let you play word games with its AI", "https://images.unsplash.com/photo-1491331606314-1d15535360fa?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1200&q=80",
        DateTime.now(), []),
    PostBanner(
        "In the Swiss Alps, Walking a Cliff's Edge to History",
        "https://images.unsplash.com/photo-1491331606314-1d15535360fa?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1200&q=80",
        DateTime.now(),
        [PostTag.TRENDING]),
    // todo add some ads (native?, or just banner)
    PostRow("Google Semantic Experience let you play word games with its AI", "imgUrl",
        DateTime.now(), []),
    PostRow("abcd", "https://images.unsplash.com/photo-1491331606314-1d15535360fa?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1200&q=80", DateTime.now(), []),
    PostRow("abcd", "https://images.unsplash.com/photo-1491331606314-1d15535360fa?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1200&q=80", DateTime.now(), []),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> itemWidgets = items.map((e) {
      if (e is PostRow) {
        return PostRowWidget(e);
      }
      if (e is PostBanner) {
        return PostBannerWidget(e);
      }
      throw Exception("not implemented");
    }).toList();

    return Scaffold(
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: itemWidgets[index],
            onTap: () {
              goToDetailsPage(context, items[index]);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  ArticlePage();

  void goToDetailsPage(BuildContext context, IPost item) {
    Navigator.pushNamed(
      context,
      ArticleDetailsPage.routeName,
      arguments: ArticleDetailsPageArguments(item),
    );
  }
}
