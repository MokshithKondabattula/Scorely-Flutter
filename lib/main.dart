import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scorely/ui/multimatches/match_current.dart';
import 'package:scorely/ui/screens/home_screen.dart';
import 'package:scorely/ui/screens/splash_screen.dart';
import 'package:scorely/ui/screens/tab_screen.dart'; // If used somewhere

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0087FF),
      systemNavigationBarColor: Color(0xFF0087FF),
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showHome = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() => _showHome = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0087FF),
        useMaterial3: true,
      ),

      home: _showHome ? const Home() : const SplashView(),

      routes: {
        '/home': (context) => const Home(),
        '/series': (context) => const HomePage(),
        '/current': (context) => const Match(),
        '/splash': (context) => const SplashView(),
      },
    );
  }
}
