import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';
import 'viewModel.dart';

class CenterDetailsCubit extends Cubit<CenterDetailsState> {
  CenterDetailsCubit() : super(CenterDetailsState(currentCenter: null, isCenterSubscribed: false));

  void selectCenter(CenterDetailsModel center) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasCenterSubscribed =
        (prefs.getStringList("centerNames") ?? []).any((element) => element == center.cName);
    emit(state.copyWith(newCurrentCenter: center, newIsSubscribed: hasCenterSubscribed));
  }

  void subscribe(CenterDetailsModel center) async {
    bool isSuccessful = await CenterDetailsViewModel().subscribeToCenter(center);
    if (isSuccessful) {
      emit(state.copyWith(newIsSubscribed: true));
    }
  }

  void unsubscribe(CenterDetailsModel center) async {
    bool isSuccessful = await CenterDetailsViewModel().unsubscribeToCenter(center);
    if (isSuccessful) {
      emit(state.copyWith(newIsSubscribed: false));
    }
  }
}
