import 'package:flutter/material.dart';
import 'package:t5_1/view/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:t5_1/viewmodel/viewmodel.dart';

void main() async{
  runApp(
    ChangeNotifierProvider(
      create: (_) => Viewmodel(),
      child: MyApp(),
      )
  );
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
