import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poetry app',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Poetry app"),
        ),
        body: const Center(child: Text("Poetry app")),
      ),
    );
  }
}
