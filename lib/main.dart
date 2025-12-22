import 'package:flutter/material.dart';
import 'package:t5_1/view/home_screen.dart';

void main() async{
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
