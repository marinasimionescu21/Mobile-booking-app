import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(context) {
    return const Scaffold(
      body: Column(
        children: [
          Text('Home Screen'),
          Text('The chart'),
        ],
      ),
    );
  }
}
