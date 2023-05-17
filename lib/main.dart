import 'package:flutter/material.dart';
import 'package:flutter_firebase_pagination/reservationScreen.dart';



void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReservationScreen(),
      debugShowCheckedModeBanner: false,
    );
    
  }
}