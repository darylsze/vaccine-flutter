import 'package:flutter/material.dart';
import 'home/page.dart';

class CounterApp extends MaterialApp {
  /// {@macro counter_app}
  const CounterApp({Key? key}) : super(key: key, home: const HomePage());
}
