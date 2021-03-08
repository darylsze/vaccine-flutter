import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/home/cubit.dart';
import 'package:flutter_counter/home/representation.dart';
import 'package:flutter_counter/home/state.dart';

class HomeView extends StatelessWidget {
  Set<VaccineModel> vaccines;

  HomeView(this.vaccines);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: vaccines.length,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('AppBar Demo'),
            actions: [
              PopupMenuButton<VaccineModel>(
                  onSelected: (VaccineModel result) =>
                      context.read<HomeCubit>().selectVaccine(result),
                  itemBuilder: (BuildContext context) {
                    var items = vaccines.map((item) {
                      return PopupMenuItem<VaccineModel>(
                        value: item,
                        child: Text(item.vaccine),
                      );
                    }).toList();
                    return <PopupMenuEntry<VaccineModel>>[...items];
                  })
            ],
            bottom: TabBar(
              isScrollable: true,
              tabs: state.allVaccineDates
                  .map(
                    (e) => Text('${e.day/e.month}'),
                  )
                  .toList(),
            ),
          ),
          body: TabBarView(
            children: [
              Text("abcd"),
            ],
          ),
        ),
      ),
    );
  }
}
