import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/map/cubit/app_cubit.dart';
import 'package:flutter_counter/map/view/map_view.dart';

class MapPage extends StatelessWidget {
  /// {@macro counter_page}
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit(),
      child: MapView(),
    );
  }
}
