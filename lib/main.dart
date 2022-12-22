import 'package:flutter/material.dart';
import 'package:flutter_maps/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Near Me'),
        ),
        body: Column(
          children: [Home()],
        ),
      ),
    );
  }
}
