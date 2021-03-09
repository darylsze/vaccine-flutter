import 'package:flutter_counter/home/representation.dart';
import 'package:flutter_counter/repo/repo.dart';

class HomeState {
  bool shouldShowAvailableCenterOnly = true;
  DateTime selectedDateTime = DateTime.now();
  VaccineModel? selectedVaccine;
  List<DateTime> allDates = [];
  List<DatePageModel> allPages = [];

  HomeState(
      this.shouldShowAvailableCenterOnly,
      this.selectedDateTime,
      this.selectedVaccine,
      this.allDates,
      this.allPages
  );

  HomeState copyWith({
    required VaccineModel currentVaccine
  }) {
      return HomeState(
          shouldShowAvailableCenterOnly,
          selectedDateTime,
          currentVaccine,
          currentVaccine.datePage.map((e) => e.date).toList()..sort(),
          currentVaccine.datePage.toList()
      );
  }
}
