import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_hk/home/cubit.dart';
import 'package:vaccine_hk/home/view.dart';
import 'package:vaccine_hk/home/viewModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: FutureBuilder(
        future: HomeCubit().getVaccineModels(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data)
            context.read<HomeCubit>().selectVaccine((snapshot.data as Set<VaccineModel>).first);
            return HomeView();
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
