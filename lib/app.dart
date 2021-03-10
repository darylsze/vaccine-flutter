import 'package:flutter/material.dart';
import 'package:flutter_counter/centerDetaiils/page.dart';
import 'home/page.dart';

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.teal[700],
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          // additional settings go here
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          CenterDetailsPage.routeName: (context) => CenterDetailsPage()
        }
    );
  }
}
