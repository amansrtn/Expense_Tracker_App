import 'package:expense_tracking/widgets/expenses_homepage.dart';
import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 13, 8, 71),
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 13, 8, 71)),
      ),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(useMaterial3: true),
      themeMode: ThemeMode.light,
    );
  }
}
