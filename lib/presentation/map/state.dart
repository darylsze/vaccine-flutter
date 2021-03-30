
import 'package:equatable/equatable.dart';
import 'package:vaccine_hk/data/entities.dart';

abstract class MapDetailsState extends Equatable {}

class MapDetailsStateLoading extends MapDetailsState {
  @override
  List<Object> get props => [];
}

class MapDetailsStateReady extends MapDetailsState {
  CenterInfo? tappedCenter;
  Set<CenterInfo>? allMarkers;

  MapDetailsStateReady(this.tappedCenter, this.allMarkers);

  @override
  String toString() {
    return "AppState(currentMarker: $tappedCenter, allMarkers: $allMarkers)";
  }

  @override
  List<Object?> get props => [tappedCenter, allMarkers];

  MapDetailsStateReady copyWith({CenterInfo? marker}) {
    return MapDetailsStateReady(marker ?? tappedCenter, allMarkers);
  }
}
