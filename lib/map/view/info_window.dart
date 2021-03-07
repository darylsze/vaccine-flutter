import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_counter/map/module/CenterInfo.dart';
import 'package:flutter_counter/map/module/ReserveStatus.dart';

class MyInfoWindow extends StatelessWidget {
  CenterInfo center;

  // ignore: public_member_api_docs
  MyInfoWindow({required this.center});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      width: 300,
      height: 100,
      color: center.status.toColor(),
      child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                center.name,
                style: new TextStyle(
                    fontSize: 12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              Text(
                center.address,
                style: new TextStyle(
                    fontSize: 12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              Text(
                "current status: ${center.address}",
                style: new TextStyle(
                    fontSize: 12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              )
            ]),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }
}
