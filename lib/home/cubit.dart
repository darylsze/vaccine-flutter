import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_hk/home/state.dart';
import 'package:vaccine_hk/home/viewModel.dart';
import 'package:vaccine_hk/repo/repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
            allVaccines: [],
            version: 1,
            shouldShowAvailableCenterOnly: true,
            selectedDateTime: DateTime.now(),
            allPages: [],
            allDates: [],
      showAvailableOnly: true));

  void setAllVaccines(Set<VaccineModel> allVaccines) {
    emit(state.copyWith(
      newAllVaccines: allVaccines.toList(),
      newVaccine: allVaccines.first
    ));
  }

  void refreshPage() {
    emit(state.refresh());
  }

  void switchVaccine() {
    emit(state.copyWith(
      newVaccine: state.allVaccines.next(current: state.selectedVaccine!)
    ));
  }

  // no filter
  Future<Set<VaccineModel>> getVaccineModels() async {
    Set<MyCenter> centers = await Repo().getAllVaccineInfos();
    return HomeViewModel.from(centers).getVaccineModels();
  }
}

extension VaccineExtensions on List<VaccineModel> {
  VaccineModel next({ required VaccineModel current }) {
    List<VaccineModel> differences = this.where((element) => element.vaccine != current.vaccine).toList() ?? [];
    differences.sort();
    return differences.first;
  }
}
