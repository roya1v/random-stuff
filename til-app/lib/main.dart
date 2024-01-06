import 'package:flutter/material.dart';
import 'package:til_app/facts_page.dart';

void main() {
  runApp(const TilApp());
}

class TilApp extends StatelessWidget {
  const TilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FactsPage(),
    );
  }
}
