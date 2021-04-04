import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_hk/presentation/centerList/view.dart';
import 'package:vaccine_hk/cubit/index.dart';
import 'package:vaccine_hk/viewModel/index.dart';
import 'package:vaccine_hk/widgets/error_retry_dialog.dart';

class CenterList extends StatelessWidget {
  CenterList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CenterListCubit(),
      child: BlocProvider(
        create: (_) => AppCubit(),
        child: FutureBuilder(
          future: CenterListCubit().getVaccineModels(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // print(snapshot.data)
              context.read<CenterListCubit>().setAllVaccines(snapshot.data as Set<VaccineModel>);
              // return Scaffold(
              //   appBar: AppBar(title: Text("abncd")),
              //   drawer: Drawer(),
              //   body: HomeView(),
              // );
              return CenterListView();
            } else if (snapshot.hasError) {
              FirebaseCrashlytics.instance.recordError(snapshot.error, StackTrace.current);
              return ErrorRetryDialogWidget();
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

}
