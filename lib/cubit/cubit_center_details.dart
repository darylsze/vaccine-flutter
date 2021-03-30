import 'package:bloc/bloc.dart';
import 'package:vaccine_hk/presentation/centerDetails/state.dart';
import 'package:vaccine_hk/viewModel/index.dart';


class CenterDetailsCubit extends Cubit<CenterDetailsState> {
  CenterDetailsCubit() : super(CenterDetailsState(currentCenter: null, isCenterSubscribed: false));

  void selectCenter(CenterDetailsModel center) async {
    print("current center: ${center.hasSubscribed}");
    emit(state.copyWith(newCurrentCenter: center, newIsSubscribed: center.hasSubscribed));
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
