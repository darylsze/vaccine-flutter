import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_hk/centerDetails/page.dart';

import 'home/page.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          print(snapshot);
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
              });
        });
  }
}
