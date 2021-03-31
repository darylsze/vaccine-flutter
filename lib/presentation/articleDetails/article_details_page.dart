import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:vaccine_hk/data/entities.dart';

class ArticleDetailsPageArguments {
  final IPost post;

  ArticleDetailsPageArguments(this.post);
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
    print("args: ${args.post}");
    IPost post = args.post;
    // IPost post = PostRow(
    //   "White house tried to lock down ukraine call records whistle blower says",
    //   "https://images.unsplash.com/photo-1491331606314-1d15535360fa?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1200&q=80",
    //   DateTime.now(),
    //   [PostTag.TRENDING],
    // );

    return Scaffold(
      body: CustomScrollView(
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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Sept 26, 2019   |   15:15 PM"),
                        SizedBox(height: 10),
                        Text(
                          post.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 10),
                        ...post.tags.map((e) => Text(e.toString())).toList()
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
                              onPressed: () {},
                            ),
                            backgroundColor: Color.fromARGB(255, 238, 238, 238),
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            child: IconButton(
                              icon: Icon(
                                Icons.share,
                                size: 15,
                              ),
                              onPressed: () {},
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
                            "2555 views",
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
                  Text(
                    lipsum.createParagraph(numParagraphs: 5, numSentences: 5),
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.grey[850],
                    ),
                  )
                ],
              ),
            ),
            fillOverscroll: true,
          )
        ],
      ),
    );
  }
}
