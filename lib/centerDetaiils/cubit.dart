import 'package:bloc/bloc.dart';
import 'package:flutter_counter/centerDetaiils/state.dart';
import 'package:flutter_counter/centerDetaiils/viewModel.dart';

class CenterDetailsCubit extends Cubit<CenterDetailsState> {
  CenterDetailsCubit() : super(CenterDetailsState());

  void selectCenter(CenterDetailsModel center) {
    emit(CenterDetailsState(currentCenter: center));
  }
}
