import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_hk/data/entities.dart';

class MyInfoWindow extends StatelessWidget {
  CenterInfo center;
  bool shouldShowRefreshButton = false;

  // ignore: public_member_api_docs
  MyInfoWindow({required this.center, required this.shouldShowRefreshButton});

  @override
  Widget build(BuildContext context) {
    final Widget reserveButton = shouldShowRefreshButton
        ? new OutlineButton(
            child: new Text(
              "立即預約",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              print("go to web");
            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)))
        : Container();

    return Container(
      margin: const EdgeInsets.only(top: 100),
      width: 300,
      height: 100,
      // color: center.status.toColor(),
      child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                center.cName,
                style: new TextStyle(
                    fontSize: 12.0,
                    color: Colors.black),
              ),
              Text(
                center.address,
                style: new TextStyle(
                    fontSize: 12.0,
                    color: Colors.black),
              ),
              Text(
                "",
                // center.status.toReserveAdvise(),
                style: new TextStyle(
                    color: Colors.black),
              ),
              reserveButton
            ]),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }
}
