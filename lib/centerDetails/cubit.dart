import 'package:bloc/bloc.dart';

import 'state.dart';
import 'viewModel.dart';

class CenterDetailsCubit extends Cubit<CenterDetailsState> {
  CenterDetailsCubit() : super(CenterDetailsState());

  void selectCenter(CenterDetailsModel center) {
    emit(CenterDetailsState(currentCenter: center));
  }
}
