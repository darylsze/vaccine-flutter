import 'package:bloc/bloc.dart';
import 'package:vaccine_hk/home/viewModel.dart';
import 'package:vaccine_hk/home/state.dart';
import 'package:vaccine_hk/repo/repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
            shouldShowAvailableCenterOnly: true,
            selectedDateTime: DateTime.now(),
            allPages: [],
            allDates: [],
            showAvailableOnly: true));

  void selectVaccine(VaccineModel selected) {
    emit(state.copyWith(currentVaccine: selected));
  }

  // no filter
  Future<Set<VaccineModel>> getVaccineModels() async {
    Set<MyCenter> centers = await Repo().getAllVaccineInfos();
    return HomeViewModel.from(centers).getVaccineModels();
  }
}
