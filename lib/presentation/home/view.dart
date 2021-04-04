import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_hk/presentation/MessageHandler.dart';
import 'package:vaccine_hk/presentation/articleDetails/article_details_page.dart';
import 'package:vaccine_hk/presentation/articles/article_list_page.dart';
import 'package:vaccine_hk/presentation/centerList/page.dart';
import 'package:vaccine_hk/widgets/index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  HomePage();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("on push click to open app: $message");
      if (message.data.containsKey("id") &&
          message.data.containsKey("path") &&
          (message.data['path'] as String).contains("/articles/")) {
        Navigator.pushNamed(
          context,
          ArticleDetailsPage.routeName,
          arguments: ArticleDetailsPageArguments(message.data['id'] as String),
        );
      } else {
        print("either id or path not satifished, skip navigation");
      }
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // fixme ordering
  final List<Widget> _widgetOptions = <Widget>[
    CenterList(),
    ArticleListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首頁',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '最新消息',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
