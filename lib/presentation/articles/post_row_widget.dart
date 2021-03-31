import 'package:flutter/material.dart';
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
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(color: Colors.red),
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
                    Text("22 hours ago"),
                    Icon(Icons.ios_share),
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
