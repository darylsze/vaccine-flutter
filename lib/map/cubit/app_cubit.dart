import 'package:bloc/bloc.dart';
import 'package:vaccine_hk/map/entity/CenterInfo.dart';
import 'package:vaccine_hk/map/state/app_state.dart';

class AppCubit extends Cubit<AppState> {
  // ignore: public_member_api_docs
  AppCubit() : super(AppStateReady(null, {}));

  void selectMarker(CenterInfo selected) {
    if (state is AppStateReady) {
      print('selected marker: $selected');
      var newState = (state as AppStateReady).copyWith(marker: selected);
      print('emit new state: $newState');
      emit(newState);
    }
  }

  void init() {
    emit(AppStateReady(null, {}));
  }

// void decrement() => emit(state - 1);
}
