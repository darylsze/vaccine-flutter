
import 'package:equatable/equatable.dart';
import 'package:vaccine_hk/map/entity/CenterInfo.dart';

abstract class AppState extends Equatable {}

class AppStateLoading extends AppState {
  @override
  List<Object> get props => [];
}

class AppStateReady extends AppState {
  CenterInfo? tappedCenter;
  Set<CenterInfo>? allMarkers;

  AppStateReady(this.tappedCenter, this.allMarkers);

  @override
  String toString() {
    return "AppState(currentMarker: $tappedCenter, allMarkers: $allMarkers)";
  }

  @override
  List<Object?> get props => [tappedCenter, allMarkers];

  AppStateReady copyWith({CenterInfo? marker}) {
    return AppStateReady(marker ?? tappedCenter, allMarkers);
  }
}
