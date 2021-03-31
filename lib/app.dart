import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_hk/presentation/app/state.dart';
import 'package:vaccine_hk/presentation/articleDetails/article_details_page.dart';
import 'package:vaccine_hk/presentation/centerDetails/page.dart';
import 'package:vaccine_hk/presentation/home/view.dart';

import 'cubit/index.dart';

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
                    primaryColor: Colors.black
                    // additional settings go here
                  ),
                  initialRoute: '/',
                  routes: {
                    // '/': (context) => ArticleDetailsPage()
                    '/': (context) => HomePage(),
                    CenterDetailsPage.routeName: (context) => CenterDetailsPage(),
                    ArticleDetailsPage.routeName: (context) => ArticleDetailsPage()
                  });
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
