import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_hk/cubit/cubit_map_details.dart';
import 'package:vaccine_hk/data/entities.dart';
import 'package:vaccine_hk/repo/repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();
  final Repo repo = Repo();

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(22.3366269, 114.1744231), // hk
    zoom: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: repo.getAllCenterInfos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var markers = (snapshot.data as Set<CenterInfo>)
                  .map((marker) {
                return Marker(
                    position: LatLng(marker.lat, marker.lng),
                    markerId: MarkerId(marker.address),
                    onTap: () => context.read<MapDetailsCubit>().selectMarker(marker));
              }).toSet();
              return _renderMapView(context, markers);
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _renderMapView(BuildContext context, Set<Marker> markers) {
    // return Stack(
    //   children: [
    //     GoogleMap(
    //         mapType: MapType.normal,
    //         initialCameraPosition: _kGooglePlex,
    //         onMapCreated: _controller.complete,
    //         markers: markers),
    //     Container(
    //       child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
    //         print("rerender map view");
    //         if (state is! AppStateReady) {
    //           return Container();
    //         }
    //         print("is app ready");
    //         if (state.tappedCenter == null) {
    //           return Container();
    //         }
    //         print("current is not null");
    //
    //         print("render row");
    //         return Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             MyInfoWindow(
    //               center: state.tappedCenter!,
    //               shouldShowRefreshButton:
    //                   state.tappedCenter!.status != ReserveStatus.FULL,
    //             )
    //           ],
    //         );
    //       }),
    //     )
    //   ],
    // );
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: _controller.complete,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
        markers: markers);
  }

// Future<void> _goToTheLake() async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
}
