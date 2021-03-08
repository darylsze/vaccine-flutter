import 'package:flutter_counter/repo/repo.dart';

class HomeState {
  bool shouldShowAvailableCenterOnly = true;
  DateTime selectedDateTime = DateTime.now();
  Vaccine? selectedVaccine;

  HomeState(this.shouldShowAvailableCenterOnly, this.selectedDateTime, this.selectedVaccine);

  HomeState copyWith({required Vaccine currentVaccine}) {
      return HomeState(shouldShowAvailableCenterOnly, selectedDateTime, currentVaccine);
  }
}
