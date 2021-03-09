import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/centerDetaiils/cubit.dart';
import 'package:flutter_counter/centerDetaiils/state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CenterDetailView extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    Color getBookingButtonColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.greenAccent;
      }
      return Colors.green;
    }

    Color getNotifyMeButtonColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.redAccent;
      }
      return Colors.red;
    }

    return BlocBuilder<CenterDetailsCubit, CenterDetailsState>(builder: (context, state) {
      var center = state.currentCenter!;

      return Scaffold(
        appBar: AppBar(
          title: const Text("地點詳情"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "上次更新時間: ${DateFormat("yyyy-MM-dd HH:mm:ss").format(center.lastUpdateAt)}",
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.currentCenter?.cName ?? "Unknown",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded),
                    Flexible(
                      child: AutoSizeText(state.currentCenter?.address ?? "Unknown",
                          style: TextStyle(fontSize: 20),
                          minFontSize: 16,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
                _renderMapView(context: context, lat: center.lat, lng: center.lng),
                SizedBox.fromSize(
                  size: Size.fromHeight(50),
                ),
                Text("此地點提供疫苗的類型：", style: TextStyle(fontSize: 20)),
                ...center.vaccineType
                    .map((e) => Row(
                          children: [
                            Checkbox(value: true, onChanged: (bool) => {}),
                            Text(
                              e.name,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ))
                    .toList(),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(getBookingButtonColor)),
                    onPressed: () async {
                      String _url = "https://booking.covidvaccine.gov.hk/forms/";
                      bool canLaunchUrl = await canLaunch(_url);
                      if (canLaunchUrl) {
                        await launch(_url);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('立即預約', style: TextStyle(fontSize: 25)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(getNotifyMeButtonColor)),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('有位時通知我', style: TextStyle(fontSize: 25)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _renderMapView({required BuildContext context, required double lat, required double lng}) {
    Set<Marker> markers = {Marker(markerId: MarkerId("${lat + lng}"), position: LatLng(lat, lng))};
    return SizedBox(
      height: 250,
      child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, lng), // hk
            zoom: 15,
          ),
          onMapCreated: _controller.complete,
          markers: markers),
    );
  }
}
