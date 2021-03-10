import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cubit.dart';
import 'state.dart';
import 'viewModel.dart';

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
                InkWell(
                  onTap: () async {
                    _openGoogleMap(center.address, center.lat, center.lng);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.location_on_rounded),
                      Flexible(
                        child: AutoSizeText(center.address + " (點擊開啟地圖)" ?? "Unknown",
                            style: TextStyle(fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            minFontSize: 16,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
                SizedBox.fromSize(
                  size: Size.fromHeight(15),
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
                    onPressed: () async {
                      _notifyMe(center);
                    },
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
            zoom: 14,
          ),
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          scrollGesturesEnabled: false,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            Factory<OneSequenceGestureRecognizer>(
              // () => ScaleGestureRecognizer(),
                  () => HorizontalDragGestureRecognizer(),
            ),
          ].toSet(),
          onMapCreated: _controller.complete,
          markers: markers),
    );
  }

  _openGoogleMap(String address, double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      var zoom = 16;
      final Uri mapLaunchUri = Uri(
          scheme: 'https',
          path: 'www.google.com.hk/maps/search/$address/@$lat,$lng,${zoom}z',
      );
      await launch(mapLaunchUri.toString());
    }
  }

  void _notifyMe(CenterDetailsModel center) async {
    await Firebase.initializeApp();
    // accept permission
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );


    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

  }
}
