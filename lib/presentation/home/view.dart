import 'package:flutter/material.dart';
import 'package:vaccine_hk/presentation/articles/article_page.dart';
import 'package:vaccine_hk/presentation/centerList/page.dart';
import 'package:vaccine_hk/widgets/index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  HomePage();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // fixme ordering
  final List<Widget> _widgetOptions = <Widget>[
    ArticlePage(),
    CenterList(),
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
