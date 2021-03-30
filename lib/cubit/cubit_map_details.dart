import 'package:bloc/bloc.dart';
import 'package:vaccine_hk/data/entities.dart';
import 'package:vaccine_hk/presentation/map/state.dart';

class MapDetailsCubit extends Cubit<MapDetailsState> {
  // ignore: public_member_api_docs
  MapDetailsCubit() : super(MapDetailsStateReady(null, {}));

  void selectMarker(CenterInfo selected) {
    if (state is MapDetailsStateReady) {
      print('selected marker: $selected');
      var newState = (state as MapDetailsStateReady).copyWith(marker: selected);
      print('emit new state: $newState');
      emit(newState);
    }
  }

  void init() {
    emit(MapDetailsStateReady(null, {}));
  }

// void decrement() => emit(state - 1);
}
