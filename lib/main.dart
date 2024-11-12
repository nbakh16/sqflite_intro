import 'package:flutter/material.dart';
import 'package:sqflite_intro/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFLite Note',
      home: const HomeView(),
    );
  }
}
