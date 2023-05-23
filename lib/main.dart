import 'package:flutter/material.dart';
import 'RechargeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RechargeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
