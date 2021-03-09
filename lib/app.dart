import 'package:flutter/material.dart';
import 'package:flutter_counter/centerDetaiils/page.dart';
import 'home/page.dart';

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          CenterDetailsPage.routeName: (context) => CenterDetailsPage()
        }
    );
  }
}
