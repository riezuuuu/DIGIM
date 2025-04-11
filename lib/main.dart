import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(DisasterNowApp());
}

class DisasterNowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disaster Now',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
