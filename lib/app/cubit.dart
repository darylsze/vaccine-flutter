import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_hk/app/state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(currentTheme: ThemeMode.light));

  void changeTheme(ThemeMode newMode) {
    emit(state.copyWith(newTheme: newMode));
  }

}
