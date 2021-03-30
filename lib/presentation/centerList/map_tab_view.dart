
import 'package:flutter/material.dart';
import 'package:vaccine_hk/extensions.dart';
import 'package:vaccine_hk/presentation/map/map_view.dart';

class MapTab extends StatelessWidget implements PreferredSizeWidget {
  List<DateTime> allDates;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox.fromSize(
          size: Size.fromHeight(250),
          child: MapView(),
        ),
        TabBar(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.white, width: 4.0),
          ),
          isScrollable: true,
          tabs: allDates.map((e) {
            return Tab(
              child: Column(
                children: [
                  Text(e.toHumanFriendly(), style: TextStyle(fontSize: 15)),
                  Text(e.toWeekDay(), style: TextStyle(fontSize: 14)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(300);

  MapTab({ required this.allDates });

}
