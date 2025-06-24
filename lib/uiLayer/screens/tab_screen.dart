import 'package:flutter/material.dart';
import 'package:scorely/uiLayer/featured/match_current.dart';
import 'package:scorely/uiLayer/screens/upcoming_feedscreen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            backgroundColor: const Color(0xFF0087FF),
            elevation: 0.0,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.only(left: 14.0, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/splash_screen_logo.png', height: 45),
                  Row(
                    children: const [
                      Icon(Icons.notifications_none, color: Colors.white),
                      SizedBox(width: 16),
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(width: 17),
                    ],
                  ),
                ],
              ),
            ),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xFFB3E5FC),
              labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
              tabs: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('FEATURED'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('UPCOMING'),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(children: [Match(), HomePage()]),
      ),
    );
  }
}
