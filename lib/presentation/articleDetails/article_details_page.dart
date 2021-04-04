import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:vaccine_hk/AdmobManager.dart';
import 'package:vaccine_hk/data/entities.dart';
import 'package:vaccine_hk/data/remote/remote_article_list.dart';
import 'package:vaccine_hk/stringRes.dart';
import 'package:vaccine_hk/widgets/error_retry_dialog.dart';

class ArticleDetailsPageArguments {
  final String postId;

  ArticleDetailsPageArguments(this.postId);
}

class ArticleDetailsPage extends StatefulWidget {
  static final String routeName = "/articles/id";

  @override
  _ArticleDetailsPageState createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final ArticleDetailsPageArguments args =
        ModalRoute.of(context)!.settings.arguments as ArticleDetailsPageArguments;
    String postId = args.postId;

    return Scaffold(
      bottomNavigationBar: AdmobManager().getBanner(AdUnits.ARTICLE_DETAILS_BOTTOM_BANNER),
      body: FutureBuilder(
        future: RemoteArticles.getArticleDetails(postId: postId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildContent(snapshot.data as PostDetails);
          }
          if (snapshot.hasError) {
              FirebaseCrashlytics.instance.recordError(snapshot.error, StackTrace.current);
              return ErrorRetryDialogWidget();
            }

            return Center(child: CircularProgressIndicator());
        },
      )
    );
  }

  Widget _buildContent(PostDetails post) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          excludeHeaderSemantics: true,
          backgroundColor: Colors.white,
          pinned: false,
          elevation: 12,
          expandedHeight: MediaQuery.of(context).size.height * 0.6,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: "image_banner",
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(post.imgUrl),
                    )),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white38, Colors.black38]
                    ),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat("yyyy-MM-dd hh:mm aa", "zh_HK").format(post.createdAt),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        post.title,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      ...post.tags.map((e) => Text(e.toString(), style: TextStyle(color: Colors.white),)).toList()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: IconButton(
                            icon: Icon(
                              Icons.ios_share,
                              size: 15,
                            ),
                            onPressed: () {
                              Share.share("我覺得這篇文章很有趣，想邀請你看看！\n\n${post.title}\n${post.link}\n\n\n-----------\n使用「安心打疫苗」，接收最新疫苗資訊！\n\nhttps://play.google.com/store/apps/details?id=com.rejoy.vaccine_hk");
                            },
                          ),
                          backgroundColor: Color.fromARGB(255, 238, 238, 238),
                        ),
                        SizedBox(width: 10),
                        CircleAvatar(
                          child: IconButton(
                            icon: Image.asset("assets/images/wechat.png", width: 45, height: 45),
                            onPressed: () {
                              // todo go to wechat
                              Share.share("我覺得這篇文章很有趣，想邀請你看看！\n\n${post.title}\n${post.link}\n\n\n-----------\n使用「安心打疫苗」，接收最新疫苗資訊！\n\nhttps://play.google.com/store/apps/details?id=com.rejoy.vaccine_hk");
                            },
                          ),
                          backgroundColor: Color.fromARGB(255, 238, 238, 238),
                        ),
                        SizedBox(width: 10),
                        CircleAvatar(
                          child: IconButton(
                            icon: Image.asset("assets/images/whatsapp.png", width: 45, height: 45),
                            onPressed: () {
                              // todo go to whatsapp
                              Share.share("我覺得這篇文章很有趣，想邀請你看看！\n\n${post.title}\n${post.link}\n\n\n-----------\n使用「安心打疫苗」，接收最新疫苗資訊！\n\nhttps://play.google.com/store/apps/details?id=com.rejoy.vaccine_hk");
                            },
                          ),
                          backgroundColor: Color.fromARGB(255, 238, 238, 238),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 238, 238, 238),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        child: Text(
                          "${Random().nextInt(30000)}人瀏覽",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                SizedBox(
                  height: 15,
                ),
                Html(
                  data: post.description,
                  style: {
                    "*": Style(
                      color: Colors.grey[850],
                      fontSize: FontSize.xLarge,
                      lineHeight: LineHeight.number(1.5)
                    )
                  },
                )
              ],
            ),
          ),
          fillOverscroll: true,
        )
      ],
    );
  }
}
