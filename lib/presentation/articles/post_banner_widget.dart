import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vaccine_hk/data/entities.dart';

class PostBannerWidget extends StatelessWidget {
  PostBanner item;

  PostBannerWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1491331606314-1d15535360fa?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1200&q=80",
          ),
          fit: BoxFit.fill
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Container(
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
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
                Text("22 hours ago"),
                Icon(Icons.ios_share),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
