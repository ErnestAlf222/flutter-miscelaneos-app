import 'package:flutter/material.dart';
import 'package:miscelaneos/config/config.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text('Hello world!'),
        ),
      ),
    );
  }
}
