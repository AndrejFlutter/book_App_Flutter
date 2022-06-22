import 'package:flutter/material.dart';
import 'package:kniha_test_app/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Book App - Andrej',
      theme: ThemeData(
        backgroundColor: Colors.white12,
        primarySwatch: Colors.purple,
      ),
      home: const HomeScreen(),
    );
  }
}
