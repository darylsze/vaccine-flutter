import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';
import 'view.dart';
import 'viewModel.dart';

class CenterDetailsPageArguments {
  final String cName;

  CenterDetailsPageArguments({required this.cName});
}

class CenterDetailsPage extends StatelessWidget {
  static const routeName = '/centers/details';

  CenterDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CenterDetailsPageArguments args =
        ModalRoute.of(context)!.settings.arguments as CenterDetailsPageArguments;
    print("args: ${args.cName}");

    return BlocProvider(
      create: (_) => CenterDetailsCubit(),
      child: FutureBuilder(
          future: CenterDetailsViewModel().getCenterDetailsFromName(cName: args.cName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              context.read<CenterDetailsCubit>().selectCenter(snapshot.data as CenterDetailsModel);
              print("snapshot.data: ${(snapshot.data as CenterDetailsModel).cName}");
              return CenterDetailView();
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
