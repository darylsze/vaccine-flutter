import 'package:bloc/bloc.dart';
import 'package:flutter_counter/home/representation.dart';
import 'package:flutter_counter/home/state.dart';
import 'package:flutter_counter/repo/repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(true, DateTime.now(), null, {}));

  void selectVaccine(VaccineModel selected) {
    emit(state.copyWith(currentVaccine: selected));
  }

  Future<Set<VaccineModel>> getVaccines() async {
    Set<MyCenter> centers = await Repo().getAllVaccineInfos();
    return HomeViewModel.from(centers).getVaccineModels();
  }
}
