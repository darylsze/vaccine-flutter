import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_hk/cubit/cubit_map_details.dart';
import 'package:vaccine_hk/presentation/map/map_view.dart';

class MapPage extends StatelessWidget {
  /// {@macro counter_page}
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapDetailsCubit(),
      child: MapView(),
    );
  }
}
