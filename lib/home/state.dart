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
  bool showAvailableOnly = true;

  HomeState(
      {
        required this.version,
        required this.shouldShowAvailableCenterOnly,
      required this.selectedDateTime,
      this.selectedVaccine,
      required this.allDates,
      required this.allPages,
      required this.showAvailableOnly});

  HomeState copyWith({required VaccineModel currentVaccine, bool showAvailableOnly = true}) {
    return HomeState(
        version: version,
        shouldShowAvailableCenterOnly: shouldShowAvailableCenterOnly,
        selectedDateTime: selectedDateTime,
        selectedVaccine: currentVaccine,
        allDates: currentVaccine.datePage.map((e) => e.date).toList()..sort(),
        allPages: currentVaccine.datePage.toList(),
        showAvailableOnly: showAvailableOnly);
  }

  HomeState refresh() {
    return HomeState(
        version: version + 1,
        shouldShowAvailableCenterOnly: shouldShowAvailableCenterOnly,
        selectedDateTime: selectedDateTime,
        selectedVaccine: selectedVaccine,
        allDates: allDates,
        allPages: allPages,
        showAvailableOnly: showAvailableOnly);
  }
}
