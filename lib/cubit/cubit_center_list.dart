import 'package:bloc/bloc.dart';
import 'package:vaccine_hk/presentation/centerList/state.dart';
import 'package:vaccine_hk/repo/repo.dart';
import 'package:vaccine_hk/viewModel/index.dart';

class CenterListCubit extends Cubit<HomeState> {
  CenterListCubit()
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
    List<VaccineModel> differences = this
        .where((element) => current.vaccine != element.vaccine)
        .toList() ?? [];
    differences.sort();
    return differences.first;
  }
}
