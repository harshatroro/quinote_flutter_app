import 'package:flutter/material.dart';
import 'package:quinote_flutter_app/pages/home_page.dart';
import 'package:quinote_flutter_app/theme/color_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}