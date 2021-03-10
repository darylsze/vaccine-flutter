
import 'viewModel.dart';

class CenterDetailsState {
  CenterDetailsModel? currentCenter;
  bool isCenterSubscribed = false;

  CenterDetailsState({required this.currentCenter, required this.isCenterSubscribed});

  CenterDetailsState copyWith({CenterDetailsModel? newCurrentCenter, bool? newIsSubscribed}) {
    return CenterDetailsState(
        currentCenter: newCurrentCenter ?? currentCenter,
        isCenterSubscribed: newIsSubscribed ?? isCenterSubscribed);
  }
}
