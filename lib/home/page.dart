import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_hk/app/cubit.dart';
import 'package:vaccine_hk/home/cubit.dart';
import 'package:vaccine_hk/home/view.dart';
import 'package:vaccine_hk/home/viewModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
        child: BlocProvider(
          create: (_) => AppCubit(),
          child: FutureBuilder(
            future: HomeCubit().getVaccineModels(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data)
                context.read<HomeCubit>().setAllVaccines(snapshot.data as Set<VaccineModel>);
                // return Scaffold(
                //   appBar: AppBar(title: Text("abncd")),
                //   drawer: Drawer(),
                //   body: HomeView(),
                // );
                return HomeView();
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
