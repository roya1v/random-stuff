import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:til_app/facts_page.dart';
import 'package:til_app/til_cubit.dart';

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
      home: BlocProvider(
        create: (context) => TilCubit(),
        child: const FactsPage(),
      ),
    );
  }
}
