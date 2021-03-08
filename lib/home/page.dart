import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/home/cubit.dart';
import 'package:flutter_counter/home/view.dart';
import 'package:flutter_counter/repo/repo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => HomeCubit(),
        child: MaterialApp(
          title: "_title",
          home: FutureBuilder(
              future: Repo().getAllVaccineInfos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return HomeView(snapshot.data as Vaccines);
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }
                return Center(child: CircularProgressIndicator());
              }),
        ));
  }
}
