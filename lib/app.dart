import 'package:flutter/material.dart';
import 'package:flutter_counter/map/view/map_page.dart';

class CounterApp extends MaterialApp {
  /// {@macro counter_app}
  const CounterApp({Key? key}) : super(key: key, home: const MapPage());
}
