import 'package:vaccine_hk/home/viewModel.dart';

enum HomeMenuBottom {
  SHOW_AVAILABLE, SHOW_ALL
}
class HomeState {
  bool shouldShowAvailableCenterOnly = true;
  DateTime selectedDateTime = DateTime.now();
  VaccineModel? selectedVaccine;
  List<DateTime> allDates = [];
  List<DatePageModel> allPages = [];
  bool showAvailableOnly = true;

  HomeState(
      {required this.shouldShowAvailableCenterOnly,
      required this.selectedDateTime,
      this.selectedVaccine,
      required this.allDates,
      required this.allPages,
      required this.showAvailableOnly});

  HomeState copyWith({required VaccineModel currentVaccine, bool showAvailableOnly = true}) {
    return HomeState(
        shouldShowAvailableCenterOnly: shouldShowAvailableCenterOnly,
        selectedDateTime: selectedDateTime,
        selectedVaccine: currentVaccine,
        allDates: currentVaccine.datePage.map((e) => e.date).toList()..sort(),
        allPages: currentVaccine.datePage.toList(),
        showAvailableOnly: showAvailableOnly);
  }
}
