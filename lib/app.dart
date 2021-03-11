import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_hk/app/state.dart';
import 'package:vaccine_hk/centerDetails/page.dart';

import 'app/cubit.dart';
import 'home/page.dart';

class ApplicationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit(),
      child: Application(),
    );
  }
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) => FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
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
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
