import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';
import 'package:vaccine_hk/data/entities.dart';
import 'package:timeago/timeago.dart' as timeago;


class PostBannerWidget extends StatelessWidget {
  PostBanner item;

  PostBannerWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "image_banner",
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(item.imgUrl),
            fit: BoxFit.fill,
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.6,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white38, Colors.black38]
            )
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: item.tags
                    .map((e) => Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            e.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                item.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeago.format(item.createdAt, locale: "zh"),
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                  InkWell(
                    onTap: () {
                      Share.share("我覺得這篇文章很有趣，想邀請你看看！\n\n${item.title}\n${item.link}\n\n\n-----------\n接收最新疫苗資訊！\n\nhttps://play.google.com/store/apps/details?id=com.rejoy.vaccine_hk");
                    },
                    child: Icon(
                      Icons.ios_share,
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
