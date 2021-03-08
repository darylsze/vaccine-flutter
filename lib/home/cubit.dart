import 'package:bloc/bloc.dart';
import 'package:flutter_counter/home/state.dart';
import 'package:flutter_counter/repo/repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(true, DateTime.now(), null));

  void selectVaccine(Vaccine selected) {
    emit(state.copyWith(currentVaccine: selected));
  }
}
