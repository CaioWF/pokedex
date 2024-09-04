import 'package:flutter/material.dart';
import 'package:pokedex/src/presenter/home/home.dart';
import 'package:pokedex/src/shared/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
