import 'package:flutter/material.dart';
import 'package:scorely/uiLayer/More/more.dart';
import 'package:scorely/uiLayer/news/news.dart';
import 'package:scorely/uiLayer/screens/tab_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  static const String routeName = '/actual-home-screen';
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _page = 0;
  double bottombarWidth = 35;
  double barborderwidth = 3;

  List<Widget> pages = [const Home(), const News(), const More()];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Color(0xFF6E6E6E),
        backgroundColor: Colors.white,
        iconSize: 24,
        onTap: updatePage,

        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottombarWidth,
              decoration: BoxDecoration(),
              child: const Icon(Icons.home),
            ),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Container(
              width: bottombarWidth,
              decoration: BoxDecoration(),
              child: const Icon(Icons.newspaper),
            ),
            label: 'News',
          ),

          BottomNavigationBarItem(
            icon: Container(
              width: bottombarWidth,
              decoration: BoxDecoration(),
              child: const Icon(Icons.more_vert),
            ),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
