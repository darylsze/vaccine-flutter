import 'package:flutter/material.dart';
import 'package:flutter_counter/home/cubit.dart';
import 'package:flutter_counter/home/state.dart';
import 'package:flutter_counter/repo/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  Vaccines vaccines;

  HomeView(
      this.vaccines); // TabController _tabController = TabController(length: tabs.length, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Demo'),
        actions: [
          PopupMenuButton<Vaccine>(
              onSelected: (Vaccine result) => context.read<HomeCubit>().selectVaccine(result),
              itemBuilder: (BuildContext context) {
                var items = vaccines.vaccines.map((item) {
                  return PopupMenuItem<Vaccine>(
                    value: item,
                    child: Text(item.name),
                  );
                }).toList();
                return <PopupMenuEntry<Vaccine>>[...items];
              }
          )
        ],
        // bottom: TabBar(
        //   tabs: <Widget>[new Text("text"), new Text("text 2")],
        // ),
      ),
      body: Center(
        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          if (state.selectedVaccine == null) {
            return Text('no selected vaccine');
          } else {
            return Text("selected vaccine: ${state.selectedVaccine!.name}");
          }
        }),
      ),
    );
  }
}
