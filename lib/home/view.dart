import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/home/cubit.dart';
import 'package:flutter_counter/home/state.dart';

class HomeView extends StatelessWidget {
  HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return DefaultTabController(
        length: state.allVaccineDates.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('AppBar Demo'),
            actions: [],
            bottom: TabBar(
              isScrollable: true,
              tabs: state.allVaccineDates.map((e) {
                return Tab(
                  child: Text("${e.day}"),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: state.allVaccineDates.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${e.day}"),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
