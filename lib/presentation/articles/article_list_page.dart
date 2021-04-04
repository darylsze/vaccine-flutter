import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_hk/AdmobManager.dart';
import 'package:vaccine_hk/data/entities.dart';
import 'package:vaccine_hk/presentation/articleDetails/article_details_page.dart';
import 'package:vaccine_hk/presentation/articles/post_banner_widget.dart';
import 'package:vaccine_hk/presentation/articles/post_row_widget.dart';
import 'package:vaccine_hk/stringRes.dart';
import 'package:vaccine_hk/viewModel/index.dart';

class ArticleListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AdmobManager().getBanner(AdUnits.ARTICLES_LIST_BOTTOM_BANNER),
      body: FutureBuilder(
          future: ArticlesPageViewModel.getArticles(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<IPost> posts = snapshot.data as List<IPost>;
              return ListView.separated(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  Widget widget = index == 0
                      ? PostBannerWidget(posts[index] as PostBanner)
                      : PostRowWidget(posts[index] as PostRow);

                  return InkWell(
                    child: widget,
                    onTap: () {
                      goToDetailsPage(context, posts[index].id);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  ArticleListPage();

  void goToDetailsPage(BuildContext context, String postId) {
    Navigator.pushNamed(
      context,
      ArticleDetailsPage.routeName,
      arguments: ArticleDetailsPageArguments(postId),
    );
  }
}
