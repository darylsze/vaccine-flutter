import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vaccine_hk/data/entities.dart';

class PostRowWidget extends StatelessWidget {
  PostRow item;

  PostRowWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        children: [
          Hero(
            tag: "image_banner",
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(item.imgUrl),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                item.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(timeago.format(item.createdAt, locale: 'zh')),
                    InkWell(
                        onTap: () {
                          Share.share(
                            "我覺得這篇文章很有趣，想邀請你看看！\n\n${item.title}\n${item.link}\n\n\n-----------\n接收最新疫苗資訊！\n\nhttps://play.google.com/store/apps/details?id=com.rejoy.vaccine_hk",
                          );
                        },
                        child: Icon(Icons.ios_share)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
