import 'package:vaccine_hk/home/viewModel.dart';

enum HomeMenuBottom {
  SHOW_AVAILABLE, SHOW_ALL
}
class HomeState {
  int version = 1;
  bool shouldShowAvailableCenterOnly = true;
  DateTime selectedDateTime = DateTime.now();
  VaccineModel? selectedVaccine;
  List<DateTime> allDates = [];
  List<DatePageModel> allPages = [];
  List<VaccineModel> allVaccines = [];
  bool showAvailableOnly = true;

  HomeState(
      {required this.allVaccines,
      required this.version,
      required this.shouldShowAvailableCenterOnly,
      required this.selectedDateTime,
      this.selectedVaccine,
      required this.allDates,
      required this.allPages,
      required this.showAvailableOnly});

  HomeState copyWith({List<VaccineModel>? newAllVaccines, VaccineModel? newVaccine, bool? newShowAvailableOnly = true}) {
    List<DateTime> newDates =
        newVaccine == null ? allDates : newVaccine.datePage.map((e) => e.date).toList()
          ..sort();
    List<DatePageModel> newPages = newVaccine == null ? allPages : newVaccine.datePage.toList();

    return HomeState(
        allVaccines: newAllVaccines ?? allVaccines,
        version: version,
        shouldShowAvailableCenterOnly: shouldShowAvailableCenterOnly,
        selectedDateTime: selectedDateTime,
        selectedVaccine: newVaccine ?? selectedVaccine,
        allDates: newDates,
        allPages: newPages,
        showAvailableOnly: newShowAvailableOnly ?? showAvailableOnly);
  }

  HomeState refresh() {
    return HomeState(
        allVaccines: allVaccines,
        version: version + 1,
        shouldShowAvailableCenterOnly: shouldShowAvailableCenterOnly,
        selectedDateTime: selectedDateTime,
        selectedVaccine: selectedVaccine,
        allDates: allDates,
        allPages: allPages,
        showAvailableOnly: showAvailableOnly);
  }
}
